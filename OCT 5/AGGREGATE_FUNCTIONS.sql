create database if not exists sales_db;
use sales_db;

create table sales_orders (
    order_id int primary key,
    customer_name varchar(100),
    city varchar(50),
    product_category varchar(50),
    product_name varchar(100),
    unit_price decimal(10,2),
);

insert into sales_orders values
(201, 'Ankit Verma', 'Chennai', 'Electronics', 'Laptop', 52000),
(202, 'Divya Menon', 'Kochi', 'Electronics', 'Mobile',21000),
(203, 'Suresh Babu', 'Chennai', 'Furniture', 'Sofa',32000),
(204, 'Harini Iyer', 'Coimbatore', 'Electronics', 'Tablet',16000),
(205, 'Manoj Kumar', 'Madurai', 'Furniture', 'Study Table',9500);

-- filter rows
select * from sales_orders where city = 'Chennai' and unit_price > 2000;

-- aggregate functions
select sum(quantity * unit_price) as revenue from sales_orders;
select count(*) as order_count from sales_orders;
select avg(unit_price) as avg_price from sales_orders;
select max(unit_price) as max_price from sales_orders;
select min(unit_price) as min_price from sales_orders;
