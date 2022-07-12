/*create Price table*/

CREATE TABLE Price AS
	SELECT id AS listing_id, price, weekly_price, monthly_price, security_deposit, cleaning_fee,
	guests_included, extra_people, minimum_nights, maximum_nights,
	minimum_minimum_nights, maximum_minimum_nights, minimum_maximum_nights,
	maximum_maximum_nights, minimum_nights_avg_ntm, maximum_nights_avg_ntm
	FROM listings_copy
	
	
/*replace '$' from prices*/

UPDATE price 
SET price = REPLACE(price, '$', ''),
	weekly_price = REPLACE(weekly_price, '$', ''),
	monthly_price = REPLACE(monthly_price, '$', ''),
	security_deposit = REPLACE(security_deposit, '$', ''),
	cleaning_fee = REPLACE(cleaning_fee, '$', ''),
	extra_people = REPLACE(extra_people, '$', '')
	
	
/*replace ',' from prices*/
UPDATE price 
SET price = REPLACE(price, ',', ''),
	weekly_price = REPLACE(weekly_price, ',', ''),
	monthly_price = REPLACE(monthly_price, ',', ''),
	security_deposit = REPLACE(security_deposit, ',', ''),
	cleaning_fee = REPLACE(cleaning_fee, ',', ''),
	extra_people = REPLACE(extra_people, ',', '')
	

/*chage type from varchar to numeric*/
ALTER TABLE price
	ALTER COLUMN price TYPE NUMERIC USING price::NUMERIC,
	ALTER COLUMN weekly_price TYPE NUMERIC USING weekly_price::NUMERIC,
	ALTER COLUMN monthly_price TYPE NUMERIC USING monthly_price::NUMERIC,
	ALTER COLUMN security_deposit TYPE NUMERIC USING security_deposit::NUMERIC,
	ALTER COLUMN cleaning_fee TYPE NUMERIC USING cleaning_fee::NUMERIC,
	ALTER COLUMN extra_people TYPE NUMERIC USING extra_people::NUMERIC,
	ALTER COLUMN minimum_nights_avg_ntm TYPE NUMERIC USING minimum_nights_avg_ntm::NUMERIC,
	ALTER COLUMN maximum_nights_avg_ntm TYPE NUMERIC USING maximum_nights_avg_ntm::NUMERIC
	
	
/*delete copyied columns except id*/
ALTER TABLE listings_copy DROP COLUMN cleaning_fee,
						DROP COLUMN guests_included,
						DROP COLUMN extra_people,
						DROP COLUMN minimum_nights,
						DROP COLUMN maximum_nights,
						DROP COLUMN minimum_minimum_nights,
						DROP COLUMN maximum_minimum_nights,
						DROP COLUMN minimum_maximum_nights,
						DROP COLUMN maximum_maximum_nights,
						DROP COLUMN minimum_nights_avg_ntm,
						DROP COLUMN maximum_nights_avg_ntm
						
						
/*add foreign key*/
ALTER TABLE price ADD FOREIGN KEY(listing_id) REFERENCES listings_copy(id)