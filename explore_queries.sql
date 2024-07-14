/*
These are simply exploratory queries for a better understanding. 
*/
SELECT
    c.category_id,
    c.category_name,
    SUM(oi.quantity * p.list_price * (1 - oi.discount)) AS total_revenue
FROM
    production.categories c
JOIN                                                                                                     -- NOTE: The highest in total revenues based on category are Mountain Bikes, would be helpful to understand our focus.
    production.products p ON c.category_id = p.category_id                                               --       Lowest would be Children Bicycles, maybe we could understand a little bit more about targeted demographic here.
JOIN
    sales.order_items oi ON p.product_id = oi.product_id
GROUP BY
    c.category_id, c.category_name
ORDER BY
    total_revenue DESC;

    
    
SELECT
    c.category_id,
    c.category_name,
    AVG(oi.discount) AS avg_discount_percentage
FROM
    production.categories c
JOIN
    production.products p ON c.category_id = p.category_id                                              -- NOTE: Although there is not that much difference here for average discount percentage sorted by categories,
JOIN                                                                                                    --       we could start thinking about strategically discounting items to drive sales incentives?
    sales.order_items oi ON p.product_id = oi.product_id
GROUP BY
    c.category_id, c.category_name
ORDER BY
    avg_discount_percentage DESC;
    
    
    
    
    
SELECT
    c.category_id,
    c.category_name,
    MONTHNAME(o.order_date) AS month,
    SUM(oi.quantity) AS total_quantity_sold
FROM
    production.categories c
JOIN
    production.products p ON c.category_id = p.category_id
JOIN
    sales.order_items oi ON p.product_id = oi.product_id
JOIN
    sales.orders o ON oi.order_id = o.order_id
WHERE
	o.order_date BETWEEN '2016-01-01' AND '2017-01-01'                             -- This is only in the year of 2016, feel free to remove to have the total duration.
GROUP BY
    c.category_id, c.category_name, MONTH(o.order_date)
ORDER BY
    total_quantity_sold DESC, category_name;
    
    
    
    
SELECT
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name,
    ps.quantity AS current_stock
FROM
    production.categories c                                                         -- Simple inventory could be beneficial to understand. For instance, maybe the top items don't sell very well.
JOIN
    production.products p ON c.category_id = p.category_id
JOIN
    production.stocks ps ON p.product_id = ps.product_id
ORDER BY
    current_stock DESC;