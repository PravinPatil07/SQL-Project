SELECT 
    *
FROM
    pizza_project.pizzas;

use pizza_project;

CREATE TABLE orders (
    order_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);

CREATE TABLE order_details (
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizaa_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);


project questions 

-- Basic:
-- 1] Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- 2] Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizaa_id;

-- 3] Identify the highest-priced pizza.

SELECT 
    pt.name, p.price
FROM
    pizzas AS p
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- 4] Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(od.order_details_id) AS order_count
FROM
    pizzas AS p
        JOIN
    order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY p.size
ORDER BY order_count DESC;


-- 5] List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name, SUM(od.quantity) AS pizza_qunatity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY pt.name
ORDER BY pizza_qunatity DESC
LIMIT 5;



-- Intermidiate 
-- 1] Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pt.category, SUM(od.quantity) AS pizza_qunatity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY pt.category
ORDER BY pizza_qunatity DESC
LIMIT 5;

-- 2] Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(order_time) AS hours, COUNT(order_id) AS orders
FROM
    orders
GROUP BY hours;

-- 3] find the category-wise distribution of pizzas.

SELECT 
    category, COUNT(name) AS count
FROM
    pizza_types
GROUP BY category;

-- 4] Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    AVG(sum_quantity) AS average_of_quantity_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS sum_quantity
    FROM
        orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS order_quantity_sum;
    
-- 5] Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;
