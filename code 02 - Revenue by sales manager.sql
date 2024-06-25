/*
Write a query to return the total revenue gained by each sales manager.
*/

SELECT
    e2.employeeNumber AS managerID,
    CONCAT_WS(" ", e2.firstName, e2.lastName) AS name,
    e2.jobTitle AS title,
    SUM(p.amount) AS revenue
FROM
	employees AS e1
LEFT JOIN
	employees AS e2
    ON e1.reportsTo = e2.employeeNumber
LEFT JOIN
	customers AS c
    ON e1.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN
	payments AS p
    ON c.customerNumber = p.customerNumber
WHERE
	e2.jobTitle LIKE "%manager%"
GROUP BY
	e2.employeeNumber,
    CONCAT_WS(" ", e2.firstName, e2.lastName),
    e2.jobTitle
ORDER BY
	revenue DESC;