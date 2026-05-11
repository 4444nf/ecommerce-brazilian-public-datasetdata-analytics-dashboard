import pandas as pd
from sqlalchemy import create_engine
import os

base_path = r"C:\Brazilian_data\project"

file_list = ["olist_customers_dataset.csv",
             "olist_geolocation_dataset.csv",
             "olist_order_items_dataset.csv",
             "olist_order_payments_dataset.csv",
             "olist_order_reviews_dataset.csv",
             "olist_orders_dataset.csv",
             "olist_products_dataset.csv",
             "olist_sellers_dataset.csv",
             "product_category_name_translation.csv"]

with open(os.path.join(base_path, "db_connection_info"), "r", encoding="utf-8") as f:
    db_connection_info = f.read().strip()

engine = create_engine(db_connection_info)


for file in file_list:
    df = pd.read_csv(file)
    table_name = file.replace(".csv", "")
    df.to_sql(table_name, engine, if_exists="replace", index= False)
    print(f"{table_name} imported successfully")
