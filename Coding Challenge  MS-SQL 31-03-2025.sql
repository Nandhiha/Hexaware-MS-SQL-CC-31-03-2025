--creating database

create database Ecommerce
use Ecommerce

--creating tables

/* SQL Tables:
1. customers table:
• customer_id (Primary Key)
• name
• email
• password
2. products table:
• product_id (Primary Key)
• name
• price
• description
• stockQuantity
3. cart table:
• cart_id (Primary Key)
• customer_id (Foreign Key)
• product_id (Foreign Key)
• quantity
4. orders table:
• order_id (Primary Key)
• customer_id (Foreign Key)
• order_date
• total_price
• shipping_address
5. order_items table (to store order details):
• order_item_id (Primary Key)
• order_id (Foreign Key)
• product_id (Foreign Key)
• quantity */


create table customers (
    customer_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    address varchar(255),
    password varchar(100)
)


create table products (
    product_id int primary key,
    name varchar(100),
    description text,
    price decimal(10,2),
    stockQuantity int
)

create table cart (
    cart_id int primary key,
    customer_id int,
    product_id int,
    quantity int,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
)

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_price decimal(10,2),
    shipping_address varchar(255),
    foreign key (customer_id) references customers(customer_id)
)

create table order_items (
    order_item_id int primary key,
    order_id int,
    product_id int,
    quantity int,
    itemAmount decimal(10,2),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
)

--inserting values into customers table

insert into customers (customer_id,first_name,last_name,email,address,password) values
(1,'John','Doe','johndoe@example.com','123 Main St,City','password1'),
(2,'Jane','Smith','janesmith@example.com','456 Elm St,Town','password2'),
(3,'Robert','Johnson','robert@example.com','789 Oak St,Village','password3'),
(4,'Sarah','Brown','sarah@example.com','101 Pine St,Suburb','password4'),
(5,'David','Lee','david@example.com','234 Cedar St,District','password5'),
(6,'Laura','Hall','laura@example.com','567 Birch St,County','password6'),
(7,'Michael','Davis','michael@example.com','890 Maple St,State','password7'),
(8,'Emma','Wilson','emma@example.com','321 Redwood St,Country','password8'),
(9,'William','Taylor','william@example.com','432 Spruce St,Province','password9'),
(10,'Olivia','Adams','olivia@example.com','765 Fir St,Territory','password10');
select *from customers


--inserting values into products

insert into products(product_id,name,description,price,stockQuantity) values
(1,'Laptop','High-performance laptop',800.00,10),
(2,'Smartphone','Latest smartphone',600.00,15),
(3,'Tablet','Portable tablet',300.00,20),
(4,'Headphones','Noise-canceling',150.00,30),
(5,'TV','4K Smart TV',900.00,5),
(6,'Coffee Maker','Automatic coffee maker',50.00,25),
(7,'Refrigerator','Energy-efficient',700.00,10),
(8,'Microwave Oven','Countertop microwave',80.00,15),
(9,'Blender','High-speed blender',70.00,20),
(10,'Vacuum Cleaner','Bagless vacuum cleaner',120.00,10);
select * from products


--inserting values into cart
insert into cart (cart_id,customer_id,product_id,quantity) values
(1,1,1,2),
(2,1,3,1),
(3,2,2,3),
(4,3,4,4),
(5,3,5,2),
(6,4,6,1),
(7,5,1,1),
(8,6,10,2),
(9,6,9,3),
(10,7,7,2)
select * from cart


--inserting values into orders 

