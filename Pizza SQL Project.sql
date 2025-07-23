create database pizzadb;
use pizzadb;


## Creating Orders table and importing data

CREATE TABLE orders (                
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);
select * from orders;


## Creating Order_details Table and importing data

create table order_details(          
order_details_id int primary key,
order_id int,
pizza_id  varchar(50),
quantity int);
desc order_details;
select * from order_details;


## Creating pizza_types table and importing data

create table pizza_types(             
pizza_type_id varchar(50) primary key,
name varchar(50),
category varchar(30),
ingredients varchar(150));
desc pizza_types;
select * from pizza_types;


## Creating Pizzas table and data importing

create table pizzas(pizza_id varchar(50) primary key,     
pizza_type_id varchar(50),
size varchar(5),
price decimal(6,2));
desc pizzas;
select * from pizzas;
select * from pizza_types;
select * from order_details;
select * from orders;


## Total Revenue

select * from pizzas;
select * from order_details;
SELECT 
    ROUND(SUM(od.quantity * p.price), 0) AS total_revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
ORDER BY total_revenue;


## Monthly Revenue Trend

select * from orders;
select * from order_details;
select * from pizzas;
SELECT 
    DATE_FORMAT(o.date, '%Y-%m') AS Month,
    ROUND(SUM(od.quantity * p.price), 0) AS Revenue
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
GROUP BY Month
ORDER BY Revenue;


## Top 10 Best_selling Pizzas

select * from pizza_types;
select * from order_details;
select * from pizzas;
SELECT 
    pt.name AS Pizza_name, SUM(od.quantity) AS total_sold
FROM
    pizzas AS p
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY Pizza_name
ORDER BY total_sold DESC
LIMIT 10;


## Revenue By Pizza Category

select * from order_details;
select * from pizza_types;
select * from pizzas;
SELECT 
    pt.category, ROUND(SUM(od.quantity * p.price), 0) AS category_revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY category_revenue DESC;


## Revenue by Pizza Size

select * from pizzas;
select * from order_details;
SELECT 
    p.size AS Pizza_size,
    ROUND(SUM(od.quantity * p.price), 0) AS Size_Revenue
FROM
    pizzas AS p
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY Pizza_size
ORDER BY Size_Revenue DESC;


## Daily Orders Count

select * from orders;
SELECT 
    date, COUNT(DISTINCT order_id) AS daily_orders
FROM
    orders
GROUP BY date
ORDER BY daily_orders;


select count(quantity) from order_details;