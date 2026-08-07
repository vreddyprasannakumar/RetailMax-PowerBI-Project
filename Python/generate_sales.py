from pathlib import Path
import csv
import random

# =====================================================
# PROJECT PATHS
# =====================================================

PROJECT_FOLDER = Path(__file__).resolve().parent.parent

DATA_FOLDER = PROJECT_FOLDER / "Data"

PRODUCT_FILE = DATA_FOLDER / "dim_product.csv"
DATE_FILE = DATA_FOLDER / "dim_date.csv"
SALES_FILE = DATA_FOLDER / "fact_sales.csv"

# =====================================================
# LOAD DATE DIMENSION
# =====================================================

dates = []
weekend_dates = []
festival_dates = []

with open(DATE_FILE, "r", encoding="utf-8") as file:

    reader = csv.DictReader(file)

    for row in reader:

        date_id = int(row["date_id"])
        month = int(row["month_number"])

        dates.append(date_id)

        # Weekend Boost
        if int(row["is_weekend"]) == 1:
            weekend_dates.extend([date_id] * 3)

        # Festival Season Boost
        if month in [1, 10, 11, 12]:
            festival_dates.extend([date_id] * 4)

print(f"Dates Loaded : {len(dates)}")

sales_dates = dates + weekend_dates + festival_dates

# =====================================================
# LOAD PRODUCT DIMENSION
# =====================================================

products = {}

with open(PRODUCT_FILE, "r", encoding="utf-8") as file:

    reader = csv.DictReader(file)

    for row in reader:

        products[int(row["product_id"])] = {

            "selling_price": float(row["selling_price"]),
            "cost_price": float(row["cost_price"]),
            "category_id": int(row["category_id"])

        }

print(f"Products Loaded : {len(products)}")

# =====================================================
# GENERATE SALES
# =====================================================

PAYMENT_MODES = [
    "Cash",
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking"
]

ORDER_STATUS = [
    "Completed",
    "Returned",
    "Cancelled"
]

# =====================================================
# EMPLOYEE → STORE MAP
# =====================================================

employee_store = {}

employee_id = 1

for store in range(1, 21):

    employee_store[employee_id] = store
    employee_store[employee_id + 1] = store

    employee_id += 2

# =====================================================
# PRODUCT POPULARITY
# =====================================================

category_weights = {
    1: 18,   # Mobiles
    2: 8,    # Laptops
    3: 5,    # Televisions
    4: 4,    # Refrigerators
    5: 3,    # Washing Machines
    6: 10,   # Kitchen Appliances
    7: 2,    # Furniture
    8: 7,    # Men's Fashion
    9: 8,    # Women's Fashion
    10: 35   # Grocery
}

weighted_products = []

for product_id, product in products.items():

    weight = category_weights[product["category_id"]]

    weighted_products.extend([product_id] * weight)

with open(SALES_FILE, "w", newline="", encoding="utf-8") as file:

    writer = csv.writer(file)

    writer.writerow([
        "sales_id",
        "order_id",
        "date_id",
        "customer_id",
        "product_id",
        "employee_id",
        "store_id",
        "quantity",
        "unit_price",
        "discount",
        "sales_amount",
        "cost_amount",
        "profit",
        "payment_mode",
        "order_status"
    ])

    for sales_id in range(1, 50001):

        order_id = 100000 + sales_id

        date_id = random.choice(sales_dates)

        customer_id = random.randint(1, 1000)

        product_id = random.choice(weighted_products)

        employee_id = random.randint(1,40)

        store_id = employee_store[employee_id]

        product = products[product_id]

        selling_price = product["selling_price"]

        cost_price = product["cost_price"]

        category_id = product["category_id"]

        # ===============================
        # Quantity Business Rules
        # ===============================

        if category_id == 10:
            quantity = random.randint(2, 8)

        elif category_id in [8, 9]:
            quantity = random.randint(1, 4)

        else:
            quantity = random.randint(1, 2)

        # ===============================
        # Discount
        # ===============================

        gross_sales = selling_price * quantity
        cost_amount = round(cost_price * quantity, 2)

        # Maximum discount allowed while keeping at least 5% profit
        max_discount_percent = (
            (gross_sales - (cost_amount * 1.05))
            / gross_sales
        ) * 100

        max_discount_percent = max(0, min(max_discount_percent, 20))

        discount_percent = random.uniform(0, max_discount_percent)

        discount = round(
            gross_sales * discount_percent / 100,
            2
        )

        sales_amount = round(
            gross_sales - discount,
            2
        )

        profit = round(
            sales_amount - cost_amount,
            2
        )

        # Small chance of promotional loss-making sales
        if random.random() < 0.02:
            extra_discount = round(gross_sales * 0.08, 2)
            discount += extra_discount
            sales_amount -= extra_discount
            profit = round(sales_amount - cost_amount, 2)

        payment_mode = random.choices(
        ["UPI", "Credit Card", "Debit Card", "Cash", "Net Banking"],
        weights=[45, 20, 15, 15, 5],
        k=1
        )[0]

        order_status = random.choices(
            ORDER_STATUS,
            weights=[95,3,2],
            k=1
        )[0]

        writer.writerow([
            sales_id,
            order_id,
            date_id,
            customer_id,
            product_id,
            employee_id,
            store_id,
            quantity,
            selling_price,
            discount,
            sales_amount,
            cost_amount,
            profit,
            payment_mode,
            order_status
        ])
# =====================================================
# FINISHED
# =====================================================

print()
print("=" * 50)
print("RetailMax Sales Generator Completed")
print("=" * 50)
print(f"Sales Records Generated : {sales_id:,}")
print(f"Products Used           : {len(products)}")
print(f"Dates Used              : {len(dates)}")
print(f"Output File             : {SALES_FILE}")
print("=" * 50)