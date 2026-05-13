-- Created a normalized product table with English category names
-- to support foreign key relationships across the database.

drop table if exists products_dataset_en

create table products_dataset_en as
select
    p.product_id,
    t.product_category_name_english as product_category_name,
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
from olist_products_dataset p
left join  product_category_name_translation t
    on t.product_category_name = p.product_category_name
    
alter table products_dataset_en
add primary key (product_id)

ALTER TABLE olist_order_items_dataset
DROP CONSTRAINT fk_item_product

alter table olist_order_items_dataset
add constraint fk_item_product
foreign key (product_id)
references products_dataset_en (product_id)