/*
Write a query to return the most profitable products of each country.
*/

WITH profitByCountryProduct AS (
    SELECT
        f.country,
        p.productCode,
        p.productName,
        SUM(d.quantityOrdered * (d.priceEach - p.buyPrice)) AS profit
    FROM
        offices AS f
    INNER JOIN
        employees AS e
        ON f.officeCode = e.officeCode
    INNER JOIN
        customers AS c
        ON e.employeeNumber = c.salesRepEmployeeNumber
    INNER JOIN
        orders AS o
        ON c.customerNumber = o.customerNumber
    INNER JOIN
        orderdetails AS d
        ON d.orderNumber = o.orderNumber
    INNER JOIN
        products AS p
        ON p.productCode = d.productCode
    WHERE
        YEAR(o.orderDate) = 2003
    GROUP BY
        f.country,
        p.productCode,
        p.productName
),
maxProfit AS (
    SELECT
        cte1.country,
        MAX(cte1.profit) AS maxProfit
    FROM
        profitByCountryProduct AS cte1
    GROUP BY
        cte1.country
)
SELECT
    cte1.*
FROM
    maxProfit AS cte2
INNER JOIN
    profitByCountryProduct AS cte1
    ON cte2.country = cte1.country
    AND cte2.maxProfit = cte1.profit
ORDER BY
    cte1.profit DESC;
