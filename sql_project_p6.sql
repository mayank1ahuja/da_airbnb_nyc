--Step 6: SQL-Based EDA

-- 1. Count of listings per borough
SELECT neighbourhood_group AS borough,
	   COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood_group
ORDER BY total_listings DESC;

-- 2. Average price per room type
SELECT room_type,
	   ROUND(AVG(price), 2) AS avg_price
FROM listings
GROUP BY room_type
ORDER BY avg_price DESC;

-- 3. Top 5 most expensive listings
SELECT id,
	   name,
	   neighbourhood_group,
	   price
FROM listings
ORDER BY price DESC
LIMIT 5;

-- 4. Listings with more than 100 reviews
SELECT name,
	   neighbourhood_group,
	   number_of_reviews
FROM listings
WHERE number_of_reviews > 100
ORDER BY number_of_reviews DESC;

-- 5. Top 10 busiest hosts (by number of listings)
SELECT host_name,
	   COUNT(*) AS total_listings
FROM listings
GROUP BY host_name
ORDER BY total_listings DESC
limit 10;

-- 6. Average reviews per month by room type
SELECT room_type,
	   ROUND(AVG(reviews_per_month),2) AS avg_reviews_per_month
FROM listings
GROUP BY room_type
ORDER BY avg_reviews_per_month DESC;

-- 7. Minimum, Maximum, and Average price per borough
SELECT neighbourhood_group AS borough,
       MIN(price) AS min_price,
       MAX(price) AS max_price,
       ROUND(AVG(price),2) AS avg_price
FROM listings
GROUP BY neighbourhood_group
ORDER BY avg_price DESC;

-- 8. Average number of reviews per borough
SELECT neighbourhood_group AS borough,
       ROUND(AVG(number_of_reviews),2) AS avg_reviews
FROM listings
GROUP BY neighbourhood_group
ORDER BY avg_reviews DESC;

-- 9. Number of listings with availability 0 (not available) per borough
SELECT neighbourhood_group AS borough,
       COUNT(*) AS unavailable_listings
FROM listings
WHERE availability_365 = 0
GROUP BY neighbourhood_group
ORDER BY unavailable_listings DESC;

-- 10. Average minimum nights per room type
SELECT room_type, 
       ROUND(AVG(minimum_nights),2) AS avg_min_nights
FROM listings
GROUP BY room_type
ORDER BY avg_min_nights DESC;

-- 11. Top 10 neighbourhoods with most listings
SELECT neighbourhood, 
	   COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_listings DESC
LIMIT 10;

-- 12. Number of listings with zero reviews per room type
SELECT room_type, 
	   COUNT(*) AS zero_review_listings
FROM listings
WHERE number_of_reviews = 0
GROUP BY room_type
ORDER BY zero_review_listings DESC;

-- 13. Average reviews per month vs room type (show popularity trend)
SELECT room_type, 
       ROUND(AVG(reviews_per_month),2) AS avg_reviews_per_month
FROM listings
GROUP BY room_type
ORDER BY avg_reviews_per_month DESC;

-- 14. Hosts with more than 5 listings
SELECT host_name, 
	   COUNT(*) AS total_listings
FROM listings
GROUP BY host_name
HAVING COUNT(*) > 5
ORDER BY total_listings DESC;