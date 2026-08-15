# Supply Chain Analytics Dashboard

An end-to-end Supply Chain Analytics project built using PostgreSQL and Power BI to analyze business performance across sales, profitability, customers, products, suppliers, shipments, and inventory.

## 📊 Project Overview

This project transforms raw supply chain data into an interactive Power BI dashboard.

The analysis focuses on:

- Sales and profitability
- Customer performance
- Product performance
- Customer segments
- Supplier performance
- Shipment delays
- Shipping modes
- Inventory distribution
- Low-stock analysis

The project follows a complete analytics workflow:

Raw Data → Data Cleaning → SQL Analysis → Data Modeling → DAX → Power BI Dashboard → Business Insights

---

## 🛠️ Tools & Technologies

- PostgreSQL
- SQL
- Power BI
- DAX
- Data Modeling
- Excel/CSV
- GitHub

---

## 🗂️ Dataset

The project contains six related tables:

| Table | Purpose |
|---|---|
| Customers | Customer information and segmentation |
| Products | Product and category information |
| Suppliers | Supplier details and ratings |
| Orders | Sales, costs, and profit |
| Shipments | Shipping and delivery information |
| Inventory | Warehouse and stock information |

---

## 🧹 Data Cleaning

Data cleaning was performed using PostgreSQL.

Key cleaning activities included:

- Handling missing values
- Identifying duplicate records
- Standardizing data formats
- Validating IDs and relationships
- Handling invalid values
- Cleaning date fields
- Validating supplier ratings
- Validating shipment dates
- Creating the profit field
- Checking referential integrity

---

## 🧮 SQL Analysis

SQL was used to answer key business questions, including:

- What are total sales, cost, and profit?
- Which regions generate the highest sales?
- Which categories are most profitable?
- Who are the top customers?
- Which products generate the highest profit?
- Which products have high sales but low margins?
- How does customer segment performance compare?
- Which suppliers perform best?
- Which shipping modes have higher delays?
- What is the monthly sales and profit trend?
- Which warehouses hold the most inventory?
- Which products are at low-stock levels?

Advanced SQL concepts used:

- JOINs
- GROUP BY
- CASE statements
- Subqueries
- CTEs
- Window Functions
- RANK()
- ROW_NUMBER()
- DENSE_RANK()
- Date functions
- Aggregate functions

---

## 📈 Power BI Dashboard

The dashboard contains three pages.

### Page 1 — Executive Overview

KPIs:

- Total Sales
- Total Cost
- Total Profit
- Profit Margin
- Total Orders

Visuals:

- Monthly Sales & Profit
- Sales by Region
- Sales & Profit by Category
- Orders by Status

---

### Page 2 — Customer & Product Analysis

Visuals:

- Top 5 Customers by Sales
- Sales & Profit by Customer Segment
- Sales & Profit by Category
- Product Profitability
- Top 5 Products by Profit

---

### Page 3 — Operations & Inventory

KPIs:

- On-Time %
- Delayed %
- Average Delivery Time

Visuals:

- On-Time vs Delayed Shipments
- Delay Rate by Shipping Mode
- Supplier Performance
- Inventory by Warehouse

---

## 🔗 Data Model

The Power BI model connects the major business entities across:

Customers → Orders → Products

Suppliers → Orders

Orders → Shipments

Products → Inventory

The model was designed to support cross-functional analysis while maintaining clear relationships between business entities.

---

## 💡 Business Insights

The dashboard helps identify:

- High-performing regions and categories
- Top customers and products
- Profitability differences across categories
- Customer segment performance
- Supplier performance patterns
- Shipping modes with higher delay rates
- Average delivery performance
- Inventory concentration across warehouses
- Potential low-stock products

---

## 📸 Dashboard Preview

### Executive Overview

<img width="1421" height="852" alt="Executive_Overview png" src="https://github.com/user-attachments/assets/6a62a83d-7fc8-45ea-8529-03c2bbe55930" />

### Customer & Product Analysis

<img width="1424" height="856" alt="Customer_Product_Analysis png" src="https://github.com/user-attachments/assets/e3d84faf-809b-4b07-acac-43a7566bb433" />

### Operations & Inventory

<img width="1423" height="866" alt="Operations_Inventory_Analysis png" src="https://github.com/user-attachments/assets/49a9366d-0664-42a0-ad01-6bbf2923c671" />

