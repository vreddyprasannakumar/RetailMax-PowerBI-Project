from pathlib import Path
import csv
import random

# ==========================================
# Project Paths
# ==========================================

PROJECT_FOLDER = Path(__file__).resolve().parent.parent

DATA_FOLDER = PROJECT_FOLDER / "Data"

SALES_FILE = DATA_FOLDER / "fact_sales.csv"
RETURNS_FILE = DATA_FOLDER / "fact_returns.csv"

# ==========================================
# Return Reasons
# ==========================================

RETURN_REASONS = [
    "Defective Product",
    "Damaged in Transit",
    "Wrong Item Delivered",
    "Customer Changed Mind",
    "Quality Issues",
    "Size Issue"
]

# ==========================================
# Read Sales
# ==========================================

sales = []

with open(SALES_FILE, "r", encoding="utf-8") as file:

    reader = csv.DictReader(file)

    for row in reader:

        if row["order_status"] == "Completed":

            sales.append(row)

print(f"Completed Sales : {len(sales)}")

# ==========================================
# Select Returns
# ==========================================

number_of_returns = int(len(sales) * 0.02)

returned_sales = random.sample(sales, number_of_returns)

# ==========================================
# Create CSV
# ==========================================

with open(RETURNS_FILE, "w", newline="", encoding="utf-8") as file:

    writer = csv.writer(file)

    writer.writerow([
        "return_id",
        "sales_id",
        "date_id",
        "customer_id",
        "product_id",
        "return_quantity",
        "return_reason",
        "refund_amount"
    ])

    return_id = 1

    for sale in returned_sales:

        quantity = int(sale["quantity"])

        return_quantity = random.randint(1, quantity)

        refund = round(
            (float(sale["sales_amount"]) / quantity)
            * return_quantity,
            2
        )

        writer.writerow([
            return_id,
            sale["sales_id"],
            sale["date_id"],
            sale["customer_id"],
            sale["product_id"],
            return_quantity,
            random.choice(RETURN_REASONS),
            refund
        ])

        return_id += 1

print("=" * 40)
print("Returns Generated Successfully")
print(f"Total Returns : {return_id-1}")
print("=" * 40)