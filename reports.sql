USE schema_sql;

## Order totals, total revenue, and average order value
SELECT COUNT(*) AS total_orders,
       COUNT(rating) AS ratings_present,
       COUNT(discount_pct) AS discounts_present
FROM schema_sql.orders;

SELECT
    ROUND(SUM(o.quantity * p.price * (1 - COALESCE(o.discount_pct, 0) / 100)), 2) AS total_revenue,
    ROUND(AVG(o.quantity * p.price * (1 - COALESCE(o.discount_pct, 0) / 100)), 2) AS avg_order_value
FROM orders o
JOIN products p
    ON o.product_id = p.product_id;

## COUNT(*) vs COUNT(column)
SELECT
    COUNT(*) AS total_orders, -- COUNT TOTAL ORDERS --
    COUNT(IF(rating > 0, rating, NULL)) AS rated_orders, -- COUNT COLUMN WITHOUT NULL VALUE --
    COUNT(*) -  COUNT(IF(rating > 0, rating, NULL)) AS unrated_orders -- COUNT COLUMN WITH NULL VALUE --
FROM orders;

## LEFT JOIN with a genuine zero-match row
-- FIRST METHOD --
SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) = 0;

-- SECOND METHOD --
SELECT customer_id, name
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM orders
);

## GROUP BY + HAVING 
SELECT 
	c.city,
    COUNT(o.order_id) AS total_orders,
    SUM(o.returned) AS returned_orders,
    ROUND(SUM(o.returned) * 100.0 / COUNT(o.order_id), 1) AS return_rate_pct
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
GROUP BY c.city
HAVING return_rate_pct > 20 
ORDER BY return_rate_pct DESC;

## Ranking with ORDER BY + LIMIT/OFFSET
-- ORDER BY TOTAL SPEND LIMITED TO 5 --
SELECT
    c.customer_id,
    c.name,
    SUM(o.quantity * p.price * (1 - COALESCE(o.discount_pct, 0) / 100)) AS total_spend
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spend DESC, c.customer_id ASC
LIMIT 5;

-- ORDER BY TOTAL SPEND LIMITED TO 3 OFFSET BY 2 --
SELECT
    c.customer_id,
    c.name,
    SUM(o.quantity * p.price * (1 - COALESCE(o.discount_pct, 0) / 100)) AS total_spend
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spend DESC, c.customer_id ASC
LIMIT 3 OFFSET 2;

## Three-table JOIN with GROUP BY
SELECT
	p.category,
    COUNT(o.order_id) AS order_count,
    SUM(o.quantity * p.price * (1 - COALESCE(o.discount_pct, 0) / 100)) AS category_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY p.category
ORDER BY category_revenue DESC;

## LIKE pattern match
SELECT COUNT(*) FROM customers WHERE name LIKE 'A%';

## DISTINCT
SELECT DISTINCT acquisition_source FROM customers; -- THERE IS AN ISSUE WITH SOURCE AS THERE ARE TWO TYPE OF "SOCIAL" IN THIS COLUMN --

## ALTER TABLE + UPDATE with CASE
ALTER TABLE customers
ADD loyalty_tier VARCHAR(10);

SET SQL_SAFE_UPDATES = 0; -- MySQL Safe Update Mode Updated -- 
UPDATE customers
SET loyalty_tier = CASE
    WHEN city_tier = 1 THEN 'Gold'
    ELSE 'Silver'
END;
SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) FROM customers GROUP BY loyalty_tier;