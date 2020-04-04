DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS treatments;
DROP TABLE IF EXISTS checkings;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS vets;


CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address VARCHAR(255),
  tel_no VARCHAR(255),
  registered BOOLEAN
);

-- animals table has a many to one relationship with owners
-- and vets
CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  dob DATE,
  treatment_notes TEXT,
  owner_id INT REFERENCES owners(id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON DELETE CASCADE
);

-- Checkings table has a one to one relationship
-- with animals so animals id used for table key.
CREATE TABLE checkings (
  id INT REFERENCES animals(id) ON DELETE CASCADE,
  check_in DATE,
  check_out DATE
);

-- Treatments table has a many to one relationship
-- with animals.
CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  tr_date DATE, 
  details TEXT,
  bill NUMERIC,
  animal_id INT REFERENCES animals(id) ON DELETE CASCADE
);

-- Appointments table is a seperate table with a many to one relationship
-- with both animals and vets.
CREATE TABLE appointments (
  id SERIAL PRIMARY KEY,
  app_date DATE,
  app_time TIME,
  animal_id INT REFERENCES animals(id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON DELETE CASCADE,
  treatment_id INT REFERENCES treatments(id) ON DELETE CASCADE
);
