--Trigger strazi
CREATE OR REPLACE FUNCTION update_linestring_length()
RETURNS TRIGGER AS $$
BEGIN
  NEW.lungime = ST_Length(NEW.geom);
  RETURN NEW; 
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER calculate_linestring_length
BEFORE INSERT OR UPDATE ON street
FOR EACH ROW
WHEN (NEW.geom IS NOT NULL AND ST_GeometryType(NEW.geom) = 'ST_LineString')
EXECUTE FUNCTION update_linestring_length();

--Trigger cladiri
CREATE OR REPLACE FUNCTION update_polygon_area()
RETURNS TRIGGER AS $$
BEGIN
  NEW.suprafata = ST_Area(NEW.geom);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER calculate_polygon_area
BEFORE INSERT OR UPDATE ON buildings
FOR EACH ROW
WHEN (NEW.geom IS NOT NULL AND ST_GeometryType(NEW.geom) = 'ST_Polygon')
EXECUTE FUNCTION update_polygon_area();

--Trigger parcuri
CREATE OR REPLACE FUNCTION update_polygon_area()
RETURNS TRIGGER AS $$
BEGIN
  NEW.surface = ST_Area(NEW.geom);
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER calculate_polygon_area
BEFORE INSERT OR UPDATE ON parks
FOR EACH ROW
WHEN (NEW.geom IS NOT NULL AND ST_GeometryType(NEW.geom) = 'ST_Polygon')
EXECUTE FUNCTION update_polygon_area();

--Trigger id cladiri oras
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.city_fid := NEW.buildings_city_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger_city
BEFORE INSERT OR UPDATE ON buildings
FOR EACH ROW
WHEN (NEW.street_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();

--Trigger id parcuri
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.street_fid := NEW.parks_street_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger
BEFORE INSERT OR UPDATE ON parks
FOR EACH ROW
WHEN (NEW.street_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();

--Trigger id cladiri
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.street_fid := NEW.buildings_street_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger
BEFORE INSERT OR UPDATE ON buildings
FOR EACH ROW
WHEN (NEW.street_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();

--Trigger spitale
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.street_fid := NEW.hospitals_street_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger
BEFORE INSERT OR UPDATE ON hospitals
FOR EACH ROW
WHEN (NEW.street_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();

--Trigger centre sportive
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.street_fid := NEW.sport_centers_street_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger
BEFORE INSERT OR UPDATE ON sport_centers
FOR EACH ROW
WHEN (NEW.street_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();

----Trigger id arbori
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.street_fid := NEW.trees_street_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger
BEFORE INSERT OR UPDATE ON trees
FOR EACH ROW
WHEN (NEW.street_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();


--Trigger id city for street
CREATE OR REPLACE FUNCTION auto_reference_fk()
RETURNS TRIGGER AS $$
BEGIN
  NEW.city_fid := NEW.street_city_fid;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER auto_reference_fk_trigger
BEFORE INSERT OR UPDATE ON street
FOR EACH ROW
WHEN (NEW.city_fid IS NOT NULL)
EXECUTE FUNCTION auto_reference_fk();
