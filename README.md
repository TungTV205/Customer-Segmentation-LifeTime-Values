# 📌 Customer Behavior Analytics & Lifetime Value Prediction in Retail  
*(SQL + Power BI)*

---

## 📝 Executive Summary  
Ngành **bán lẻ** đang đối mặt với thách thức lớn: làm thế nào để **giữ chân khách hàng cũ** trong khi vẫn mở rộng tệp khách hàng mới.  
Phần lớn doanh thu thường đến từ một nhóm nhỏ khách hàng trung thành, nhưng các doanh nghiệp lại ít có chiến lược phân bổ nguồn lực dựa trên **Customer Lifetime Value (LTV)**.  

- **Vấn đề kinh doanh**: Công ty bán lẻ chưa nắm rõ *khách hàng nào mang lại giá trị cao nhất*, *khách hàng nào có nguy cơ rời bỏ*, và *chi phí hợp lý để giữ chân*.  
- **Giải pháp**: Xây dựng hệ thống phân tích hành vi khách hàng dựa trên **RFM Segmentation, Cohort Retention Analysis và LTV Estimation**, triển khai trực quan trên **Power BI** để hỗ trợ ra quyết định.  
- **Tác động**:  
  - Xác định được **20% khách hàng mang lại ~80% doanh thu** (nguyên tắc Pareto).  
  - Đo lường được **tỷ lệ giữ chân theo Cohort**, giúp thiết kế chiến dịch remarketing chính xác hơn.  
  - Ước lượng **LTV trung bình tăng 15%** nếu cải thiện tỷ lệ retention trong 3 tháng đầu.  
- **Next Steps**: Tích hợp dữ liệu từ CRM & kênh marketing để xây dựng mô hình **Customer Churn Prediction**.  

---

## 🎯 Business Problem  
Trong thị trường bán lẻ cạnh tranh khốc liệt, chi phí để có được một khách hàng mới (Customer Acquisition Cost) cao gấp nhiều lần chi phí giữ chân khách hàng cũ.  
Doanh nghiệp thiếu công cụ để:  
- Phân loại khách hàng theo giá trị.  
- Hiểu được hành vi theo thời gian (theo dõi cohort).  
- Tính toán giá trị vòng đời (LTV) để quyết định ngân sách marketing và chăm sóc khách hàng.  

**Tầm quan trọng**: Nếu không phân tích sâu, doanh nghiệp sẽ phân bổ nguồn lực marketing dàn trải, không tối ưu ROI.  

---

## 🔬 Methodology  
1. **RFM Segmentation**  
   - Phân loại khách hàng dựa trên *Recency, Frequency, Monetary* bằng SQL (NTILE + Window Functions).  
   - *Lý do chọn*: Phương pháp phổ biến, dễ hiểu, dễ triển khai cho business.  

2. **Cohort Analysis**  
   - Theo dõi hành vi và tỷ lệ retention của khách hàng theo tháng gia nhập.  
   - *Lý do chọn*: Cho phép đo lường loyalty và hiệu quả chiến dịch remarketing.  

3. **Customer Lifetime Value (LTV)**  
   - Tính tổng doanh thu trung bình mỗi khách hàng, mỗi nhóm RFM mang lại.  
   - *Lý do chọn*: Là thước đo quan trọng cho chiến lược marketing dài hạn.  

4. **Pareto Analysis (80/20 Rule)**  
   - Xác định nhóm sản phẩm đóng góp phần lớn doanh thu (20% sản phẩm → 80% doanh thu).  
   - *Lý do chọn*: Giúp doanh nghiệp ưu tiên nguồn lực vào danh mục sản phẩm chiến lược.  

---

## 🛠 Specific Skills & Tools  
- **SQL Server**  
  - Sử dụng **CTE, Window Functions (NTILE, ROW_NUMBER, DATEDIFF)**.  
  - Xây dựng pipeline dữ liệu và bảng phân tích (#Retail, #RFM, #Cohort, #LTV).  

- **Power BI**  
  - Thiết kế dashboard RFM segmentation, retention matrix, LTV growth curve.  

- **Excel/CSV (Kaggle Global Superstore)**  
  - Nguồn dữ liệu thô ban đầu.  

---

## 📊 Results & Business Recommendations  
- **RFM Segmentation**  
  - Nhóm *Champions* & *Loyal Customers* chiếm ~25% khách hàng nhưng mang lại hơn 60% doanh thu.  
  - Nhóm *At Risk* và *Lost* cần chiến dịch tái kích hoạt (voucher, remarketing).  

- **Cohort Analysis**  
  - Retention sau 3 tháng giảm mạnh còn ~30%.  
  - **Đề xuất**: Tập trung vào onboarding và follow-up trong 90 ngày đầu.  

- **LTV**  
  - Giá trị vòng đời trung bình của khách hàng: ~450 USD.  
  - Nếu cải thiện retention thêm 10% → LTV tăng thêm ~15%. 

- **Pareto Analysis**  
  - Top sản phẩm đóng góp hơn 80% doanh thu.  
  - **Đề xuất**: Tập trung marketing & inventory management vào các sản phẩm thuộc nhóm này, đồng thời thiết kế chiến dịch cross-sell với nhóm sản phẩm có biên lợi nhuận cao.  


👉 **Khuyến nghị kinh doanh**:  
1. Đầu tư mạnh hơn vào nhóm *Champions & Loyal* (upsell, cross-sell).  
2. Thiết kế chương trình *win-back campaign* cho nhóm *At Risk*.  
3. Đo lường ROI cho từng cohort marketing thay vì tổng thể.  

---

## 🚀 Next Steps  
- **Mở rộng dữ liệu**: Kết hợp CRM, digital marketing channel để hiểu rõ hành vi đa kênh.  
- **Mô hình nâng cao**: Xây dựng **Machine Learning Customer Churn Prediction**.  
- **Hạn chế hiện tại**: Dữ liệu chỉ phản ánh đơn hàng, chưa bao gồm *cost & channel attribution* → cần dữ liệu đầy đủ hơn để ước lượng ROI.  

---

## 🖼️ Report Power BI  
Report bao gồm:  
- **Cơ cấu phân khúc RFM**.  
- **Top sản phẩm mang lại 80% doanh thu**.  
- **Retention matrix theo Cohort Index**.  
- **Đường tăng trưởng LTV theo thời gian**.  

---

## 📂 Project Structure  
```plaintext
Global_Store.xlsx/          # Dữ liệu nguồn
Create_Dim_Date.sql/        # SQL scripts tạo bảng dim dim date
RFM_Cohort_LTV.sql/         # SQL scrips (RFM, Cohort, LTV)
Report.pbix/                # Power BI Report
README.md                   # Project documentation
