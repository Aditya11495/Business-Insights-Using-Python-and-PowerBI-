
-- Q1: Total Sales
SELECT SUM(sales) AS total_sales
FROM orders;

-- Q2: Total Profit
SELECT SUM(profit) AS total_profit
FROM orders;

-- Q3: Average Discount
SELECT AVG(discount) AS average_discount
FROM orders;

-- Q4: Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;

-- Q5: Total Quantity Sold
SELECT SUM(quantity) AS total_quantity_sold
FROM orders;


-- Q6: Sales by Region
SELECT
region,
SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Q7: Profit by Region
SELECT
region,
SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit DESC;

-- Q8: Quantity by Region
SELECT
region,
SUM(quantity) AS total_quantity
FROM orders
GROUP BY region
ORDER BY total_quantity DESC;

-- Combined Regional Analysis
SELECT
region,
SUM(sales) AS total_sales,
SUM(profit) AS total_profit,
SUM(quantity) AS total_quantity
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Q9: Top 5 States by Sales
SELECT
state,
SUM(sales) AS total_sales
FROM orders
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;

-- Q10: Bottom 5 States by Sales
SELECT
state,
SUM(sales) AS total_sales
FROM orders
GROUP BY state
ORDER BY total_sales ASC
LIMIT 5;

-- Q11: Top 10 Products by Sales
SELECT
product,
SUM(sales) AS total_sales
FROM orders
GROUP BY product
ORDER BY total_sales DESC
LIMIT 10;

-- Q12: Top 10 Products by Profit
SELECT
product,
SUM(profit) AS total_profit
FROM orders
GROUP BY product
ORDER BY total_profit DESC
LIMIT 10;



-- Q13: Category with Highest Sales
SELECT
category,
SUM(sales) AS total_sales
FROM orders
GROUP BY category
ORDER BY total_sales DESC
LIMIT 1;

-- Q14: Category with Highest Profit
SELECT
category,
SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC
LIMIT 1;

-- Q15: State with Highest Profit
SELECT
state,
SUM(profit) AS total_profit
FROM orders
GROUP BY state
ORDER BY total_profit DESC
LIMIT 1;

-- Q16: Product with Highest Average Discount
SELECT
product,
AVG(discount) AS average_discount
FROM orders
GROUP BY product
ORDER BY average_discount DESC
LIMIT 1;


-- Q17: Orders with Sales Above Average Sales
SELECT
product,
sales
FROM orders
WHERE sales >
(
SELECT AVG(sales)
FROM orders
);

-- Improved Version
SELECT
product,
SUM(sales) AS total_sales
FROM orders
GROUP BY product
HAVING SUM(sales) >
(
SELECT AVG(product_sales)
FROM
(
SELECT SUM(sales) AS product_sales
FROM orders
GROUP BY product
) x
);

-- Q18: Top Performing Product in Each Category
SELECT
category,
product,
total_sales
FROM
(
SELECT
category,
product,
SUM(sales) AS total_sales,
RANK() OVER
(
PARTITION BY category
ORDER BY SUM(sales) DESC
) AS rank_num
FROM orders
GROUP BY category, product
) ranked_products
WHERE rank_num = 1;

-- Q19: Second Highest Sales Product
SELECT
product,
total_sales
FROM
(
SELECT
product,
SUM(sales) AS total_sales,
DENSE_RANK() OVER
(
ORDER BY SUM(sales) DESC
) AS rnk
FROM orders
GROUP BY product
) t
WHERE rnk = 2;

-- Q20: Third Highest Profit State
SELECT
state,
total_profit
FROM
(
SELECT
state,
SUM(profit) AS total_profit,
DENSE_RANK() OVER
(
ORDER BY SUM(profit) DESC
) AS rnk
FROM orders
GROUP BY state
) t
WHERE rnk = 3;

-- Q21: Top 3 Products by Profit
SELECT
product,
SUM(profit) AS total_profit
FROM orders
GROUP BY product
ORDER BY total_profit DESC
LIMIT 3;
