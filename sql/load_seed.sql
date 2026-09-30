USE schema_sql;

LOAD DATA LOCAL INFILE '/Users/meenaxi92/Documents/Capstone Project/DATA_CUSTOMERS.csv'
INTO TABLE schema_sql.customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, name, city, city_tier, signup_date, acquisition_source);

SELECT COUNT(*) FROM schema_sql.customers;

LOAD DATA LOCAL INFILE '/Users/meenaxi92/Documents/Capstone Project/DATA_PRODUCTS.csv'
INTO TABLE schema_sql.products
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, product_name, category, price);

SELECT COUNT(*) FROM schema_sql.products;

LOAD DATA LOCAL INFILE '/Users/meenaxi92/Documents/Capstone Project/DATA_ORDERS.csv'
INTO TABLE schema_sql.orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, product_id, order_date, quantity, discount_pct, payment_method, rating, returned);

## Importing the data already shows this response
## 180 row(s) affected, 27 warning(s): 1366 Incorrect integer value: '' for column 'rating' at row 8 1366 Incorrect integer value: '' for column 'discount_pct' at row 13 1366 Incorrect integer value: '' for column 'discount_pct' at row 15 1366 Incorrect integer value: '' for column 'discount_pct' at row 17 1366 Incorrect integer value: '' for column 'rating' at row 21 1366 Incorrect integer value: '' for column 'discount_pct' at row 30 1366 Incorrect integer value: '' for column 'discount_pct' at row 32 1366 Incorrect integer value: '' for column 'discount_pct' at row 36 1366 Incorrect integer value: '' for column 'rating' at row 53 1366 Incorrect integer value: '' for column 'rating' at row 54 1366 Incorrect integer value: '' for column 'rating' at row 73 1366 Incorrect integer value: '' for column 'rating' at row 79 1366 Incorrect integer value: '' for column 'discount_pct' at row 80 1366 Incorrect integer value: '' for column 'discount_pct' at row 82 1366 Incorrect integer value: '' for column 'discount_pct' at row 85 1366 Incorrect integer value: '' for column 'rating' at row 88 1366 Incorrect integer value: '' for column 'rating' at row 95 1366 Incorrect integer value: '' for column 'rating' at row 118 1366 Incorrect integer value: '' for column 'rating' at row 124 1366 Incorrect integer value: '' for column 'rating' at row 134 1366 Incorrect integer value: '' for column 'rating' at row 149 1366 Incorrect integer value: '' for column 'discount_pct' at row 152 1366 Incorrect integer value: '' for column 'discount_pct' at row 156 1366 Incorrect integer value: '' for column 'rating' at row 163 1366 Incorrect integer value: '' for column 'rating' at row 164 1366 Incorrect integer value: '' for column 'rating' at row 168 1366 Incorrect integer value: '' for column 'discount_pct' at row 169 Records: 180  Deleted: 0  Skipped: 0  Warnings: 27

SELECT COUNT(*) FROM schema_sql.orders;
