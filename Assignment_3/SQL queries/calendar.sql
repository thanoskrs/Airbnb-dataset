/*remove '$' and ',' from price and adjusted_price columns, so we can change data type to numeric*/
UPDATE calendar_copy
SET price = REPLACE(price, '$', ''),
	adjusted_price = REPLACE (adjusted_price, '$', '')
	
UPDATE calendar_copy
SET price = REPLACE(price, ',', ''),
	adjusted_price = REPLACE (adjusted_price, ',', '')
	
/*change data type to numeric for price, adjusted_price*/
ALTER TABLE calendar_copy
	ALTER COLUMN price TYPE NUMERIC USING price::NUMERIC,
	ALTER COLUMN adjusted_price TYPE NUMERIC USING adjusted_price::NUMERIC
	
/*the type of available-column is already boolean.. In any case, we quote the command that we should execute*/
ALTER TABLE calendar_copy
	ALTER COLUMN available TYPE BOOLEAN USING available::BOOLEAN