select ST_Area(geom) from parks

update parks set surface=(St_Area(geom))

select * from parks

select ST_Area(geom) from street

update street set lungime=(St_Length(geom))

select * from street

update buildings set suprafata=(St_Area(geom))

select * from buildings