insert into orders (order_id,customer_id,order_date,total_price,shipping_address) values
(1,1,'2023-01-05',1200.00,'123 Main St,City'),
(2,2,'2023-02-10',900.00,'456 Elm St,Town'),
(3,3,'2023-03-15',300.00,'789 Oak St,Village'),
(4,4,'2023-04-20',150.00,'101 Pine St,Suburb'),
(5,5,'2023-05-25',1800.00,'234 Cedar St,District'),
(6,6,'2023-06-30',400.00,'567 Birch St,County'),
(7,7,'2023-07-05',700.00,'890 Maple St,State'),
(8,8,'2023-08-10',160.00,'321 Redwood St,Country'),
(9,9,'2023-09-15',140.00,'432 Spruce St,Province'),
(10,10,'2023-10-20',1400.00,'765 Fir St,Territory')

select * from orders

--inserting values in order_items

insert into order_items (order_item_id,order_id,product_id,quantity,itemAmount) values
(1,1,1,2,1600.00),
(2,1,3,1,300.00),
(3,2,2,3,1800.00),
(4,3,5,2,1800.00),
(5,4,4,4,600.00),
(6,4,6,1,50.00),
(7,5,1,1,800.00),
(8,5,2,2,1200.00),
(9,6,10,2,240.00),
(10,6,9,3,210.00)

select * from order_items

--view all tables
select * from customers
select * from products
select * from cart
select * from orders
select * from order_items



--Tasks

--1. Update refrigerator product price to 800.
update products 
set price=800 
where name='refrigerator'

-- 2.remove all cart items for a specific customer.
delete from cart 
where customer_id=5;
select * from cart



--3.retrieve products priced below $100.
select * from products 
where price<100;

--4.find products with stock quantity greater than 5.
select * from products 
where stockQuantity>5;

--5.retrieve orders with total amount between $500 and $1000.
select * from orders 
where total_price between 500 and 1000

--6.Find products which name end with letter ‘r’.
select * from products 
where name like '%r'

--7.Retrieve cart items for customer 5.
select * from cart 
where customer_id=5  --no output because in task 2 I have removed customer_id=5

-- 8. find customers who placed orders in 2023.
select distinct customers.*  
from customers  
join orders on customers.customer_id=orders.customer_id  
where year(order_date)=2023

-- 9.Determine the minimum stock quantity for each product category.
select name,stockQuantity  
from products  
where stockQuantity=(select min(stockQuantity) from products);

-- 10. calculate the total amount spent by each customer.
select orders.customer_id,sum(total_price) as total_spent 
from orders 
group by orders.customer_id;

-- 11.Find the average order amount for each customer.
select customer_id,avg(total_price) as avg_order_amount 
from orders 
group by customer_id

-- 12. count the number of orders placed by each customer.
select customer_id,count(order_id) as total_orders 
from orders 
group by customer_id


-- 13.Find the maximum order amount for each customer.
select customer_id,max(total_price) as max_order_amount 
from orders 
group by customer_id


--14.Get customers who placed orders totaling over $1000.
select c.customer_id,c.first_name,c.last_Name  
from customers c  
join orders o on c.customer_id=o.customer_id  
group by c.customer_id,c.first_Name,c.last_Name  
having sum(o.total_price)>1000;


-- 15.Subquery to find products not in the cart.
select * from products  
where product_id not in(select product_id from cart)



-- 16. subquery to find customers who haven't placed orders.
select * from customers  
where customer_id not in(select customer_id from orders)--no output since everyone has placed order
insert into customers(customer_id,first_name,last_name,email,address, password)
values (11,'Lilly','Andrew','lilly@example.com','987 batt St,','password11')
select * from customers  
where customer_id not in(select customer_id from orders)

























-- 17. subquery to calculate the percentage of total revenue for a product.
select product_id,  
       (sum(itemAmount)*100/(select sum(itemAmount)from order_items))as rev_percentage
from order_items  
group by product_id


-- 18. subquery to find products with low stock.
select * from products 
where stockQuantity<(select avg(stockQuantity) from products)


-- 19. subquery to find customers who placed high-value orders.
select customer_id,first_name,last_name  
from customers  
where customer_id in (  
    select customer_id from orders  
    where total_price>(select avg(total_price) from orders)  
)




































