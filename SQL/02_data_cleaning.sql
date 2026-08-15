
-- Customer Data Cleaning

SELECT * FROM customers;

-- Check for duplicate customer IDs

SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    GROUP BY customer_id
    HAVING COUNT(*) > 1
)
ORDER BY customer_id;

-- Fix duplicate customer ID

UPDATE customers
SET customer_id = 'C0056'
WHERE customer_id = 'C0006'
AND customer_name = 'Customer 056';

-- Check for missing values

SELECT * FROM customers
WHERE customer_name IS NULL
   OR segment IS NULL
   OR city IS NULL
   OR state IS NULL
   OR region IS NULL;
   
-- Handle missing customer name

UPDATE customers
SET customer_name = 'Unknown Customer'
WHERE customer_id = 'C0041'
AND customer_name IS NULL;

-- Handle missing city

UPDATE customers
SET city = 'Unknown'
WHERE customer_id = 'C0029'
AND city IS NULL;

-- Check unique segment values

SELECT DISTINCT segment
FROM customers;

-- Standardize segment values

UPDATE customers
SET segment = INITCAP(TRIM(segment));

-- Check unique region values

SELECT DISTINCT region
FROM customers;

-- Standardize region values

UPDATE customers
SET region = INITCAP(TRIM(region));

-- Product Data Cleaning

SELECT * FROM products;

-- Check for duplicate product IDs

SELECT * FROM products
WHERE product_id IN (
    SELECT product_id
    FROM products
    GROUP BY product_id
    HAVING COUNT(*) > 1
)
ORDER BY product_id;

-- Fix duplicate product ID

UPDATE products
SET product_id = 'P0076'
WHERE product_id = 'P0008'
AND product_name = 'Packaging Product 1';

-- Check for missing values

SELECT * FROM products
WHERE product_name IS NULL
OR category IS NULL
OR sub_category IS NULL;

-- Handle missing product name

UPDATE products
SET product_name = 'Unknown'
WHERE product_id = 'P0061'
AND product_name IS NULL;

-- Check product names

SELECT DISTINCT product_name
FROM products
ORDER BY product_name;

-- Standardize category values

UPDATE products
SET category = INITCAP(TRIM(category));

-- Check category and sub-category values

SELECT DISTINCT category, sub_category
FROM products
ORDER BY category, sub_category;

-- Check for zero or negative prices

SELECT * FROM products
WHERE unit_cost <= 0
OR unit_price <= 0;


-- Handle invalid unit price

UPDATE products
SET unit_price = NULL
WHERE product_id = 'P0032'
AND unit_price < 0;

-- Supplier Data Cleaning

SELECT * FROM suppliers;

-- Check for duplicate supplier IDs

SELECT * FROM suppliers
WHERE supplier_id IN (
    SELECT supplier_id
    FROM suppliers
    GROUP BY supplier_id
    HAVING COUNT(*) > 1
)
ORDER BY supplier_id;

-- Fix duplicate supplier ID

UPDATE suppliers
SET supplier_id = 'S021'
WHERE supplier_id = 'S004'
AND supplier_name = 'Supplier 21';

-- Check for missing values

SELECT * FROM suppliers
WHERE supplier_name IS NULL
OR supplier_category IS NULL
OR supplier_location IS NULL
OR supplier_rating IS NULL;

-- Handle missing supplier name

UPDATE suppliers
SET supplier_name = 'Unknown'
WHERE supplier_id = 'S010'
AND supplier_name IS NULL;

-- Check supplier names

SELECT DISTINCT supplier_name
FROM suppliers;

-- Check supplier categories

SELECT DISTINCT supplier_category
FROM suppliers;

-- Standardize supplier categories

UPDATE suppliers
SET supplier_category = INITCAP(TRIM(supplier_category));

-- Check supplier locations

SELECT DISTINCT supplier_location
FROM suppliers;

-- Check supplier ratings

SELECT DISTINCT supplier_rating
FROM suppliers
ORDER BY supplier_rating;

-- Check for invalid supplier ratings

SELECT * FROM suppliers
WHERE supplier_rating < 1
OR supplier_rating > 5;

-- Handle invalid supplier rating

UPDATE suppliers
SET supplier_rating = NULL
WHERE supplier_id = 'S004'
AND supplier_rating > 5;

-- Order Data Cleaning

SELECT * FROM orders;

-- Check for duplicate order IDs

SELECT * FROM orders
WHERE order_id IN (
    SELECT order_id
    FROM orders
    GROUP BY order_id
    HAVING COUNT(*) > 1
)
ORDER BY order_id;

