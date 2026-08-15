-- Create Customers table

DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id VARCHAR(10),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    region VARCHAR(50)
);

SELECT * FROM customers;

-- Create Products table

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id VARCHAR(10),
    product_name VARCHAR(150),
    category VARCHAR(100),
    sub_category VARCHAR(100),
    unit_cost NUMERIC(12,2),
    unit_price NUMERIC(12,2)
);

SELECT * FROM products;

-- Create Suppliers table

DROP TABLE IF EXISTS suppliers;

CREATE TABLE suppliers (
    supplier_id VARCHAR(10),
    supplier_name VARCHAR(100),
    supplier_category VARCHAR(100),
    supplier_location VARCHAR(100),
    supplier_rating NUMERIC(3,1)
);

SELECT * FROM suppliers;

-- Create Orders table

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id VARCHAR(10),
    order_date DATE,
    customer_id VARCHAR(10),
    product_id VARCHAR(10),
    supplier_id VARCHAR(10),
    quantity INTEGER,
    sales_amount NUMERIC(14,2),
    cost_amount NUMERIC(14,2),
    order_status VARCHAR(30)
);

SELECT * FROM orders;

-- Create Shipments table

DROP TABLE IF EXISTS shipments;

CREATE TABLE shipments (
    shipment_id VARCHAR(10),
    order_id VARCHAR(10),
    shipping_date DATE,
    delivery_date DATE,
    shipping_mode VARCHAR(50),
    delivery_status VARCHAR(30)
);

SELECT * FROM shipments;

-- Create Inventory table

DROP TABLE IF EXISTS inventory;

CREATE TABLE inventory (
    inventory_id VARCHAR(10),
    product_id VARCHAR(10),
    stock_level NUMERIC(10,2),
    reorder_level INTEGER,
    warehouse VARCHAR(100),
    inventory_date DATE
);

SELECT * FROM inventory;

-- Add profit column to orders

ALTER TABLE orders
ADD COLUMN profit NUMERIC(10,2);

UPDATE orders
SET profit = sales_amount - cost_amount;
