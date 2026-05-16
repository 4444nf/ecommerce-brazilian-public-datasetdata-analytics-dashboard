-- top ten cities, states that have the most sellers
select count(s.seller_city), s.seller_city, st.state_name
from olist_sellers_dataset as s
inner join states as st
	on st.state_code = s.seller_state 
group by s.seller_city, st.state_name
order by count(s.seller_city) desc
limit 10

--Seller shares of the top ten cities
select s.seller_city,
	count(*) as seller_count,
	round(
		count(*)*100.0/
		(
			select count(*)
			from olist_sellers_dataset
		),
	2) as seller_share_percent
from olist_sellers_dataset as s
group by s.seller_city
order by seller_count desc
limit 10

--Seller shares of the top ten states
select st.state_name,
	count(*) as seller_count,
	round(
		count(*)*100.0/
		(
			select count(*)
			from olist_sellers_dataset
		),
	2) as seller_share_percent
from olist_sellers_dataset as s
inner join states as st
	on st.state_code = s.seller_state 
group by st.state_name
order by seller_count desc
limit 10