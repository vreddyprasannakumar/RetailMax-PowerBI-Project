from datetime import datetime, timedelta
from pathlib import Path
import csv

start_date = datetime(2022, 1, 1)
end_date = datetime(2024, 12, 31)

data_file = Path(__file__).parent.parent / "Data" / "dim_date.csv"

with open(data_file, "w", newline="") as file:
    writer = csv.writer(file)

    writer.writerow([
        "date_id",
        "full_date",
        "day_number",
        "day_name",
        "week_number",
        "month_number",
        "month_name",
        "quarter_number",
        "year_number",
        "is_weekend"
    ])

    current_date = start_date

    while current_date <= end_date:

        date_id = int(current_date.strftime("%Y%m%d"))
        full_date = current_date.strftime("%Y-%m-%d")
        day_number = current_date.day
        day_name = current_date.strftime("%A")
        week_number = current_date.isocalendar().week
        month_number = current_date.month
        month_name = current_date.strftime("%B")
        quarter_number = (current_date.month - 1) // 3 + 1
        year_number = current_date.year
        is_weekend = 1 if current_date.weekday() >= 5 else 0

        writer.writerow([
            date_id,
            full_date,
            day_number,
            day_name,
            week_number,
            month_number,
            month_name,
            quarter_number,
            year_number,
            is_weekend
        ])

        current_date += timedelta(days=1)

    print("dim_date.csv generated successfully!")