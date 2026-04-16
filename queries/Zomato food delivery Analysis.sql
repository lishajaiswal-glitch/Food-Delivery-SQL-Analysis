create database food_delivery;
use food_delivery;
create table Customers
(customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50),
signup_date DATE);

create table Restaurants(restaurant_id INT PRIMARY KEY,
restaurant_name VARCHAR(100),
city VARCHAR(50));

create table Orders(order_id INT PRIMARY KEY,
customer_id INT,
restaurant_id INT,
order_date DATE,
order_amount DECIMAL(10,2),
status VARCHAR(20));

create table Deliveries_Partners(partner_id INT PRIMARY KEY,
partner_name VARCHAR(100));

create table Deliveries(delivery_id INT PRIMARY KEY,
order_id INT,
partner_id INT,
delivery_status VARCHAR(20));

create table Ratings(rating_id INT PRIMARY KEY,
customer_id INT,
restaurant_id INT,
rating INT);
INSERT INTO customers VALUES
(1, 'Amit Sharma', 'Delhi', '2023-01-10'),
(2, 'Priya Singh', 'Mumbai', '2023-02-15'),
(3, 'Rahul Verma', 'Delhi', '2023-03-05'),
(4, 'Sneha Kapoor', 'Bangalore', '2023-04-20'),
(5, 'Vikas Gupta', 'Mumbai', '2023-05-12'),
(6, 'Anjali Mehta', 'Delhi', '2023-06-18'),
(7, 'Rohit Jain', 'Pune', '2023-07-01'),
(8, 'Neha Agarwal', 'Mumbai', '2023-07-10');

INSERT INTO restaurants VALUES
(101, 'Spice Hub', 'Delhi'),
(102, 'Pizza Palace', 'Mumbai'),
(103, 'Biryani House', 'Delhi'),
(104, 'Burger Point', 'Bangalore'),
(105, 'Sushi World', 'Mumbai');

INSERT INTO orders VALUES
(1001, 1, 101, '2024-03-01', 250, 'Delivered'),
(1002, 2, 102, '2024-03-02', 500, 'Delivered'),
(1003, 1, 103, '2024-03-03', 300, 'Cancelled'),
(1004, 3, 101, '2024-03-03', 200, 'Delivered'),
(1005, 4, 104, '2024-03-04', 450, 'Delivered'),
(1006, 5, 102, '2024-03-05', 600, 'Delivered'),
(1007, 6, 103, '2024-03-06', 350, 'Delivered'),
(1008, 2, 105, '2024-03-07', 700, 'Delivered'),
(1009, 3, 101, '2024-03-08', 150, 'Delivered'),
(1010, 7, 104, '2024-03-09', 400, 'Delivered');


INSERT INTO deliveries VALUES
(301, 1001, 201, 'Completed'),
(302, 1002, 202, 'Completed'),
(303, 1004, 201, 'Completed'),
(304, 1005, 203, 'Completed'),
(305, 1006, 202, 'Completed'),
(306, 1007, 204, 'Completed'),
(307, 1008, 201, 'Completed'),
(308, 1009, 203, 'Completed'),
(309, 1010, 204, 'Completed');

INSERT INTO deliveries_partners VALUES
(201, 'Ramesh Kumar'),
(202, 'Suresh Yadav'),
(203, 'Pooja Singh'),
(204, 'Aman Khan');

INSERT INTO ratings VALUES
(401, 1, 101, 4),
(402, 2, 102, 5),
(403, 3, 101, 3),
(404, 4, 104, 4),
(405, 5, 102, 5),
(406, 6, 103, 4),
(407, 2, 105, 5),
(408, 3, 101, 4),
(409, 7, 104, 3);

# Task 1: Customers who placed at least one order
SELECT DISTINCT customer_id
FROM orders;

# Task 2: Total orders by each customer
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

# Task 3: Customers who never ordered
select c.customer_id, c.customer_name from customers c
left join orders o on c.customer_id= o.customer_id where o.order_id is null;
# Task 4: Customers who ordered on exactly 3 days
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_date) = 3;

# Task 5: Revenue per restaurant
SELECT restaurant_id, SUM(order_amount) AS revenue
FROM orders
GROUP BY restaurant_id;

# Task 6: Average rating per restaurant
SELECT restaurant_id, AVG(rating) AS avg_rating
FROM ratings
GROUP BY restaurant_id;

# Top 5 restaurants
SELECT restaurant_id, AVG(rating) AS avg_rating
FROM ratings
GROUP BY restaurant_id
ORDER BY avg_rating DESC
LIMIT 5;


-- Location in Delhi
# Task 8: Customers in Delhi
SELECT *
FROM customers
WHERE city = 'Delhi';

# Task 9: Orders by Mumbai customers
select c.customer_id , count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
where c.city = "Mumbai"
group by c.customer_id;

-- SECTION 4: Time Analysis
-- 🔹 Task 10: Orders in last 10 days
SELECT *
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 10 DAY;

-- 🟡 SECTION 5: Delivery Analysis
-- 🔹 Task 11: Delivery partners with more than 1 delivery
SELECT partner_id, COUNT(*) AS total_deliveries
FROM deliveries
GROUP BY partner_id
HAVING COUNT(*) > 1;

-- 🔹 Task 12: Partner with most customers
SELECT d.partner_id, COUNT(DISTINCT o.customer_id) AS customers_served
FROM deliveries d
JOIN orders o ON d.order_id = o.order_id
GROUP BY d.partner_id
ORDER BY customers_served DESC
LIMIT 1;

# Window Function
SELECT 
restaurant_id,
AVG(rating) AS avg_rating,
RANK() OVER (ORDER BY AVG(rating) DESC) AS ranking
FROM ratings
GROUP BY restaurant_id;

# ⭐ CTE Example
WITH revenue_cte AS (
    SELECT restaurant_id, SUM(order_amount) AS revenue
    FROM orders
    GROUP BY restaurant_id)
    SELECT *
FROM revenue_cte
WHERE revenue > 500;

select * from orders;
