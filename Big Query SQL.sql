
-- Easy Level:
/*
Q1: Filter Pelangan Unik
Q2: Rekap Transaksi Kredit
Q3: Pembelian Quantity Terbanyak
Q4: Model Mobil 'Hitam Metalik'
*/
-- ***********************************************
-- Q1: Tampilkan customer_name yang unik 

SELECT DISTINCT customer_name
FROM `business-478505.12data.data10cabang`;

-- Q1 Result:
-- There's 3977 Customer Name that are unique.

-- ***********************************************
-- Q2: Tampilkan order_id, branch, total_sales dengan payment_type 'Kredit'.

SELECT
  order_id,
  branch,
  total_sales
FROM `business-478505.12data.data10cabang`
WHERE payment_type = 'Kredit';

-- Q2 Result:
-- There's 4253 transaction with Kredit payment.

-- ***********************************************
-- Q3: Tampilkan 5 transaksi dengan quantity terbanyak

SELECT
  order_id,
  customer_name,
  product_name,
  quantity
FROM `business-478505.12data.data10cabang`
ORDER BY quantity DESC
LIMIT 5;

-- ***********************************************
-- Q4: Tampilkan daftar product_name unik dengan warna 'Hitam Metalik

SELECT DISTINCT product_name
FROM `business-478505.12data.data10cabang`
WHERE color = 'Hitam Metalik';

-- Q4 Result:
-- There's 16 unique cars colored by Hitam Metalik. 

-- ***********************************************

-- ___________________________________________________
-- ___________________________________________________
-- Mid Level:
/*
Q5:
Q6:
Q7:
*/

-- ***********************************************
-- Q5: Hitung jumlah transaksi untuk setiap payment_type

SELECT
  payment_type,
  COUNT(order_id) AS jumlah_transaksi
FROM `business-478505.12data.data10cabang`
GROUP BY payment_type;

-- Q5 Result:
--  The highest payment type is Kredit, with 4253 Transactions.

-- ***********************************************
-- Q6: Hitung rata-rata discount per category, lalu urutkan dari yang terbesar

SELECT
  category,
  AVG(discount) AS average_discount
FROM `business-478505.12data.data10cabang`
GROUP BY category
ORDER BY average_discount DESC;

-- Q6 Result:
--  The highest category cars is Hatchback, with average discount 55876.685.

-- ***********************************************
-- Q7: Tampilkan cabang yang total_sales-nya lebih dari 50 miliar, urutkan dari terbesar

SELECT
  branch,
  SUM(total_sales) AS total_revenue
FROM `business-478505.12data.data10cabang`
GROUP BY branch
HAVING SUM(total_sales) > 50000000000
ORDER BY total_revenue DESC;

-- Q7 Result:
--  The highest total sales branch is Malang, with 325311000000 Miliar. 

-- ***********************************************

-- ___________________________________________________
-- ___________________________________________________
-- Hard Level:
/*
Q8: Investigasi Diskon
Q9: Pendapatan Category
Q10: Model Mobil Terlaris
*/

-- ***********************************************
-- Q8: Tampilkan transaksi dengan discount lebih besar dari rata-rata discount seluruh transaksi.

SELECT
  order_id,
  customer_name,
  branch,
  product_name,
  discount
FROM `business-478505.12data.data10cabang`
WHERE discount > (
  SELECT AVG(discount)
  FROM `business-478505.12data.data10cabang`
);

-- Q8 Result:
-- ada 318 transaksi dengan discount lebih besar dari rata-rata discount seluruh transaksi.

-- ***********************************************
-- Q9: Hitung rata-rata total_sales per category untuk transaksi yang status-nya completed

SELECT
  category,
  AVG(total_sales) AS average_sales
FROM `business-478505.12data.data10cabang`
WHERE status = 'completed'
GROUP BY category
ORDER BY AVG(total_sales) DESC;

-- Other Solution:

SELECT
  category,
  AVG(total_sales) AS average_sales
FROM (
  SELECT
    category,
    total_sales
  FROM `business-478505.12data.data10cabang`
  WHERE status = 'completed'
)
GROUP BY category;


-- Q9 Result:
-- The highest car category is Pickup with 4.7282522123893833E8 Miliar.

-- ***********************************************

-- Q10: Gunakan CTE (WITH) untuk menghitung jumlah transaksi per product_name, lalu tampilkan 3 model terlaris

WITH product_sales AS (
  SELECT
    product_name,
    COUNT(order_id) AS jumlah_transaksi
  FROM `business-478505.12data.data10cabang`
  GROUP BY product_name
)

SELECT
  product_name,
  jumlah_transaksi
FROM product_sales
ORDER BY jumlah_transaksi DESC
LIMIT 3;

-- Q10 Result:
-- The highest transaction car is Honda HR-V 1.5 E CVT, with 557 transaction.



