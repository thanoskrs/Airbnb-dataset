--1o--
/*SELECT host.id, COUNT(*) 
FROM listing, host
WHERE host.id= listing.host_id 
GROUP BY host.id;*/

CREATE INDEX listing_host_id ON listing(host_id)
CREATE INDEX host_id ON host(id)
-------------------------------------------------------------------------------------------

--2o--
/*SELECT id, price
FROM listing, price
WHERE guests_included > 5 AND price > 40;*/

CREATE INDEX price_guests_included ON price(guests_included, price)
-------------------------------------------------------------------------------------------

--3o--
/*SELECT listing.listing_url, host.url
FROM listing
JOIN host
ON listing.host_id = host.id
WHERE host.response_rate = '100%'*/

CREATE INDEX host_response_rate ON host(response_rate)
-------------------------------------------------------------------------------------------

--4o--
/*SELECT listing.listing_url, room_amenities_connection.listing_id, amenities.amenity_id, amenities.amenity_name
FROM listing
JOIN room_amenities_connection
ON listing.id =room_amenities_connection.listing_id
JOIN amenities
ON room_amenities_connection.amenity_id = amenities.amenity_id
WHERE amenities.amenity_name = 'Pets live on this property'*/
CREATE INDEX amenities_amenity_name ON amenities(amenity_name)
-------------------------------------------------------------------------------------------

--5o--
/*SELECT location.neighbourhood_cleansed, geolocation.geometry_coordinates_0_0_0_0, COUNT(location.listing_id) AS total_houses
FROM location
LEFT OUTER JOIN neighbourhood
ON location.neighbourhood_cleansed = neighbourhood.neighbourhood
LEFT OUTER JOIN geolocation 
ON location.neighbourhood_cleansed = geolocation.properties_neighbourhood
GROUP BY location.neighbourhood_cleansed, geolocation.geometry_coordinates_0_0_0_0
HAVING COUNT(location.listing_id) > 300*/
CREATE INDEX group_by_neighbourhood ON location(neighbourhood_cleansed)
CREATE INDEX group_by_geolocation ON geolocation(geometry_coordinates_0_0_0_0)
-------------------------------------------------------------------------------------------

--6o--
/*SELECT listing.id, listing.name, price.price
FROM listing
JOIN price
ON listing.id = price.listing_id
WHERE price.price < 50*/
CREATE INDEX price_price ON price(price)