/*
Write a query to return a result set which includes:
- revenue by year of each product line.
- revenue of each product line (of all years).
- revenue of all product lines (of all years).
*/

WITH productLineRevenue AS (
    SELECT
        p.productLine,
        YEAR(o.orderDate) AS orderYear,
        SUM(d.quantityOrdered * d.priceEach) AS revenue,
        GROUPING(p.productLine) AS all_productLines,
        GROUPING(YEAR(o.orderDate)) AS all_years
    FROM
        products AS p
    INNER JOIN
        orderdetails AS d
        USING(productCode)
    INNER JOIN
        orders AS o
        USING(orderNumber)
    GROUP BY
        p.productLine,
        YEAR(o.orderDate)
    WITH ROLLUP
)
SELECT
    IF(all_productLines, "_TOTAL_", productLine) AS productLine,
    CASE
        WHEN all_years AND all_productLines THEN ""
        WHEN all_years THEN "_all_years_"
        ELSE orderYear
    END AS orderYear,
    revenue
FROM
    productLineRevenue;
