/*Create table amenities*/
CREATE TABLE amenities(
	amenity_id SERIAL PRIMARY KEY,
	amenity_name VARCHAR(100)
);


/*Insert to amenities table all information*/
INSERT INTO amenities(amenity_name)
	SELECT amenity
	FROM (SELECT DISTINCT REPLACE(REPLACE(REPLACE(regexp_split_to_table(room.amenities, E','), '}', ''), '{', ''), '"', '') AS amenity
	FROM room
	) AS amenity
	WHERE amenity != ''


/* create room_amenities_connection table with 2 fields. 
   listing_id (that is a foreign key and references room(listing_id)
   amenity_id (that is a foreign key and references amenities(amenity_id)
   */
CREATE TABLE room_amenities_connection AS
	SELECT listing_id, amenity_id
	FROM room, amenities
	WHERE (listing_id, amenity_name) IN (SELECT listing_id, REPLACE(REPLACE(REPLACE(regexp_split_to_table(room.amenities, E','), '}', ''), '{', ''), '"', '') AS amenity
										FROM room)
									
									

	
/* First of all, add the primary key listign_id to table room */
ALTER TABLE room
	ADD PRIMARY KEY (listing_id)
	
/* add foreign key listing_id to room_amenities_connection table */
ALTER TABLE room_amenities_connection
	ADD FOREIGN KEY (listing_id) REFERENCES room(listing_id)
	
/* add foreign key amenity_id to room_amenities_connection table */
ALTER TABLE room_amenities_connection
	ADD FOREIGN KEY (amenity_id) REFERENCES amenities(amenity_id)
	
/* drom amenities column from table room */
ALTER TABLE room
	DROP COLUMN amenities ;
