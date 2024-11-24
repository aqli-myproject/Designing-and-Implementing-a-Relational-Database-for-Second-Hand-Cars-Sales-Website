-- creating transactional query
-- case 1 mencari mobil keluaran 2015 keatas
select
	product_id,
	brand,
	model,
	year,
	price
from car_product cp
where year >= 2015
order by
	year asc,
	product_id asc;
	
-- case 2 menambahkan data bid baru
INSERT INTO bid(bid_id, product_id, user_id, bid_date, bid_amount, bid_status)
VALUES (101, 24,75,'2024-11-20',105000000,'Sent');

-- case 3 melihat semua mobil yang dijual 1 akun dari yang paling baru
select
	cp.product_id,
	cp.brand,
	cp.model,
	cp.year,
	cp.price,
	a.date_post
from car_product cp 
join "user" u using (user_id)
join advertisement a using (product_id)
where u.name = 'Heru Padmasari'
order by a.date_post desc; -- urut dari tanggal paling baru

-- case 4 mencari mobil yang termurah berdasarkan keyword
select
	product_id,
	brand,
	model,
	year,
	price
from car_product cp 
where lower(model) like '%yaris%'
order by price asc;

-- case 5 mencari mobil bekas yang terdekat berdasarkan location_id
select
	cp.product_id,
	cp.brand,
	cp.model,
	cp.year,
	cp.price
FROM car_product cp
JOIN "user" u ON cp.user_id = u.user_id
JOIN advertisement a ON cp.product_id = a.product_id 
JOIN location l ON u.location_id = l.location_id
WHERE l.location_id = 3173
ORDER BY SQRT(POW(l.latitude - (-6.1352), 2) + POW(l.longitude - 106.813301, 2));