IF OBJECT_ID('dbo.D_Date', 'U') IS NOT NULL
    DROP TABLE dbo.D_Date;
GO

-- Tạo bảng D_Date
CREATE TABLE dbo.D_Date (
    DateKey INT NOT NULL PRIMARY KEY,       -- YYYYMMDD
    FullDate DATE NOT NULL,                 -- Ngày đầy đủ
    Day INT NOT NULL,                       -- Ngày trong tháng
    DayOfWeek INT NOT NULL,                 -- Thứ trong tuần (1=Chủ Nhật, 2=Thứ 2,...)
    DayName NVARCHAR(20) NOT NULL,          -- Tên thứ (Monday, Tuesday,...)
    WeekOfYear INT NOT NULL,                -- Tuần trong năm
    Month INT NOT NULL,                     -- Tháng số
    MonthName NVARCHAR(20) NOT NULL,        -- Tên tháng
    Quarter INT NOT NULL,                   -- Quý
    Year INT NOT NULL,                      -- Năm
    IsWeekend BIT NOT NULL,                 -- 1 nếu cuối tuần, 0 nếu ngày thường
    FiscalYear INT NULL,                    -- Năm tài chính (tùy chỉnh)
    FiscalQuarter INT NULL                  -- Quý tài chính (tùy chỉnh)
);
GO

-- Thiết lập khoảng thời gian (tùy chỉnh theo dự án)
DECLARE @StartDate DATE = '2015-01-01';  -- Ngày bắt đầu
DECLARE @EndDate   DATE = '2030-12-31';  -- Ngày kết thúc

;WITH DateRange AS (
    SELECT @StartDate AS FullDate
    UNION ALL
    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateRange
    WHERE FullDate < @EndDate
)
INSERT INTO dbo.D_Date (
    DateKey,
    FullDate,
    Day,
    DayOfWeek,
    DayName,
    WeekOfYear,
    Month,
    MonthName,
    Quarter,
    Year,
    IsWeekend,
    FiscalYear,
    FiscalQuarter
)
SELECT
    CONVERT(INT, FORMAT(FullDate, 'yyyyMMdd')) AS DateKey,
    FullDate,
    DAY(FullDate) AS Day,
    DATEPART(WEEKDAY, FullDate) AS DayOfWeek,
    DATENAME(WEEKDAY, FullDate) AS DayName,
    DATEPART(WEEK, FullDate) AS WeekOfYear,
    MONTH(FullDate) AS Month,
    DATENAME(MONTH, FullDate) AS MonthName,
    DATEPART(QUARTER, FullDate) AS Quarter,
    YEAR(FullDate) AS Year,
    CASE WHEN DATEPART(WEEKDAY, FullDate) IN (1,7) THEN 1 ELSE 0 END AS IsWeekend, -- 1=CN,7=Thứ 7
    YEAR(FullDate) AS FiscalYear,   -- Tuỳ chỉnh quy tắc năm tài chính
    DATEPART(QUARTER, FullDate) AS FiscalQuarter
FROM DateRange
OPTION (MAXRECURSION 0);


ALTER TABLE F_Order
ADD OrderDateKey INT;

UPDATE F_Order
SET OrderDateKey = CONVERT(INT, FORMAT([Order Date], 'yyyyMMdd'));

alter table F_Order
add constraint fk_datekey foreign key(OrderDateKey) references D_Date(DateKey)

