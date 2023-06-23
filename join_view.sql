--Join
SELECT * FROM hospitals
FULL JOIN street
ON street.fid=hospitals.street_fid;

--Table for view
CREATE TABLE universities (
  	university_fid SERIAL PRIMARY KEY,
	street_fid INTEGER,
  	name VARCHAR(50),
	departments VARCHAR(50),
	geom geometry(Point,4326),
	constraint fk_street foreign key (street_fid) references street(fid)
);

-- Insert
INSERT INTO universities (name, departments)
VALUES ('West University','GIS'),
       ('Politehnica','Cadastru'),
       ('Politehnica','Constructii');

--View
CREATE VIEW universities_view AS
SELECT university_fid, name, departments
FROM universities;

SELECT * FROM universities;
