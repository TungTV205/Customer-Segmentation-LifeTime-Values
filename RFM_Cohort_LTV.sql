-- Bảng tổng hợp đơn hàng 
select 
	[Customer ID],
	[Order ID],
	[Order Date],
	sum(Sales) as Revenue
into #Retail
from F_Order
group by [Customer ID], [Order Date], [Order ID]


--1. Tính RFM Cho từng khách hàng và chia nhóm
;with RFMBase as ( --Xác định các trường RFM
	select
		[Customer ID],
		DATEDIFF(day, max([Order Date]), '2014-12-31') as Recency,
		count(distinct [Order ID]) as Frequency,
		sum(Revenue) as Monetary
	from #Retail
	group by [Customer ID]
),
RFMScore as ( --Chấm điểm cho R-F-M thông qua phương pháp phân vị
	select *,
		NTILE(5) over (order by Recency desc) as Recent_Score,
		NTILE(5) over (order by Frequency asc) as Freq_Score,
		NTILE(5) over (order by Monetary asc) as Money_Score
	from RFMBase
),
RFMGroup AS ( --Đánh giá các hạng điểm và phân nhóm
    select
        *,
        CASE
            WHEN Recent_Score >= 4 AND Freq_Score >= 4 AND Money_Score >= 4 THEN 'Champions'--rất tốt ở cả 3 trục
            WHEN Recent_Score >= 3 AND Freq_Score >= 3 THEN 'Loyal Customers'--mua thường xuyên gần đây
            WHEN Recent_Score >= 4 AND Freq_Score <= 2 THEN 'New Customers'--mới mua gần đây nhưng tần suất thấp
            WHEN Recent_Score BETWEEN 2 AND 3 AND (Freq_Score >= 2 OR Money_Score >= 3) THEN 'At Risk'--gần đây ít mua nhưng trước đây có Frequency hoặc Monetary khá
            WHEN Recent_Score <= 3 THEN 'Lost'
        END AS [Group]
    from RFMScore
)
select * into RFM_Group from RFMGroup


--2. Xác định các nhóm Cohort
;with CohortBase as (
	select
		[Customer ID],
		[Order ID],
		[Order Date],
		Revenue,
		DATEFROMPARTS(YEAR([Order Date]), MONTH([Order Date]), 1) as [Order Month]
	from #Retail
),
CohortDate as (
	select
		[Customer ID],
		MIN([Order Month]) as [Cohort Month]
	from CohortBase
	group by [Customer ID]
),
RFM_Table as (
	select
		[Customer ID],
		[Group]
	from RFM_Group
),
CohortData as (
	select
		cd.[Customer ID],
		cb.Revenue,
		rfm.[Group],
		cd.[Cohort Month],
		DATEDIFF(Month, cd.[Cohort Month], cb.[Order Month]) as [Cohort Index]
	from CohortBase cb
	left join CohortDate cd on cb.[Customer ID] = cd.[Customer ID]
	left join RFM_Table rfm on cb.[Customer ID] = rfm.[Customer ID]
)
select * into Cohort_Data from CohortData


--3. Tính rev theo từng Cohort và từng nhóm RFM
;with CohortSizeByRFM as ( --Số lượng khách hàng trong tháng đầu tiên theo các nhóm RFM 
	select
		[Group],
		COUNT(distinct [Customer ID]) as UserFirstMonth
	from Cohort_Data
	group by [Group]
),
RevenueByRFM as ( --Tổng doanh thu theo từng nhóm RFM ở các mốc thời gian
	select
		[Group],
		[Cohort Index],
		SUM(Revenue) as TotalRevenue
	from Cohort_Data
	group by [Group], [Cohort Index]
),
LTV_Calculate as ( --Tính LTV tích lũy theo nhóm RFM và Cohort Index
	select
		crfm.[Group],
		rev.[Cohort Index],
		crfm.UserFirstMonth,
		rev.TotalRevenue,
		SUM(rev.TotalRevenue) OVER (PARTITION BY crfm.[Group] ORDER BY rev.[Cohort Index]) AS
		AccTotalRevenue,
		ROUND(1.0 * SUM(rev.TotalRevenue) OVER (PARTITION BY crfm.[Group] ORDER BY rev.[Cohort Index]) /
		crfm.UserFirstMonth, 2) AS LTV
	from CohortSizeByRFM crfm 
	join RevenueByRFM rev on crfm.[Group] = rev.[Group]
)
select * into LTV_Data from LTV_Calculate
