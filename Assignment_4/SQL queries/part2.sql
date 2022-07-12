/* Select the houses (listing_id) that have more than 30 amenities
	left outer join room table to show the price
	Output: 3204 rows 
	*/
SELECT room_amenities_connection.listing_id, amenities.amenity_name room.price
FROM room_amenities_connection
LEFT OUTER JOIN room
ON room_amenities_connection.listing_id = room.listing_id
GROUP BY (room_amenities_connection.listing_id, room.price)
HAVING COUNT(room_amenities_connection.amenity_id) > 30


/* find the hosts that have response rate 100% and show their url
	and their houses url
	Output: 7696 rows
	*/
SELECT listing.listing_url, host.url
FROM listing
JOIN host
ON listing.host_id = host.id
WHERE host.response_rate = '100%'


/* find houses that cost under 50 euros. Print the id, name and their price
   Output: 5979 rows*/
SELECT listing.id, listing.name, price.price
FROM listing
JOIN price
ON listing.id = price.listing_id
WHERE price.price < 50


/* Find the neighbourhoods that have more than 300 houses 
	and print neighbourhood_cleansed, geometry_coordinates_0_0_0_0 and the total houses
	grouped by location.neighbourhood_cleansed, geolocation.geometry_coordinates_0_0_0_0
	Output: 13 rows*/
SELECT location.neighbourhood_cleansed, geolocation.geometry_coordinates_0_0_0_0, COUNT(location.listing_id) AS total_houses
FROM location
LEFT OUTER JOIN neighbourhood
ON location.neighbourhood_cleansed = neighbourhood.neighbourhood
LEFT OUTER JOIN geolocation 
ON location.neighbourhood_cleansed = geolocation.properties_neighbourhood
GROUP BY location.neighbourhood_cleansed, geolocation.geometry_coordinates_0_0_0_0
HAVING COUNT(location.listing_id) > 300

/* Find all houses that can gost a pet. 
	Print the url of the houses
	Output: 116 rows
	*/

SELECT listing.listing_url, room_amenities_connection.listing_id, amenities.amenity_id, amenities.amenity_name
FROM listing
JOIN room_amenities_connection
ON listing.id =room_amenities_connection.listing_id
JOIN amenities
ON room_amenities_connection.amenity_id = amenities.amenity_id
WHERE amenities.amenity_name = 'Pets live on this property'