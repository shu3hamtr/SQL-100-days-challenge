-- Day 2

create table orders(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into orders values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','refrigerator',123,299.99,'2022/03/02'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');

/*
Find top categories and product based on the spend.
*/

select category, product, spend from
(Select *, Dense_Rank() over(partition by product order by spend desc) as rn 
from orders) t
where rn = 1
Group by category, product, spend
order by spend desc

/*
Find top 2 products in top 2 products based on the spend amount

top 2 categories based on spend
top 2 products in above best 2 categories
*/

with ranked_category as (
select category, total_spend from (select Category, sum(spend) as total_spend,
Dense_rank() over(order by sum(spend) desc) as rn
from orders
group by category) t
where rn <= 2
group by category
)
select category, product, total_spend_by_product
from (
select o.category, o.product,
sum(o.spend) as total_spend_by_product,
Dense_rank() over(partition by o.category order by sum(o.spend) desc) as pdrn
from orders o
join ranked_category rc
on o.category = rc.category
group by o.category, o.product) t2
where pdrn <=2

