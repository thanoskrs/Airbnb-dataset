create table Calendar(
   listing_id int not null,
   date date not null,
   available boolean,
   price varchar(10),
   adjusted_price varchar(10),
   minimum_nights int,
   maximum_nights int
   primary key(listing_id, date)
);