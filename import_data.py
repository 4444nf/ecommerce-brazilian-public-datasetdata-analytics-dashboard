import pandas as pd
from sqlalchemy import create_engine
import configparser


file_list = ["olist_customers_dataset.csv",
             "olist_geolocation_dataset.csv",
             "olist_order_items_dataset.csv",
             "olist_order_payments_dataset.csv",
             "olist_order_reviews_dataset.csv",
             "olist_orders_dataset.csv",
             "olist_products_dataset.csv",
             "olist_sellers_dataset.csv",
             "product_category_name_translation.csv"]

config = configparser.ConfigParser()
config.read('database.ini')

db = config["database"]

connection_string = (
    f"postgresql+psycopg2://{db['user']}:{db['password']}"
    f"@{db['host']}:{db['port']}/{db['name']}"
)

engine = create_engine(connection_string)


for file in file_list:
    df = pd.read_csv(file)
    table_name = file.replace(".csv", "")
    df.to_sql(table_name, engine, if_exists="replace", index= False)
    print(f"{table_name} imported successfully")