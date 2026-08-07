from pathlib import Path
import csv
import random

# ==========================================
# PROJECT PATHS
# ==========================================

PROJECT_FOLDER = Path(__file__).resolve().parent.parent

DATA_FOLDER = PROJECT_FOLDER / "Data"

DATE_FILE = DATA_FOLDER / "dim_date.csv"
PRODUCT_FILE = DATA_FOLDER / "dim_product.csv"
INVENTORY_FILE = DATA_FOLDER / "fact_inventory.csv"

# ==========================================
# LOAD DATES
# ==========================================

dates = []

with open(DATE_FILE, "r", encoding="utf-8") as file:

    reader = csv.DictReader(file)

    for row in reader:
        dates.append(int(row["date_id"]))

# ==========================================
# LOAD PRODUCTS
# ==========================================

products = []

with open(PRODUCT_FILE, "r", encoding="utf-8") as file:

    reader = csv.DictReader(file)

    for row in reader:
        products.append(int(row["product_id"]))

print(f"Dates Loaded    : {len(dates)}")
print(f"Products Loaded : {len(products)}")

# ==========================================
# CREATE INVENTORY
# ==========================================

with open(INVENTORY_FILE, "w", newline="", encoding="utf-8") as file:

    writer = csv.writer(file)

    writer.writerow([
        "inventory_id",
        "date_id",
        "product_id",
        "store_id",
        "stock_received",
        "stock_sold",
        "stock_available",
        "reorder_level"
    ])

    inventory_id = 1

    for store_id in range(1, 21):

        for product_id in products:

            date_id = random.choice(dates)

            stock_received = random.randint(50, 300)

            stock_sold = random.randint(10, stock_received)

            stock_available = stock_received - stock_sold

            reorder_level = random.randint(20, 60)

            writer.writerow([
                inventory_id,
                date_id,
                product_id,
                store_id,
                stock_received,
                stock_sold,
                stock_available,
                reorder_level
            ])

            inventory_id += 1

print("=" * 50)
print("Inventory Generation Completed")
print("=" * 50)
print(f"Inventory Records : {inventory_id-1}")
print(f"Output File : {INVENTORY_FILE}")
print("=" * 50)