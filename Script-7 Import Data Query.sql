-- import data tabel location
COPY "location"(location_id, city_name, latitude, longitude)
FROM 'C:\Users\Ervan\opsional project sql\location_table.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel user
COPY "user"(user_id, name, email, phone_number, location_id)
FROM 'C:\Users\Ervan\opsional project sql\user_table.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel car_product
COPY car_product(product_id, user_id, brand, model, body_type, transmission, year, colour, mileage, price, bid_allowed, location_id)
FROM 'C:\Users\Ervan\opsional project sql\product_table.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel advertisement
COPY advertisement(ad_id, product_id, title, description, date_post)
FROM 'C:\Users\Ervan\opsional project sql\adevertisement_table.csv'
DELIMITER ','
CSV HEADER;

-- import data tabel bid
COPY bid(bid_id, product_id, user_id, bid_amount, bid_date, bid_status)
FROM 'C:\Users\Ervan\opsional project sql\bid_table_new.csv'
DELIMITER ','
CSV HEADER;

-- cek result data
SELECT * FROM "location"
SELECT * FROM "user"
SELECT * FROM car_product
SELECT * FROM advertisement
SELECT * FROM bid