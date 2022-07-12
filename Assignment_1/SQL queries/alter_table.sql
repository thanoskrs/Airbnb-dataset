/*change type of license*/
alter table listings 
	alter column license type varchar(200);


/*foreign keys*/
alter table listings 
	add foreign key(neighbourhood_cleansed) references geolocation(properties_neighbourhood);
	
alter table calendar 
	add foreign key(listing_id) references listings(id);

alter table neighbourhoods 
	add foreign key(neighbourhood) references geolocation(properties_neighbourhood);
	
alter table reviews_summary 
	add foreign key(listing_id) references listings(id);
	
alter table reviews
	add foreign key(listing_id) references listings(id);
	
alter table listings_summary 
	add foreign key(id) references listings(id);