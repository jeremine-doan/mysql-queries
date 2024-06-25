/*
Write a query to return employees' level in the company hierarchy.
*/

WITH RECURSIVE cte AS (
    SELECT
        e.employeeNumber,
        CONCAT_WS(" ", e.firstName, e.lastName) AS employeeName,
        e.reportsTo,
        0 AS hierarchy
    FROM
        employees AS e
    WHERE
        e.reportsTo IS NULL
    UNION ALL
    SELECT
        e.employeeNumber,
        CONCAT_WS(" ", e.firstName, e.lastName) AS employeeName,
        e.reportsTo,
        cte.hierarchy + 1 AS hierarchy
    FROM
        employees AS e
    INNER JOIN
        cte
        ON e.reportsTo = cte.employeeNumber
)
SELECT
    *
FROM
    cte
ORDER BY
    hierarchy,
    reportsTo,
    employeeNumber;
