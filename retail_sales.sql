create database retail_sales;
use retail_sales;

select o.order_id,p.product_name,i.quantity,i.total_price from orders o
inner join order_items i on o.order_id =i.order_id
inner join products p on i.product_id = p.product_id;

select o.store_id,sum(i.total_price)as total_sales from orders o
inner join order_items i on o.order_id=i.order_id
group by o.store_id;

select p.product_name,sum(i.quantity) as total_quantity from order_items i
inner join products p on i.product_id = p.product_id
group by p.product_name 
order by total_quantity desc limit 5;

select c.customer_id,c.first_name,c.last_name, count(Distinct o.order_id)as total_orders,
sum(i.quantity) as total_items,
round(sum(i.total_price),2)as total_revenue from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_items i on o.order_id = i.order_id
group by c.customer_id,c.first_name,c.last_name;

 select c.customer_id,c.first_name,c.last_name, count(distinct o.order_id) as total_orders,
 sum(i.quantity)as total_items,
 round(sum(i.total_price),2)as total_revenue from customers c
 inner join orders o on c.customer_id = o.customer_id 
 inner join  order_items i on o.order_id = i.order_id
 group by c.customer_id, c.first_name,c.last_name;

select c.customer_id,c.first_name,c.last_name,
round(sum(i.total_price),2)as total_spend,
case when sum(i.total_price)<5000 then 'low'
when sum(i.total_price) between 5000 and 15000 then 'Medium ' else 'High'
end as customer_segment from customers c 
inner join orders o on c.customer_id=o.customer_id
inner join order_items i on o.order_id =i.order_id
group by c.customer_id,c.first_name,c.last_name;

select s.staff_id,s.first_name,s.last_name,
count(Distinct o.order_id)as total_orders,
round(sum(i.total_price),2)as total_sales from staffs s
inner join orders o on s.staff_id=o.staff_id
inner join order_items i on o.order_id=i.order_id
group by s.staff_id,s.first_name,s.last_name
order by total_sales DESC;

select store_id,product_id,quantity from stocks
where quantity<10
order by quantity asc;

create table customer_segment as select c.customer_id,c.first_name,c.last_name,
round(sum(i.total_price),2)as total_spend,
case when sum(i.total_price)<5000 then 'Low' 
when sum(i.total_price)between 5000 and 15000 then 'Medium' else 'High'
end as customer_segment from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_items i on o.order_id=i.order_id
group by c.customer_id,c.first_name,c.last_name;
