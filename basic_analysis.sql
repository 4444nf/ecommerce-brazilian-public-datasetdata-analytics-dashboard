-- Basic customer distribution analysis
-- Top 10 cities based on number of customers
-- Cities with more than 500 customers
-- Customer share (%) of the top 10 cities
-- Customer share (%) of the top 10 states


select count(c.customer_city), c.customer_city, s.state_name
from olist_customers_dataset as c 
inner join states as s
	on s.state_code = c.customer_state 
group by c.customer_city, c.customer_state, s.state_name
order by count(c.customer_city) desc
limit 10

select count(c.customer_city), c.customer_city, s.state_name
from olist_customers_dataset as c
inner join states as s
	on s.state_code = c.customer_state 
group by c.customer_city, s.state_name
having count(c.customer_city) >= 500
order by count(c.customer_city) desc


select 
	customer_city, 
	count(*) as customer_count,
	round(
		count(*)*100.0/
			(
			select count(*)
			from olist_customers_dataset
			),
		2) as customer_share_percent
from olist_customers_dataset as c
group by c. customer_city
order by customer_count desc
limit 10

select s.state_name,
	count(*) as customer_count,
	round(
		count(*)*100.0/
		(
			select count(*)
			from olist_customers_dataset
		),
	2) as customer_share_percent
from states as s
inner join olist_customers_dataset as c
	on s.state_code = c.customer_state
group by s.state_name
order by customer_count desc
limit 10