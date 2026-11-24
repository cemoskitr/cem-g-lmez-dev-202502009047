-- Q1: Fiyatı 50 TL'den yüksek ürünleri pahalıdan ucuza sırala.
-- Ne işe yarar: Kafenin en yüksek fiyatlı ürünlerini görerek menüdeki premium ürünlerin fiyat dağılımını analiz etmeyi sağlar.
SELECT name, price
FROM product
WHERE price > 50
ORDER BY price DESC;

-- Q2: 'YBS' bölümündeki müşterilerin adlarını alfabetik sırala.
-- Ne işe yarar: Yönetim Bilişim Sistemleri bölümünden gelen müşterilerin listesini düzenli bir şekilde görüntülemeyi sağlar.
SELECT full_name
FROM customer
WHERE department = 'YBS'
ORDER BY full_name ASC;

-- Q3: Her siparişin numarasını, tarihini ve müşterinin adını listele.
-- Ne işe yarar: Hangi siparişin hangi tarihte ve hangi müşteri tarafından verildiğini takip etmeyi sağlar.
SELECT o.order_id, o.order_date, c.full_name
FROM orders o
INNER JOIN customer c ON c.customer_id = o.customer_id;

-- Q4: Her sipariş kaleminin ürün adını ve adedini listele.
-- Ne işe yarar: Siparişlerde hangi üründen kaç adet satıldığını kalem bazında görmeyi sağlar.
SELECT p.name, oi.quantity
FROM order_item oi
INNER JOIN product p ON p.product_id = oi.product_id;

-- Q5: Her müşterinin kaç sipariş verdiğini müşteri adıyla listele.
-- Ne işe yarar: Hiç sipariş vermemiş müşteriler dahil tüm müşterilerin sipariş sıklığını ölçerek sadık müşterileri belirlemeyi sağlar.
SELECT c.full_name, COUNT(o.order_id) AS siparis_sayisi
FROM customer c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY siparis_sayisi DESC, c.full_name ASC;

-- Q6: Her ürün kategorisinin ortalama fiyatını bul.
-- Ne işe yarar: Kategoriler arasındaki ortalama fiyat farklarını karşılaştırarak fiyatlandırma stratejisi oluşturmayı sağlar.
SELECT category, ROUND(AVG(price), 2) AS ortalama_fiyat
FROM product
GROUP BY category;