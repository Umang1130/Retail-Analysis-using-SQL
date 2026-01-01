--customers who have never placed any order
select customer_id, customer_name
from customers
where customer_id not in ( select customer_id from orders);


--total number of orders and total quantity purchased by each customer
select c.customer_id, c.customer_name, count( o.order_id) as total_orders,
        sum(o.quantity) as total_quantity
from orders o
join customers c on c.customer_id = o.customer_id
join products p on p.product_id = o.product_id
group by c.customer_id;


--the top 3 customers by total spending
select c.customer_id, c.customer_name, sum(o.quantity*p.price) as total_spending
from orders o
join customers c on c.customer_id = o.customer_id
join products p on p.product_id = o.product_id
group by c.customer_id
order by sum(o.quantity*p.price) desc
limit 3;


--products that have been ordered more than once, but not the highest selling product
select p.product_id, p.product_name, sum(o.quantity) as total_sold
from orders o
join products p on p.product_id = o.product_id
group by p.product_id
having sum(o.quantity) > 1 and sum(o.quantity) < ( select max(qty)
                                                   from ( select sum(quantity) as qty
												          from orders
														  group by product_id));


--the average order value (AOV)
select c.customer_id, c.customer_name, sum(p.price*o.quantity) as total_revenue, 
       count(distinct o.order_id) as no_of_orders, 
	   sum(p.price*o.quantity)/count(o.order_id) as average_order_value 
from orders o
join customers c on c.customer_id = o.customer_id
join products p on p.product_id = o.product_id
group by c.customer_id;


--each customer’s first order date
select c.customer_id, min(o.order_date) as first_order_date
from orders o
join customers c on c.customer_id = o.customer_id
group by c.customer_id;


--customers who bought more than one different product
select c.customer_id, c.customer_name, count(distinct o.product_id) as no_of_prodcuts
from orders o
join customers c on c.customer_id = o.customer_id
join products p on p.product_id = o.product_id
group by c.customer_id
having count(distinct o.product_id) > 1;


--total revenue by product category
select p.category, sum(o.quantity*p.price) as total_revenue
from orders o
join products p on p.product_id = o.product_id
group by p.category;


--customers who placed an order in March 2023 only (not before, not after)
select c.customer_id, c.customer_name, o.order_date
from orders o
join customers c on c.customer_id = o.customer_id
where extract(month from o.order_date) = 3 and 
      extract(year from o.order_date) = 2023;


--the best selling product
select p.product_name, p.category, sum(o.quantity) as total_quantity
from orders o
join products p on p.product_id = o.product_id
group by p.product_name, p.category
order by total_quantity desc
limit 1;


--Sales by the months
select to_char(order_date, 'month YYYY') as months, count(o.order_id) as no_of_orders
       , sum(o.quantity*p.price) as total_sales
from orders o
join products p on p.product_id = o.product_id
join customers c on c.customer_id = o.customer_id
group by months 
order by months desc;


--the revenue generated from each city
select c.city, sum(o.quantity*p.price) as total_revenue
from orders o
join products p on p.product_id = o.product_id
join customers c on c.customer_id = o.customer_id
group by c.city;


--