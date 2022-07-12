
/*Find and print all comments from reviews table
  for every house in Acropolis area, group by
  id and comments
  Output: 18718 rows
  */
  
SELECT listings.id, reviews.comments
FROM listings
JOIN  reviews
ON listings.id = reviews.listing_id
WHERE listings.neighbourhood_cleansed = 'ΑΚΡΟΠΟΛΗ' 
GROUP BY listings.id, reviews.comments

 ------------------------------------------------------------------------------------

/*Find all houses in psyri's neighbourhood that
  accommodate more than 3 people on 2020-07-10 
  and are available. Also there is no minimum limit 
  about how many days someone could stay. 
  (of course minimum is 1 night)
  Output: 236 rows
  */
  
SELECT listings.id, listings.neighbourhood, listings.neighbourhood_cleansed, listings.accommodates, calendar.date
FROM listings 
JOIN calendar
ON listings.id = calendar.listing_id
WHERE listings.neighbourhood = 'Psyri' AND listings.accommodates >= 3 AND listings.minimum_nights = 1 
	AND calendar.date = '2020-07-10' AND calendar.available = 'true'
ORDER BY listings.accommodates

 -----------------------------------------------------------------------------------

/*Find the minimun nights. maximum night and
  average minimum nights, average minimum nights, 
  from neighbourhood LIKE 'Exar'
  Output: 1 row
  */
SELECT MIN(listings.minimum_nights) AS minimum_nights, MAX(listings.maximum_nights) AS maximum_nights, 
	 AVG(listings.minimum_nights) AS average_min_nights, AVG(listings.maximum_nights) AS average_max_nights
FROM listings
WHERE listings.neighbourhood LIKE 'Exar%'

 ------------------------------------------------------------------------------------
 
  /*Find the neighbourhood, url, name, description, host name, 
   price for every house in every neighbouarhood
   Output: 11541 rows
   */
SELECT neighbourhoods.neighbourhood, listings.listing_url, listings.name, listings.description, listings.host_name, listings.price
FROM neighbourhoods
FULL OUTER JOIN listings
ON neighbourhoods.neighbourhood = listings.neighbourhood_cleansed
ORDER BY neighbourhoods.neighbourhood

 ------------------------------------------------------------------------------------
 
/*Find the first and second coordinate of neighbouarhoods of Plaka's
  area 
  Output: 4 rows
  */
SELECT DISTINCT listings.neighbourhood_cleansed, geolocation.geometry_coordinates_0_0_0_0, geolocation.geometry_coordinates_0_0_0_1
FROM listings
JOIN geolocation  
ON listings.neighbourhood_cleansed = geolocation.properties_neighbourhood
WHERE listings.neighbourhood = 'Plaka'

 ------------------------------------------------------------------------------------
 
/*Find all houses with their url and comments between 
  2019-12-01' and '2019-12-31' at Pedio Areos neighbourhood
  Output: 22 rows
  */
  
SELECT listings.id, listings.listing_url, reviews.comments
FROM listings
JOIN reviews
ON listings.id = reviews.listing_id
WHERE listings.neighbourhood_cleansed = 'ΠΕΔΙΟ ΑΡΕΩΣ' AND reviews.date BETWEEN '2019-12-01' AND '2019-12-31'
ORDER BY listings.id

 ------------------------------------------------------------------------------------
 

/*Find for all neighbouarhoods the total number of houses
  for each neighbouarhood 
  Output: 45 rows
  */
 
SELECT listings.neighbourhood_cleansed, COUNT(listings.id) AS total_houses
FROM listings
LEFT OUTER JOIN neighbourhoods
ON listings.neighbourhood_cleansed = neighbourhoods.neighbourhood
GROUP BY listings.neighbourhood_cleansed
ORDER BY total_houses DESC

 ------------------------------------------------------------------------------------
 
/*Find the most expensive house in each neighbourhood
  Output: 45 rows
  */
  
SELECT neighbourhoods.neighbourhood, MAX(listings.price) as max_price
FROM neighbourhoods
JOIN listings 
ON neighbourhoods.neighbourhood = listings.neighbourhood_cleansed
GROUP BY neighbourhoods.neighbourhood
ORDER BY max_price 

 ------------------------------------------------------------------------------------
 
 /*Find the houses that are available every day between
   '2020-04-13' and '2020-04-18'. Show information like 
   neighbourhhood, accommodate, score etc. Choose the firt
   100 houses with the best score.
   Output: 100 rows
   */
 
SELECT DISTINCT listings.id, listings.listing_url, listings.neighbourhood_cleansed, listings.accommodates, listings.bathrooms, 
	listings.bedrooms, listings.beds, listings.amenities, listings.review_scores_value
FROM listings
WHERE listings.id NOT IN(
				SELECT calendar.listing_id
				FROM calendar
				JOIN listings
				ON calendar.listing_id = listings.id
				WHERE (calendar.date >= '2020-04-13' AND calendar.date <= '2020-04-18') AND calendar.available = 'false')
ORDER BY listings.review_scores_value ASC
LIMIT 100

 ------------------------------------------------------------------------------------
 
/*Find the house with most reviews and show them ordered by date.
  Output: 708 rows 
  */
SELECT listings.id, reviews.date, reviews.comments
FROM listings
JOIN reviews 
ON listings.id = reviews.listing_id
WHERE listings.number_of_reviews >= ALL
					(SELECT listings.number_of_reviews
					FROM listings)
ORDER BY reviews.date DESC
					
 ------------------------------------------------------------------------------------
 
/*Find the top 10 houses with the grater reviews_per_month that are available
  on '2020-07-15' and cancellation_policy is flexible.
  Output = 10 rows
  */
  
SELECT listings.id, calendar.date, calendar.price, listings.reviews_per_month
FROM listings
JOIN calendar
ON listings.id = calendar.listing_id
WHERE listings.cancellation_policy = 'flexible' AND calendar.date = '2020-07-15' AND calendar.available = 'true' 
	AND calendar.minimum_nights = 1 AND listings.reviews_per_month <> 'null'
ORDER BY listings.reviews_per_month DESC
LIMIT 10

 ------------------------------------------------------------------------------------

/*Find the neighbouarhood of the houses that have been reviewed
  the last day of 2019
  Output: 26 rows
  */
  
SELECT DISTINCT listings.neighbourhood
FROM listings
JOIN reviews
ON listings.id = reviews.listing_id
WHERE reviews.date = '2019-12-31'