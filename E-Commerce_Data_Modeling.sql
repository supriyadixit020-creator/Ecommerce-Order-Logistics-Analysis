CREATE DATABASE ecommerce_db
use ecommerce_db
SELECT COUNT(*) FROM dbo.orders_cleaned;
SELECT COUNT(*) FROM dbo.order_items_cleaned;
SELECT COUNT(*) FROM dbo.customers_cleaned;
SELECT COUNT(*) FROM dbo.products_cleaned;
SELECT COUNT(*) FROM dbo.payments_cleaned;



SELECT 
    o.order_id,
    o.order_status,
    o.delivery_delay_days,
    c.customer_state,
    c.customer_city,
    oi.price,
    oi.freight_value,
    p.product_category_name
FROM dbo.orders_cleaned o
INNER JOIN dbo.customers_cleaned c ON o.customer_id = c.customer_id
INNER JOIN dbo.order_items_cleaned oi ON o.order_id = oi.order_id
INNER JOIN dbo.products_cleaned p ON oi.product_id = p.product_id


SELECT TOP 10
    o.order_id,
    o.order_status,
    o.delivery_delay_days,
    c.customer_state,
    c.customer_city,
    oi.price,
    oi.freight_value,
    p.product_category_name
FROM dbo.orders_cleaned o
INNER JOIN dbo.customers_cleaned c ON o.customer_id = c.customer_id
INNER JOIN dbo.order_items_cleaned oi ON o.order_id = oi.order_id
INNER JOIN dbo.products_cleaned p ON oi.product_id = p.product_id

--------------------------------------------------Query 1 — Overall Business Summary

SELECT 
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    ROUND(SUM(oi.price), 2) AS Total_Revenue,
    ROUND(AVG(oi.price), 2) AS Avg_Order_Value
FROM dbo.orders_cleaned o
INNER JOIN dbo.order_items_cleaned oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'

---------------------------------------------------Query 2 — Top 10 Product Categories by Revenue

SELECT 
    p.product_category_name,
    COUNT(oi.order_id) AS Total_Orders,
    ROUND(SUM(oi.price), 2) AS Total_Revenue
FROM dbo.order_items_cleaned oi
INNER JOIN dbo.products_cleaned p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Total_Revenue DESC
--------------------------------------------------Query 3 — Delivery Delay Analysis

SELECT 
    o.delivery_status,
    COUNT(*) AS Total_Orders,
    ROUND(AVG(CAST(o.delivery_delay_days AS FLOAT)), 2) AS Avg_Delay_Days
FROM dbo.orders_cleaned o
GROUP BY o.delivery_status
------------------------------------------------Query 4 — Top 10 States by Revenue

SELECT TOP 10
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    ROUND(SUM(oi.price), 2) AS Total_Revenue
FROM dbo.orders_cleaned o
INNER JOIN dbo.customers_cleaned c ON o.customer_id = c.customer_id
INNER JOIN dbo.order_items_cleaned oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY Total_Revenue DESC
----------------------------------------------Query 5 — Payment Method Analysis

SELECT 
    p.payment_type,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(p.payment_value), 2) AS Total_Value,
    ROUND(AVG(p.payment_installments), 1) AS Avg_Installments
FROM dbo.payments_cleaned p
GROUP BY p.payment_type
ORDER BY Total_Value DESC
--------------------------------------------Query 6 — Late Delivery Impact on Revenue

SELECT 
    o.delivery_status,
    ROUND(SUM(oi.price), 2) AS Total_Revenue,
    ROUND(AVG(oi.price), 2) AS Avg_Order_Value
FROM dbo.orders_cleaned o
INNER JOIN dbo.order_items_cleaned oi ON o.order_id = oi.order_id
GROUP BY o.delivery_status
------------------------------------------Query 7 — Top 10 Customer States by Late Delivery Rate

SELECT TOP 10
    c.customer_state,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN o.delivery_status = 'Late' THEN 1 ELSE 0 END) AS Late_Orders,
    ROUND(SUM(CASE WHEN o.delivery_status = 'Late' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Late_Rate_Pct
FROM dbo.orders_cleaned o
INNER JOIN dbo.customers_cleaned c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
HAVING COUNT(*) > 500
ORDER BY Late_Rate_Pct DESC
-----------------------------------------Query 8 — Monthly Order Trend
SELECT 
    YEAR(o.order_purchase_timestamp) AS Year,
    MONTH(o.order_purchase_timestamp) AS Month,
    COUNT(DISTINCT o.order_id) AS Total_Orders,
    ROUND(SUM(oi.price), 2) AS Monthly_Revenue
FROM dbo.orders_cleaned o
INNER JOIN dbo.order_items_cleaned oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp)
ORDER BY Year, Month