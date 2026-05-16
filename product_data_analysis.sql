alter table products_dataset_en
rename column product_category_name_english to category_name


--product-order ratio
select p.category_name,
	round(count(*)*100.00/
		( 
			select count(*)
			from olist_order_items_dataset
		),2) as product_order_ratio
from olist_order_items_dataset as i
inner join products_dataset_en as p
	on i.product_id = p.product_id
group by p.category_name
order by product_order_ratio ASC



--the top 1% sellers in terms of product counts
with seller_products_count as 
( 
	select 
		count(*) as seller_product_count
					,seller_id
	from olist_order_items_dataset as i
	group by seller_id
)
,ranked as
( 
	select s.*,
		p.seller_product_count
		,row_number() OVER(order by p.seller_product_count DESC) as rn
		,count(*) over() as total
	from olist_sellers_dataset as s
	inner join seller_products_count as p
		on s.seller_id = p.seller_id
)
select *
from ranked as rn
where rn <= total * 0.01


--the top 1% sellers in terms of total product value
with seller_revenue as 
(
	select sum(price) as total_revenue, seller_id
	from olist_order_items_dataset as sp
	group by sp.seller_id
)
, ranked as 
(
	select 
		s.seller_id,
		total_revenue,
		row_number() OVER(order by total_revenue desc) as rn,
		count(*) over() as total
	from seller_revenue as s
)
select *
from ranked
where rn <= total * 0.01


--the descriptive statistics for the price
select
	count(price) as count,
	avg(price) as main,
	stddev(price) as standard_deviation,
	min(price) as min,
	max(price) as max,
	percentile_cont(0.25) within group(order by price) as q1,
	percentile_cont(0.50) within group(order by price) as q1,	
	percentile_cont(0.75) within group(order by price) as q1
from olist_order_items_dataset

	
--the descriptive statistics for the freight_value	
select
	count(freight_value) as count,
	avg(freight_value) as main,
	stddev(freight_value) as standard_deviation,
	min(freight_value) as min,
	max(freight_value) as max,
	percentile_cont(0.25) within group(order by freight_value) as q1,
	percentile_cont(0.50) within group(order by freight_value) as q1,	
	percentile_cont(0.75) within group(order by freight_value) as q1
from olist_order_items_dataset




