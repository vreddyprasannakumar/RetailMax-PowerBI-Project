from pathlib import Path
from faker import Faker
import csv
import random

fake = Faker("en_IN")

# Project folder and output file
project_folder = Path(__file__).resolve().parent.parent
data_file = project_folder / "Data" / "dim_product.csv"

# Business Rules
category_data = {
    1: {
        "name": "Mobiles",
        "brands": ["Apple", "Samsung", "OnePlus", "Xiaomi", "Vivo"],
        "products": ["Pro", "Plus", "Ultra", "Max", "Note"]
    },

    2: {
        "name": "Laptops",
        "brands": ["Dell", "HP", "Lenovo", "ASUS", "Acer"],
        "products": ["Inspiron", "Pavilion", "ThinkPad", "Vivobook", "Aspire"]
    },

    3: {
        "name": "Televisions",
        "brands": ["Sony", "LG", "Samsung", "TCL"],
        "products": ["Bravia", "OLED", "Crystal", "QLED"]
    },

    4: {
        "name": "Refrigerators",
        "brands": ["LG", "Whirlpool", "Godrej", "Samsung"],
        "products": ["Frost Free", "Double Door", "Convertible"]
    },

    5: {
        "name": "Washing Machines",
        "brands": ["IFB", "Bosch", "LG", "Whirlpool"],
        "products": ["Front Load", "Top Load", "Fully Automatic"]
    },

    6: {
        "name": "Kitchen Appliances",
        "brands": ["Prestige", "Philips", "Butterfly"],
        "products": ["Mixer", "Cooktop", "Air Fryer", "Induction Stove"]
    },

    7: {
        "name": "Furniture",
        "brands": ["Godrej", "Nilkamal", "IKEA"],
        "products": ["Sofa", "Dining Table", "Wardrobe", "Office Chair"]
    },

    8: {
        "name": "Men's Fashion",
        "brands": ["Levi's", "Puma", "Adidas"],
        "products": ["T-Shirt", "Jeans", "Shirt", "Jacket"]
    },

    9: {
        "name": "Women's Fashion",
        "brands": ["Biba", "W", "Aurelia"],
        "products": ["Kurti", "Dress", "Top", "Leggings"]
    },

    10: {
        "name": "Grocery",
        "brands": ["Aashirvaad", "Fortune", "ITC", "Tata"],
        "products": ["Rice", "Atta", "Oil", "Sugar"]
    }
}

with open(data_file, "w", newline="", encoding="utf-8") as file:

    writer = csv.writer(file)

    writer.writerow([
        "product_id",
        "product_name",
        "brand",
        "category_id",
        "supplier_id",
        "cost_price",
        "selling_price",
        "warranty_months",
        "launch_date",
        "is_active"
    ])

    for product_id in range(1, 501):

        category_id = random.randint(1, 10)
        category = category_data[category_id]

        brand = random.choice(category["brands"])
        product_type = random.choice(category["products"])

        product_name = f"{brand} {product_type}"

        supplier_id = random.randint(1, 12)

        cost_price = random.randint(500, 80000)

        markup = random.uniform(1.10, 1.35)
        selling_price = round(cost_price * markup, 2)

        if category_id in [1, 2, 3, 4, 5, 6]:
            warranty_months = random.choice([12, 24, 36])
        else:
            warranty_months = 0

        launch_date = fake.date_between(
            start_date="-5y",
            end_date="today"
        )

        is_active = random.choices(
            [1, 0],
            weights=[95, 5],
            k=1
        )[0]

        writer.writerow([
            product_id,
            product_name,
            brand,
            category_id,
            supplier_id,
            cost_price,
            selling_price,
            warranty_months,
            launch_date,
            is_active
        ])

print("dim_product.csv generated successfully!")