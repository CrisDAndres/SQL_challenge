/* --------------------
 RESOLUCIÓN DE PREGUNTAS
   --------------------*/

USE `Danny's Diner`; -- Para poder usar la base de datos que hemos creado

-- 1. ¿Cuál es el importe total que ha gastado cada cliente en el restaurante?
/*
SELECT sales.customer_id, SUM(menu.price) AS total_gastado
FROM sales
JOIN menu ON sales.product_id = menu.product_id
GROUP BY sales.customer_id
ORDER BY sales.customer_id;

-- 2. ¿Cuántos días ha visitado el restaurante cada cliente?

SELECT sales.customer_id, COUNT(DISTINCT sales.order_date) AS visit_days -- Hay que poner DISTINCT porque hay registros del mismo día para el mismo cliente
FROM sales
GROUP BY sales.customer_id
ORDER BY sales.customer_id;

-- 3. ¿Cuál fue el primer artículo del menú que compró cada cliente?

SELECT sales.customer_id, menu.product_name
FROM sales
JOIN menu ON sales.product_id = menu.product_id
WHERE sales.order_date = 
	(SELECT MIN(order_date) FROM sales)
GROUP BY sales.customer_id, menu.product_name
ORDER BY sales.customer_id;

-- 4. ¿Cuál es el artículo más comprado del menú y cuántas veces lo han comprado todos los clientes?

SELECT menu.product_name, COUNT(menu.product_name) AS total_products
FROM menu
JOIN sales ON menu.product_id = sales.product_id
GROUP BY menu.product_name
ORDER BY total_products DESC
LIMIT 1;

-- 5. ¿Qué artículo fue el más popular para cada cliente?

SELECT sales.customer_id, menu.product_name, COUNT(menu.product_name) AS total_products
FROM menu
JOIN sales ON menu.product_id = sales.product_id
GROUP BY menu.product_name, sales.customer_id
HAVING COUNT(menu.product_name) = -- Filtra los resultados después del group by: compara las veces que se ha comprado un producto por el num maximo de compras por cliente
	(SELECT MAX(total_products) FROM (
		SELECT sales.customer_id, COUNT(menu.product_name) AS total_products -- Subconsulta: Calcula para cliente cuántas veces compraron cada producto
		FROM menu
		JOIN sales ON menu.product_id = sales.product_id
		GROUP BY menu.product_name, sales.customer_id) AS max_products
	WHERE max_products.customer_id = sales.customer_id) -- Asegura que estamos comparando el num maximo de compras por cliente con el valor de cada cliente en la consulta principal
ORDER BY sales.customer_id;

-- 6. ¿Qué producto compró primero el cliente después de hacerse socio?

SELECT 
    members.customer_id,
    members.join_date,
    sales.order_date,
    menu.product_name
FROM members
JOIN sales ON members.customer_id = sales.customer_id
JOIN menu ON sales.product_id = menu.product_id
WHERE sales.order_date = 
	(SELECT MIN(order_date) FROM sales            -- La subquery encuentra la primera fecha de compra (MIN(order_date)) después de hacerse socio (sales.order_date >= members.join_date)
    WHERE sales.customer_id = members.customer_id -- Con esta línea, relaciona el subquery con el cliente actual en la consulta principal
    AND sales.order_date >= members.join_date)
ORDER BY members.customer_id;

-- 7. ¿Qué artículo compró el cliente justo antes de hacerse socio?

SELECT 
    members.customer_id,
    members.join_date,
    sales.order_date,
    menu.product_name
FROM members
JOIN sales ON members.customer_id = sales.customer_id
JOIN menu ON sales.product_id = menu.product_id
WHERE sales.order_date = 
	(SELECT MAX(order_date) FROM sales            -- La subquery encuentra la última fecha de compra (MAX(order_date)) antes de hacerse socio (sales.order_date < members.join_date)
    WHERE sales.customer_id = members.customer_id -- Con esta línea, relaciona el subquery con el cliente actual en la consulta principal
    AND sales.order_date < members.join_date)
ORDER BY members.customer_id;    

-- 8. ¿Cuál es el total de artículos y el importe gastado por cada cliente antes de hacerse socio?

SELECT  
    members.customer_id,
    members.join_date,
    COUNT(sales.product_id) AS total_items,   -- Cuenta el total de artículos
    SUM(menu.price) AS total_spent             -- Suma el precio total gastado
FROM members
JOIN sales ON members.customer_id = sales.customer_id
JOIN menu ON sales.product_id = menu.product_id
WHERE sales.order_date < members.join_date   -- Solo compras antes de la fecha de ingreso
GROUP BY members.customer_id, members.join_date -- Agrupamos todas las columnas que NO están implicadas en una función de agregación
ORDER BY members.customer_id;

-- 9. Si cada dólar gastado equivale a 10 puntos y el sushi tiene un multiplicador de puntos por 2, ¿cuántos puntos tendría cada cliente?
-- NOTA: Vamos a trabajar con el supuesto de que solo los miembros reciben puntos.

SELECT
	sales.customer_id,
	SUM(IF(menu.product_name LIKE 'sushi', menu.price * 2, menu.price)) * 10 AS total_points -- IF(condición, valor_si_verdadero, valor_si_falso)
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date >= members.join_date
GROUP BY sales.customer_id
ORDER BY sales.customer_id;

-- 10. En la primera semana después de que un cliente se adhiera al programa (incluida su fecha de adhesión) gana 2 veces puntos en todos los artículos, no sólo en el sushi: ¿cuántos puntos tienen los clientes A y B a finales de enero?

SELECT
	sales.customer_id,
	SUM(IF(sales.order_date <= DATE_ADD(members.join_date, INTERVAL 7 DAY), menu.price*2, menu.price))*10 AS total_points -- Con IF(sales.order_date <= DATE_ADD(members.join_date, INTERVAL 7 DAY) verificamos si la fecha de compra (sales.order_date) está dentro de la primera semana de membresía
FROM sales
JOIN menu ON sales.product_id = menu.product_id
JOIN members ON sales.customer_id = members.customer_id
WHERE sales.order_date >= members.join_date
	AND sales.order_date <= '2024-01-31'  -- Limitar hasta el 31 de enero
GROUP BY sales.customer_id
ORDER BY sales.customer_id;
*/