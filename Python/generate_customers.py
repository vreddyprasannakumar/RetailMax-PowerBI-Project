from faker import Faker
from pathlib import Path
import csv
import random
from datetime import datetime, timedelta

fake = Faker("en_IN")

project_folder = Path(__file__).resolve().parent.parent
data_file = project_folder / "Data" / "dim_customer.csv"

print("Project Folder:", project_folder)
print("Data File:", data_file)

cities = [
    "Hyderabad", "Bangalore", "Chennai", "Mumbai", "Pune",
    "Ahmedabad", "Jaipur", "Delhi", "Lucknow", "Kolkata",
    "Bhubaneswar", "Visakhapatnam", "Vijayawada", "Mysore",
    "Coimbatore", "Nashik", "Surat", "Warangal", "Kochi", "Noida"
]

with open(data_file, "w", newline="", encoding="utf-8") as file:

    writer = csv.writer(file)

    writer.writerow([
        "customer_id",
        "first_name",
        "last_name",
        "gender",
        "date_of_birth",
        "phone",
        "email",
        "city",
        "region_id",
        "customer_segment",
        "registration_date"
    ])

    for customer_id in range(1, 1001):

        first_name = fake.first_name()
        last_name = fake.last_name()

        gender = random.choice(["Male", "Female"])

        dob = fake.date_between(start_date="-60y", end_date="-18y")

        phone = "9" + "".join(random.choices("0123456789", k=9))

        email = (
            first_name.lower()
            + "."
            + last_name.lower()
            + str(customer_id)
            + "@gmail.com"
        )

        city = random.choice(cities)

        region_id = random.randint(1, 12)

        customer_segment = random.choices(
            ["Regular", "Silver", "Gold", "Platinum"],
            weights=[60, 25, 10, 5],
            k=1
        )[0]

        registration_date = fake.date_between(
            start_date="-3y",
            end_date="today"
        )

        writer.writerow([
            customer_id,
            first_name,
            last_name,
            gender,
            dob,
            phone,
            email,
            city,
            region_id,
            customer_segment,
            registration_date
        ])

    print("dim_customer.csv generated successfully!")