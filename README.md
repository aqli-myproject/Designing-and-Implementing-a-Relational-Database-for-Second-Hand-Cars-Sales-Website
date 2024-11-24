# Designing and Implementing a Relational Database for Second-Hand Cars Sales Website with PostgreSQL
- by; Mohammad Isyroful Aqli
- project: SQL & Relational Database | Sekolah Data Pacmann.ai

## Project Objective
"Creating a well-organized and efficient database system for a second-hand cars sales platform where users can easily post their car ads,
and buyers can search, compare, and connect with sellers based on what they’re looking for. The database is built to support cool features
like filtering by brand, model, body type, and location, plus a price offer option to make deals more flexible and fun for everyone."
This database structure is expected to be able to:
- Managing user accounts profiles
- Listing cars for sale with detailed specifications
- Handling the bidding process
- Tracking car locations
- Managing car advertisements

## Feature & Limitations
Here are the features and limitations of this project:
1.	Each user can sell more than one used car through the app.
2.	Before listing a car for sale, users must complete their profile, including details like name, contact information, and location.
3.	Users advertise their cars through listings displayed on the website.
4.	Each listing includes a title, detailed information about the car, and the seller's contact details.
5.	Some mandatory information to include in the listing:
   - Car brand: Toyota, Daihatsu, Honda, etc.
   - Model: Toyota Yaris, Toyota Corolla Altis, Toyota Vios, Toyota Camry Hybrid, etc.
   - Car body type: MPV, SUV, Van, Sedan, Hatchback, etc.
   - Transmission type: manual or automatic
   - Year of manufacture: 2005, 2010, 2011, 2020, etc.
6.  Additional details like color, mileage, etc., can be added as needed:
- Users can search for cars based on the seller’s location, car brand, and body type.
- If a buyer is interested in a car, they can bid on the price if the seller enables the bidding feature.
- Transactions are conducted outside the app, so they are not within the scope of this project.

## ERD Design
![ERD Diagram](https://github.com/aqli-myproject/Designing-and-Implementing-a-Relational-Database-for-Second-Hand-Cars-Sales-Website/blob/main/erd%20website%20car%20sales%20drawio.jpg)

## Tools
- postgreSQL & Dbeaver
- Python Jupyter Notebook
- draw.io

## Create Tabel Query
I'll provide step-by-step instructions for creating these tables in PostgreSQL using DBeaver. I'll write them in order based on their relationships to avoid foreign key constraints issues:
Steps to implement in DBeaver:
1.	Open DBeaver and connect to your PostgreSQL database
2.	Right-click on your database
3.	Select "SQL Editor" → "New SQL Script"
4.	Copy and paste each CREATE TABLE statement
5.	Execute the statements in the order shown above
6.	To execute:
   - Either click the "Execute SQL Statement" button (lightning bolt icon)
   - Or press Ctrl + Enter (Windows/Linux) or Cmd + Enter (Mac)
7.	Check each table after creation by:
  - Expanding your database in the navigation tree
  - Click on "Tables" to see all created tables
  - Right-click on each table and select "View table" to verify structure
After creation, you can verify the relationships by:
1.	Right-click on any table
2.	Select "Properties"
3.	Go to "Foreign Keys" tab to see the relationships

For more details, please check the attached file = Script-5 Create Table Query.sql

## Create Dummy Dataset With Faker
  Data to Generate: I focus on creating 4 tables, while 1 table location is ready and table car_product is modified:
- Car_product: Contains detailed car product information and ownership of each seller user, Includes car attributes such as brand, model, year, and price.
- User: Contains user details like ID, name, email, phone number, and city.
- Advertisement: Car listings with titles and descriptions.
- Bid: User offers for listed cars.
For more details, please check the attached file = creating dummy data used car sales website.ipynb

## Query Import Data
step-by-step how to import the data into PostgreSQL using DBeaver:
1.	Prepare CSV Files:
- Ensure all CSV files (e.g., location_table.csv, user_table.csv) are correctly formatted with column names matching the table structure in PostgreSQL database.
- - Place these files in an accessible directory, such as C:\Users\Aqli\opsional project sql\. (adjust to your path)
2.	Open DBeaver:
- Launch DBeaver and connect to PostgreSQL database. Use credentials to log in.
3.	Create Tables in PostgreSQL:
- Before importing data, ensure the necessary tables (location, user, car_product, advertisement, bid) are already created in database.
- Check the table structures to confirm the column names and types match those in our CSV files.
4.	Run the Import Commands:
- In DBeaver, open a SQL Editor connected to database.
- Copy and paste the provided COPY commands into the SQL Editor. 
For more details, please check the attached file = Script-7 Import Data Query.sql

## Query Retrieval Data
I created 2 categories of data retrieval, the first is transactional and the second is analytical, all case queries can be done from the database that has been created,
such as finding the highest popularity of car brands and models, finding user patterns in car purchases, finding the right car pricing strategy. for more information, you can visit my medium blog too.
For more details, please check the attached file = Script-8 Analytical Query.sql and Script-6 Transactional Query.sql

