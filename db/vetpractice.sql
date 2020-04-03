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
  tel_no VARCHAR(255)
);

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  dob VARCHAR(255),
  treatment_notes TEXT,
  owner_id INT REFERENCES owners(id) ON DELETE CASCADE,
  vet_id INT REFERENCES vets(id) ON DELETE CASCADE
);
