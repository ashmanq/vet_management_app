DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS vets;

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE pets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  dob VARCHAR(255),
  owner_name VARCHAR(255),
  owner_address VARCHAR(255),
  owner_tel_no VARCHAR(255),
  treatment_notes TEXT,
  vet_id INT REFERENCES vets(id) ON DELETE CASCADE
);
