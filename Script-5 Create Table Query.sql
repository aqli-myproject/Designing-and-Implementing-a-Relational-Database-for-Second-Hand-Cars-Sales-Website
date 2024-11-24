-- Tabel Location
CREATE TABLE location (
    location_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL,
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL
);

-- Tabel User
CREATE TABLE "user" (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, -- Email unik untuk setiap pengguna
    phone_number VARCHAR(50) NOT NULL, -- Nomor telepon pengguna
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Tabel Car_Product
CREATE TABLE car_product (
    product_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    body_type VARCHAR(50) NOT NULL,
    transmission VARCHAR(50) NOT NULL CHECK (transmission IN ('Manual', 'Automatic')), -- Hanya dua pilihan valid
    year INT NOT NULL CHECK (year BETWEEN 1900 AND EXTRACT(YEAR FROM CURRENT_DATE)), -- Tahun harus dalam rentang valid
    colour VARCHAR(50),
    mileage INT CHECK (mileage >= 0), -- Kilometer harus non-negatif
    price DECIMAL(12, 2) NOT NULL CHECK (price > 0), -- Harga harus lebih dari 0
    bid_allowed BOOLEAN DEFAULT FALSE,
    location_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Tabel Advertisement
CREATE TABLE advertisement (
    ad_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    date_post DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES car_product(product_id)
);

-- Tabel Bid
CREATE TABLE bid (
    bid_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    bid_amount DECIMAL(12, 2) NOT NULL CHECK (bid_amount > 0), -- Tawaran harus lebih dari 0
    bid_date DATE NOT NULL,
    bid_status VARCHAR(25),
    FOREIGN KEY (product_id) REFERENCES car_product(product_id),
    FOREIGN KEY (user_id) REFERENCES "user"(user_id)
);