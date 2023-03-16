
/* 1. Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos 
con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK.
 Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/

SELECT customers.customer_id, customers.company_name, COUNT(orders.order_id) AS CantidadProductos
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id;

/* 2. Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y 
han decidido pedirnos una serie de consultas adicionales. La primera de ellas consiste en una query 
que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han 
pedido. Para ello hará falta hacer 2 joins.*/

SELECT  customers.company_name, YEAR(orders.order_date), SUM(order_details.quantity)
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
WHERE customers.country = "UK"
GROUP BY   YEAR(orders.order_date), customers.company_name;

/* 3. Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de 
dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. Ojo que 
los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.*/

SELECT  customers.company_name, YEAR(orders.order_date), SUM(order_details.quantity) AS CantidadProductos,
SUM((order_details.quantity*order_details.unit_price) - (order_details.quantity*order_details.unit_price)* order_details.discount) AS DineroTotal
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id
INNER JOIN order_details
ON orders.order_id = order_details.order_id
WHERE customers.country = "UK"
GROUP BY   YEAR(orders.order_date), customers.company_name;

/* 4. BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, 
desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto 
con cada pedido que han realizado y su fecha.*/

SELECT customers.company_name, orders.order_id, orders.order_date
FROM customers
INNER JOIN orders 
ON customers.customer_id = orders.customer_id
WHERE customers.country = "UK";

/* 5. BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la 
categoría y el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto 
(teniendo en cuenta los descuentos).*/

SELECT categories.category_id, categories.category_name, products.product_name,
SUM((order_details.quantity*order_details.unit_price) - (order_details.quantity*order_details.unit_price)* order_details.discount) AS ProductSales
FROM products
INNER JOIN categories
ON products.category_id = categories. category_id
INNER JOIN order_details
ON products.unit_price = order_details.unit_price
GROUP BY products.category_id, products.product_id;


