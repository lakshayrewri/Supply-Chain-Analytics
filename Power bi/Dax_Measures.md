-- Dax_measures - Supply_Chain_Analytics


-- 1. Total Sales

Total Sales =
SUM(orders[sales_amount])

--2. Total_Cost

Total Cost =
SUM(orders[cost_amount])

--3. Total_Profit

Total profit = 
SUM(orders_clean[profit])

--4. Total Orders

Total orders = 
DISTINCTCOUNT(orders_clean[order_id])

--5. Profit Margin

Profit margin % = 
DIVIDE([Total profit],[Total Sales],1)

--6. On Time %

On-Time % = 
DIVIDE(
    CALCULATE(
        COUNTROWS(shipments_clean),
        shipments_clean[delivery_status] = "On Time"
    ),
    COUNTROWS(shipments_clean),
    0
)

--7. Delayed %

Delayed % = 
DIVIDE(
    CALCULATE(
        COUNTROWS(shipments_clean),
        shipments_clean[delivery_status] = "Delayed"
    ),
    COUNTROWS(shipments_clean),
    0
)

--8. Average Delivery Days

Average Delivery Days = 
AVERAGEX(
    shipments_clean,
    DATEDIFF(
        shipments_clean[shipping_date],
        shipments_clean[delivery_date],
        DAY
    )
)