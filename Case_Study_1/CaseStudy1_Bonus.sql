/* --------------------
	 BONUS QUESTIONS
   --------------------*/

USE `Danny's Diner`; -- Para poder usar la base de datos que hemos creado

-- 1. Join All The Things
/*
SELECT
	sales.customer_id,
    sales.order_date,
    menu.product_name,
    menu.price,
    IF(sales.order_date >= members.join_date, 'Y', 'N') AS member
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
ORDER BY sales.customer_id, sales.order_date;

-- 2. Rank All The Things

SELECT
	sales.customer_id,
    sales.order_date,
    menu.product_name,
    menu.price,
    IF(sales.order_date >= members.join_date, 'Y', 'N') AS member,
    CASE
		WHEN sales.order_date >= members.join_date THEN
			ROW_NUMBER() OVER (PARTITION BY sales.customer_id ORDER BY sales.order_date) -- ROW_NUMBER() genera números para cada producto | OVER (PARTITION BY agrupa los productos por cada cliente
        ELSE null
	END AS ranking
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
ORDER BY sales.customer_id, ranking;
*/