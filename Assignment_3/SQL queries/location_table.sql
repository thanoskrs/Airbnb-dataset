/*create location table*/

CREATE TABLE location AS
	SELECT id AS listing_id, street, neighbourhood, neighbourhood_cleansed, city, state,
	zipcode, market, smart_location, country_code, country, latitude, longitude,
	is_location_exact
	FROM listings_copy
	
/*add foreign key to location's table */
ALTER TABLE location
	ADD FOREIGN KEY(listing_id) REFERENCES listings_copy(id)
	
/*drop foreign key neighbourhood_cleansed from listings_copy table*/
ALTER TABLE listings_copy
	DROP CONSTRAINT listings_copy_neighbourhood_cleansed_fkey
	
/*add foreign key to location table which references neighbourhoods_copy table*/
ALTER TABLE location
	ADD FOREIGN KEY(neighbourhood_cleansed) REFERENCES neighbourhoods_copy

/*delete copyied columns except*/
ALTER TABLE listings_copy DROP COLUMN street,
					DROP COLUMN	neighbourhood, 
					DROP COLUMN	neighbourhood_cleansed, 
					DROP COLUMN	city, 
					DROP COLUMN	state,
					DROP COLUMN	zipcode, 
					DROP COLUMN	market, 
					DROP COLUMN	smart_location, 
					DROP COLUMN	country_code, 
					DROP COLUMN	country, 
					DROP COLUMN	latitude, 
					DROP COLUMN	longitude,
					DROP COLUMN	is_location_exact