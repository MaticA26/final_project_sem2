create extension postgis;

create table if not exists city
(
	fid serial primary key,
	name varchar(50) not null,
	geom geometry(Polygon,4326)

);

create table if not exists street
(
	fid serial primary key,
	city_fid integer not null,
	name varchar(50) not null,
	suprafata decimal null,
	geom geometry(Linestring,4326),
	constraint fk_city foreign key (city_fid) references city(fid) 
);

create table if not exists parks
(
	fid serial primary key,
	city_fid integer not null,
	street_fid integer not null,
	name varchar(50) not null,
	surface decimal null,
	geom geometry(Polygon,4326),
	constraint fk_city foreign key (city_fid) references city(fid),
	constraint fk_street foreign key (street_fid) references street(fid)
);

create table if not exists buildings
(
	fid serial primary key,
	city_fid integer not null,
	street_fid integer not null,
	construction_type varchar (50) NOT NULL,
	construction_material varchar (50) NOT NULL,
	suprafata decimal null,
	numar varchar(3) not null,
	geom geometry(Polygon,4326),
	constraint fk_city foreign key (city_fid) references city(fid),
	constraint fk_street foreign key (street_fid) references street(fid)
);

create table if not exists police_stations
(
	fid serial primary key,
	city_fid integer not null,
	street_fid integer not null,
	station_name varchar(50) not null,
	numar char(3) not null,
	geom geometry(Point,4326),
	constraint fk_city foreign key (city_fid) references city(fid),
	constraint fk_street foreign key (street_fid) references street(fid)
);

create table if not exists hospitals
(
	fid serial primary key,
	city_fid integer not null,
	street_fid integer not null,
	name varchar(50) not null,
	numar char(3) not null,
	geom geometry(Point,4326),
	constraint fk_city foreign key (city_fid) references city(fid),
	constraint fk_street foreign key (street_fid) references street(fid)
);

create table if not exists sport_centers
(
	fid serial primary key,
	city_fid integer not null,
	street_fid integer not null,
	name varchar(50) not null,
	schedule date null,
	numar char(3) not null,
	geom geometry(Point,4326),
	constraint fk_city foreign key (city_fid) references city(fid),
	constraint fk_street foreign key (street_fid) references street(fid)
);

create table if not exists trees
(
	fid serial primary key,
	street_fid integer not null,
	geom geometry(Point,4326),
	constraint fk_street foreign key (street_fid) references street(fid) 
);

update street set length=ST_Length(geom);

select * from street

select p.fid,Count(s.fid)nr_constructii from parcela as p
inner join subparcela as s
on s.parcela_fid=p.fid
inner join constructie as c
on c.subparcela_fid=s.fid
group by p.fid;

select ST_Area(geom) from constructie;

