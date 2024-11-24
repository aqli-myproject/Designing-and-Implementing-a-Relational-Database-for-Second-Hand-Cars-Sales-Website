-- creating analytical query
-- case 1 rangking popularitas model mobil berdasarkan jumlah bid
select 
	cp.model,
	count(distinct b.product_id) as count_product,
	count(b.bid_id) as count_bid
from car_product cp
left join bid b using (product_id)
left join advertisement a using (product_id)
group by model
order by count_bid desc, count_Product desc;
	
-- case 2 perbadingan harga mobil berdasarkan harga rata2 per kota
select
	l.city_name,
	cp.brand,
	cp.model,
	cp.year,
	cp.price,
	AVG(cp.price) OVER (PARTITION BY l.city_name) AS avg_car_city
from car_product cp 
join "location" l using (location_id)
order by avg_car_city asc 

-- case 3 perbandingan bid user pertama dengan bid selanjutnya
select
	cp.model,
	b1.user_id,
	b1.bid_date AS first_bid_date,
	b2.bid_date AS next_bid_date,
	b1.bid_amount AS first_bid_price,
	b2.bid_amount AS next_bid_price
from bid b1
join bid b2 ON b1.product_id = b2.product_id AND b1.bid_date < b2.bid_date
join car_product cp ON b1.product_id = cp.product_id
where cp.model = 'Toyota Yaris'
order by b1.bid_date ASC;

-- case 4 perbandingan persentase rata2 harga mobil berdasarkan model dan harga bid pada 6 bulan terakhir
with AvgPricePerModel as (
    select 
        model,
        AVG(price) as avg_price
    from 
        car_product
    group by 
        model
),
AvgBid6MonthPerModel as (
    select 
        cp.model,
        AVG(b.bid_amount) AS avg_bid_6month
    from 
        bid b
    join
    	car_product cp using (product_id)
    where 
        -- bid_date >= NOW() - INTERVAL '6 months' -- 6 bulan terakhir
        bid_date BETWEEN '2024-05-01' AND '2024-11-01' -- (opsional menggunakan rentang tanggal manual)
    group by 
        model
)
select 
    p.model,
    p.avg_price,
    b.avg_bid_6month,
    (b.avg_bid_6month - p.avg_price) AS difference,
    ((b.avg_bid_6month - p.avg_price) * 100.0 / p.avg_price) AS difference_percent
from 
    AvgPricePerModel p
left join 
    AvgBid6MonthPerModel b
on 
    p.model = b.model;
    
-- case 5 menggunakan window function menemukan rata2 harga bid dari merek dan model mobil selama 6 bulan terakhir
with BidDataLast6Months as (
	select
        cp.brand,
        cp.model,
        b.bid_amount,
        b.bid_date
    from
        bid b
    join
    	car_product cp using (product_id)
    where
        bid_date >= '2023-12-01' -- Tanggal awal (6 bulan terakhir) 
        and bid_date <= '2024-06-01' -- Tanggal akhir opsional bisa disesuaikan updatenya/requirement
),
MonthlyAverage as (
    select
        brand,
        model,
        DATE_TRUNC('month', bid_date) AS bid_month,
        AVG(bid_amount) AS avg_bid_price
    from
        BidDataLast6Months
    group by
        brand, model, DATE_TRUNC('month', bid_date)
),
RankedData as (
    select
        brand,
        model,
        bid_month,
        avg_bid_price,
        ROW_NUMBER() OVER (PARTITION BY brand, model ORDER BY bid_month DESC) AS month_rank
    from
        MonthlyAverage
)
select
    brand,
    model,
    COALESCE(MAX(CASE WHEN month_rank = 6 THEN avg_bid_price END), 0) AS m_min_6,
    COALESCE(MAX(CASE WHEN month_rank = 5 THEN avg_bid_price END), 0) AS m_min_5,
    COALESCE(MAX(CASE WHEN month_rank = 4 THEN avg_bid_price END), 0) AS m_min_4,
    COALESCE(MAX(CASE WHEN month_rank = 3 THEN avg_bid_price END), 0) AS m_min_3,
    COALESCE(MAX(CASE WHEN month_rank = 2 THEN avg_bid_price END), 0) AS m_min_2,
    COALESCE(MAX(CASE WHEN month_rank = 1 THEN avg_bid_price END), 0) AS m_min_1
from
    RankedData
where model = 'Toyota Yaris'
group by
    brand, model


select * from location;
select * from "user";
select * from bid;
select * from advertisement;
select * from car_product;
   
   