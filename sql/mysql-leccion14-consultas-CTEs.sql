

/* 1. Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.*/

WITH clientes AS (
				  SELECT customer_id, company_name
			      FROM customers)
                    
SELECT *
	FROM clientes;


/* 2. Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".*/

WITH clientes AS (
				  SELECT customer_id, company_name
				  FROM customers)
                    
SELECT customer_id, company_name
	FROM customers
	NATURAL JOIN clientes
	WHERE country = 'Germany';


/* 3. Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).*/

WITH clientes AS (
				  SELECT customer_id, company_name
				  FROM customers)
                    
SELECT customer_id, company_name, order_id, order_date
	FROM orders
	NATURAL JOIN clientes;


/* 4. Contad el número de facturas por cliente
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente.*/

WITH clientes AS (
				  SELECT customer_id, company_name
				  FROM customers)
                    
SELECT customer_id, company_name, COUNT(order_id)
	FROM orders
	NATURAL JOIN clientes
	GROUP BY customer_id, company_name;


/* 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.*/

WITH suma_cantidades AS (
						 SELECT SUM(quantity) AS cantidad_total, product_id
						 FROM order_details
                    	 GROUP BY product_id)
                    
SELECT AVG(cantidad_total) AS media, product_name
	FROM products
	NATURAL JOIN suma_cantidades
	GROUP BY product_name;
