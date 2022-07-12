/*create Room table*/

CREATE TABLE Room AS
	SELECT id AS listing_id, accommodates, bathrooms, bedrooms, beds, bed_type,
	amenities, square_feet, price, weekly_price, monthly_price, security_deposit
	FROM listings_copy

	
/*delete copyied columns except id*/

ALTER TABLE listings_copy DROP COLUMN accommodates, 
						DROP COLUMN bathrooms, 
						DROP COLUMN bedrooms, 
						DROP COLUMN beds, 
						DROP COLUMN bed_type,
						DROP COLUMN amenities, 
						DROP COLUMN square_feet, 
						DROP COLUMN price, 
						DROP COLUMN weekly_price, 
						DROP COLUMN monthly_price, 
						DROP COLUMN security_deposit



/*primary key at room table*/
ALTER TABLE room ADD FOREIGN KEY(listing_id) REFERENCES listings_copy(id);