
-- Business Performance — 1–4

-- 1. What are the total sales, total cost, and total profit?

SELECT SUM(sales_amount) AS total_sales,
       SUM(cost_amount) AS total_cost,
       SUM(profit) AS total_profit
FROM orders;

-- 2. What is the monthly sales and profit trend?

SELECT DATE_TRUNC('month', order_date) AS month,
       SUM(sales_amount) AS total_sales,
       SUM(profit) AS total_profit
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 3. Which regions generate the highest sales and profit?

SELECT c.region,
       SUM(o.sales_amount) AS total_sales,
       SUM(o.profit) AS total_profit
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY total_sales DESC;

-- 4. Which order statuses contribute the most to sales and profit?

SELECT order_status,
       SUM(sales_amount) AS total_sales,
       SUM(profit) AS total_profit
FROM orders
GROUP BY order_status
ORDER BY total_sales DESC;

-- Customer Analysis — 5–7

-- 5. Which customer segments generate the highest sales and profit?

SELECT c.segment,
       SUM(o.sales_amount) AS total_sales,
       SUM(o.profit) AS total_profit
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.segment
ORDER BY total_sales DESC;

-- 6. Who are the top 10 customers by total sales?

SELECT c.customer_id, c.customer_name, c.city,
       SUM(o.sales_amount) AS total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_sales DESC
LIMIT 10;

-- 7. Which regions have the highest number of customers and average customer spending?

WITH customer_spending AS (
SELECT c.customer_id, c.region,
       SUM(o.sales_amount) AS customer_total_sales
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.region
)
SELECT region,
       COUNT(customer_id) AS total_customers,
       ROUND(AVG(customer_total_sales), 2) AS avg_customer_spending
FROM customer_spending
GROUP BY region
ORDER BY total_customers DESC;

-- Product & Category Analysis — 8–11

-- 8. Which product categories generate the highest sales and profit?

SELECT p.category,
       SUM(o.sales_amount) AS total_sales,
       SUM(o.profit) AS total_profit
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- 9. What are the top 10 products by profit?

SELECT p.product_id, p.product_name,
       SUM(o.profit) AS total_profit
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
LIMIT 10;

-- 10. Which products have high sales but low profit margins?

WITH product_performance AS (
SELECT p.product_id, p.product_name,
       SUM(o.sales_amount) AS total_sales,
       SUM(o.profit) AS total_profit
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
)
SELECT * FROM product_performance
WHERE total_sales > (
SELECT AVG(total_sales)
FROM product_performance
)
AND total_profit < (
SELECT AVG(total_profit)
FROM product_performance
)
ORDER BY total_sales DESC;

-- 11. Which sub-categories perform best within each category?

WITH subcategory_performance AS (
SELECT p.category, p.sub_category,
       SUM(o.profit) AS total_profit
FROM products p
JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.category, p.sub_category
)
SELECT category, sub_category, total_profit,
    RANK() OVER (PARTITION BY category ORDER BY total_profit DESC) AS rank_number
FROM subcategory_performance
ORDER BY category, rank_number;

-- Supplier Analysis — 12–13

-- 12. Which suppliers generate the highest sales and profit?

SELECT s.supplier_id, s.supplier_name,
       SUM(o.sales_amount) AS total_sales,
       SUM(o.profit) AS total_profit
FROM suppliers s
JOIN orders o
ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_sales DESC;

-- 13. Is there a relationship between supplier rating and business performance?

SELECT s.supplier_rating,
       COUNT(DISTINCT s.supplier_id) AS supplier_count,
       SUM(o.sales_amount) AS total_sales,
       SUM(o.profit) AS total_profit,
    ROUND(AVG(o.sales_amount), 2) AS avg_order_sales,
    ROUND(AVG(o.profit), 2) AS avg_order_profit
FROM suppliers s
JOIN orders o
ON s.supplier_id = o.supplier_id
WHERE s.supplier_rating IS NOT NULL
GROUP BY s.supplier_rating
ORDER BY s.supplier_rating DESC;

-- Shipment & Operations — 14–16

-- 14. What percentage of shipments are On Time vs Delayed?

SELECT delivery_status,
       COUNT(*) AS shipment_count,
       ROUND(COUNT(*) * 100.0/ SUM(COUNT(*)) OVER (),2) AS shipment_percentage
FROM shipments
GROUP BY delivery_status
ORDER BY shipment_percentage DESC;

-- 15. Which shipping modes have the highest delay rate?

SELECT shipping_mode,
       COUNT(*) AS total_shipments,
       COUNT(*) FILTER (WHERE delivery_status = 'Delayed') AS delayed_shipments,
       ROUND(COUNT(*) FILTER (WHERE delivery_status = 'Delayed' ) * 100.0 / COUNT(*),
       2) AS delay_rate
FROM shipments
GROUP BY shipping_mode
ORDER BY delay_rate DESC;

-- 16. What is the average delivery time by shipping mode?

WITH delivery_time AS (
SELECT shipping_mode, delivery_date - shipping_date AS delivery_time
FROM shipments
WHERE delivery_date IS NOT NULL
AND shipping_date IS NOT NULL
)
SELECT shipping_mode,
       ROUND(AVG(delivery_time), 2) AS avg_delivery_time
FROM delivery_time
GROUP BY shipping_mode
ORDER BY avg_delivery_time;

-- Inventory Analysis — 17–18

-- 17. Which products have stock levels below their reorder levels?

SELECT product_id,
       SUM(stock_level) AS total_stock_level,
       SUM(reorder_level) AS total_reorder_level
FROM inventory
GROUP BY product_id
HAVING SUM(stock_level) < SUM(reorder_level)
ORDER BY total_stock_level;

-- 18. Which warehouses have the highest inventory levels and number of low-stock products?

WITH warehouse_inventory AS (
SELECT warehouse,
       SUM(stock_level) AS total_stock_level
FROM inventory
GROUP BY warehouse
),
low_stock AS (
SELECT warehouse,
       COUNT(DISTINCT product_id) AS low_stock_products
FROM inventory
WHERE stock_level < reorder_level
GROUP BY warehouse
)
SELECT wi.warehouse, wi.total_stock_level,
       COALESCE(ls.low_stock_products, 0) AS low_stock_products
FROM warehouse_inventory wi
LEFT JOIN low_stock ls
ON wi.warehouse = ls.warehouse
ORDER BY wi.total_stock_level DESC;