-- Fix duplicate order ID

UPDATE orders
SET order_id = 'O01001'
WHERE order_id = 'O00013'
AND order_date = '2025-12-12'
AND customer_id = 'C0051';

-- Verify updated order

SELECT * FROM orders
WHERE order_id = 'O01001';

-- Check for missing values

SELECT * FROM orders
WHERE order_id IS NULL
OR order_date IS NULL
OR customer_id IS NULL
OR product_id IS NULL
OR supplier_id IS NULL
OR quantity IS NULL
OR sales_amount IS NULL
OR cost_amount IS NULL
OR order_status IS NULL;

-- Check specific order record

SELECT * FROM orders
WHERE order_id = 'O00089';

-- Check for invalid values

SELECT * FROM orders
WHERE quantity <= 0
OR sales_amount <= 0
OR cost_amount <= 0;

-- Handle invalid quantity

UPDATE orders
SET quantity = NULL
WHERE quantity <= 0;

-- Handle invalid sales amount

UPDATE orders
SET sales_amount = NULL
WHERE sales_amount <= 0;

-- Check order status values

SELECT DISTINCT order_status
FROM orders;

-- Standardize order status

UPDATE orders
SET order_status = INITCAP(TRIM(order_status));

-- Shipment Data Cleaning

SELECT * FROM shipments;

-- Check for duplicate shipment IDs

SELECT * FROM shipments
WHERE shipment_id IN (
    SELECT shipment_id
    FROM shipments
    GROUP BY shipment_id
    HAVING COUNT(*) > 1
)
ORDER BY shipment_id;

-- Check the latest shipment ID

SELECT MAX(shipment_id)
FROM shipments;

-- Fix duplicate shipment ID

UPDATE shipments
SET shipment_id = 'SH00917'
WHERE shipment_id = 'SH00011'
AND order_id = 'O00064'
AND shipping_date = '2025-11-11';

-- Verify updated shipment

SELECT * FROM shipments
WHERE shipment_id = 'SH00917';

-- Check for missing values

SELECT * FROM shipments
WHERE shipment_id IS NULL
OR order_id IS NULL
OR shipping_date IS NULL
OR delivery_date IS NULL
OR shipping_mode IS NULL
OR delivery_status IS NULL;

-- Check for invalid delivery dates

SELECT * FROM shipments
WHERE delivery_date IS NOT NULL
AND shipping_date IS NOT NULL
AND delivery_date < shipping_date;

-- Handle invalid delivery date

UPDATE shipments
SET delivery_date = NULL
WHERE shipment_id = 'SH00011'
AND order_id = 'O00012';

-- Check shipping mode values

SELECT DISTINCT shipping_mode
FROM shipments;

-- Standardize shipping mode

UPDATE shipments
SET shipping_mode = INITCAP(TRIM(shipping_mode));

-- Inventory Data Cleaning

SELECT * FROM inventory;

-- Check for duplicate inventory IDs

SELECT * FROM inventory
WHERE inventory_id IN (
    SELECT inventory_id
    FROM inventory
    GROUP BY inventory_id
    HAVING COUNT(*) > 1
)
ORDER BY inventory_id;

-- Check the latest inventory ID

SELECT MAX(inventory_id)
FROM inventory;

-- Fix duplicate inventory ID

UPDATE inventory
SET inventory_id = 'INV00201'
WHERE inventory_id = 'INV00009'
AND product_id = 'P0001';

-- Verify updated inventory

SELECT * FROM inventory
WHERE inventory_id = 'INV00201';

-- Check for missing values

SELECT * FROM inventory
WHERE inventory_id IS NULL
OR product_id IS NULL
OR stock_level IS NULL
OR reorder_level IS NULL
OR warehouse IS NULL
OR inventory_date IS NULL;

-- Check for invalid stock and reorder levels

SELECT * FROM inventory
WHERE stock_level < 0
OR reorder_level < 0;

-- Handle invalid stock level

UPDATE inventory
SET stock_level = NULL
WHERE inventory_id = 'INV00009'
AND stock_level < 0;

-- Handle invalid reorder level

UPDATE inventory
SET reorder_level = NULL
WHERE inventory_id = 'INV00022'
AND reorder_level < 0;

-- Check warehouse values

SELECT DISTINCT warehouse
FROM inventory;

-- Standardize warehouse names

UPDATE inventory
SET warehouse = INITCAP(TRIM(warehouse));

