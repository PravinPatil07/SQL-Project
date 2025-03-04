# SQL-Project
This project contain SQL queries t extract data from csv file for analyasis
# 🍕 Pizza Sales Data Analysis Project

## 📌 Overview
This project analyzes pizza sales data using SQL queries to extract insights on orders, revenue, popular pizzas, and sales trends.

## 📂 Database Schema
The project consists of the following tables:

1. **pizzas** - Contains pizza details like price, type, and size.
2. **pizza_types** - Stores different pizza types and their categories.
3. **orders** - Stores order details with timestamps.
4. **order_details** - Links orders with pizzas and their quantities.

### **Database Creation & Table Schema**
```sql
USE pizza_project;

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
```

## 🔍 SQL Queries

### **Basic Queries**

#### 1️⃣ Retrieve the total number of orders placed.
```sql
SELECT COUNT(order_id) AS total_orders FROM orders;
```

#### 2️⃣ Calculate the total revenue generated from pizza sales.
```sql
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details AS od
JOIN pizzas AS p ON p.pizza_id = od.pizaa_id;
```

#### 3️⃣ Identify the highest-priced pizza.
```sql
SELECT pt.name, p.price
FROM pizzas AS p
JOIN pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
```

#### 4️⃣ Identify the most common pizza size ordered.
```sql
SELECT p.size, COUNT(od.order_details_id) AS order_count
FROM pizzas AS p
JOIN order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY p.size
ORDER BY order_count DESC;
```

#### 5️⃣ List the top 5 most ordered pizza types along with their quantities.
```sql
SELECT pt.name, SUM(od.quantity) AS pizza_quantity
FROM pizza_types AS pt
JOIN pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY pt.name
ORDER BY pizza_quantity DESC
LIMIT 5;
```

### **Intermediate Queries**

#### 1️⃣ Find the total quantity of each pizza category ordered.
```sql
SELECT pt.category, SUM(od.quantity) AS pizza_quantity
FROM pizza_types AS pt
JOIN pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY pt.category
ORDER BY pizza_quantity DESC;
```

#### 2️⃣ Determine the distribution of orders by hour of the day.
```sql
SELECT HOUR(order_time) AS hours, COUNT(order_id) AS orders
FROM orders
GROUP BY hours;
```

#### 3️⃣ Find the category-wise distribution of pizzas.
```sql
SELECT category, COUNT(name) AS count
FROM pizza_types
GROUP BY category;
```

#### 4️⃣ Calculate the average number of pizzas ordered per day.
```sql
SELECT AVG(sum_quantity) AS average_of_quantity_per_day
FROM (
    SELECT o.order_date, SUM(od.quantity) AS sum_quantity
    FROM orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY o.order_date
) AS order_quantity_sum;
```

#### 5️⃣ Determine the top 3 most ordered pizza types based on revenue.
```sql
SELECT pt.name, SUM(od.quantity * p.price) AS revenue
FROM pizza_types AS pt
JOIN pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details AS od ON p.pizza_id = od.pizaa_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;
```

## 📌 Conclusion
This project demonstrates how SQL can be used to analyze pizza sales data effectively, providing insights into customer preferences, sales trends, and revenue generation.

### 📢 Feel free to fork this project and contribute!

---
📌 **Author:** Pravin Patil  
📌 **Tech Stack:** SQL  
📌 **GitHub:** [Your GitHub Profile Link]  
