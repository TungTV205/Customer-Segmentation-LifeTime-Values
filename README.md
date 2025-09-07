# Customer Behavior & Lifetime Value Analysis (SQL + Power BI)

## 🎯 Mục tiêu
Dự án này nhằm **phân tích hành vi khách hàng và giá trị họ mang lại trong suốt vòng đời mua hàng**.  
Thông qua dữ liệu bán lẻ, mình áp dụng các phương pháp phân tích khách hàng phổ biến trong kinh doanh:
- **RFM Segmentation**: phân loại khách hàng theo Recency - Frequency - Monetary.
- **Cohort Analysis**: theo dõi hành vi khách hàng theo nhóm thời gian gia nhập.
- **Customer Lifetime Value (LTV)**: tính giá trị trung bình mỗi khách hàng mang lại trong vòng đời mua sắm.

## 🛠️ Công nghệ sử dụng
- **SQL Server**: xử lý dữ liệu, tính toán phân tích RFM, Cohort, và LTV.  
- **Power BI**: tạo report báo cáo đưa insight.  
- **Excel/CSV Dataset**: dữ liệu bán lẻ Global SuperStore public trên nển tảng Kaggle.  

## 🔄 Pipeline Phân Tích
1. **Tiền xử lý dữ liệu**: tổng hợp đơn hàng thành bảng `#Retail` gồm `Customer ID`, `Order ID`, `Order Date`, `Revenue`.  
2. **RFM Segmentation**:
   - Tính toán Recency, Frequency, Monetary cho từng khách hàng.
   - Áp dụng phương pháp phân vị (NTILE) để chấm điểm 1–5.
   - Gán nhãn nhóm khách hàng: *Champions, Loyal Customers, New Customers, At Risk, Lost*.
3. **Cohort Analysis**:
   - Xác định tháng đầu tiên khách hàng mua hàng (Cohort Month).
   - Theo dõi hành vi & doanh thu của từng Cohort theo thời gian (Cohort Index).
4. **LTV Calculation**:
   - Tính doanh thu tích lũy của từng nhóm khách hàng (theo RFM + Cohort).
   - Chia cho số khách hàng gốc để ra **LTV trung bình**.

## 📊 Kết quả chính
- **Phân khúc khách hàng (RFM)**: xác định nhóm khách hàng giá trị cao (*Champions, Loyal*) so với nhóm có nguy cơ rời bỏ (*At Risk, Lost*).
- **Cohort Analysis**: đo lường tỷ lệ giữ chân khách hàng và xu hướng doanh thu theo thời gian.
- **LTV**: đánh giá giá trị vòng đời khách hàng giúp đưa ra chiến lược marketing và chăm sóc phù hợp.

## 🖼️ Dashboard Power BI
![alt text](image.png)

Dashboard bao gồm:
- Cơ cấu RFM segmentation. 
- Top sản phẩm mang lại 80% doanh thu.
- Biểu đồ Cohort (Retention theo Cohort Index).  
- Đường tăng trưởng LTV theo thời gian.  

## 🚀 Cách sử dụng
1. Import dữ liệu bán lẻ vào SQL Server (`data/`).
2. Chạy các script trong thư mục `sql/`:
   - `create_tables.sql`
   - `rfm_analysis.sql`
   - `cohort_ltv_analysis.sql`
3. Mở file Power BI trong thư mục `powerbi/` để xem dashboard (`report.pbix`).  

## 📂 Cấu trúc thư mục
