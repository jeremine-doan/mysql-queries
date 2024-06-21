/*
Write a query to return Top 5 sales representatives in 2003.
*/

SELECT
	e.employeeNumber,
    CONCAT_WS(" ", e.firstName, e.lastName) AS employeeName,
    SUM(d.quantityOrdered * d.priceEach) AS revenueIn2003
FROM
	employees AS e
LEFT JOIN
	customers AS c
    ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN
	orders AS o
    ON o.customerNumber = c.customerNumber
INNER JOIN
	orderdetails AS d
    ON d.orderNumber = o.orderNumber
WHERE
	YEAR(o.orderDate) = 2003
GROUP BY
	e.employeeNumber,
    CONCAT_WS(" ", e.firstName, e.lastName)
ORDER BY
	SUM(d.quantityOrdered * d.priceEach) DESC
LIMIT
	5;