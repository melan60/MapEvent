DROP SEQUENCE IF EXISTS person_id_person_seq;
DROP SEQUENCE IF EXISTS place_id_place_seq;
DROP TABLE IF EXISTS is_in;
DROP TABLE IF EXISTS Place;
DROP TABLE IF EXISTS Person;

CREATE SEQUENCE person_id_person_seq;
CREATE SEQUENCE place_id_place_seq;


CREATE TABLE IF NOT EXISTS Person (
    id_person SERIAL,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100),
    company VARCHAR(100),
    activity VARCHAR(100),
    PRIMARY KEY(id_person)
);

CREATE TABLE IF NOT EXISTS Place (
    id_place SERIAL,
    place_name VARCHAR(100),
    longitude FLOAT,
    latitude FLOAT,
    PRIMARY KEY(id_place)
);

CREATE TABLE IF NOT EXISTS is_in (
    id_place INT,
    id_person INT,
    date DATE,
    PRIMARY KEY(id_place, id_person),
    FOREIGN KEY(id_person) REFERENCES Person(id_person),
    FOREIGN KEY(id_place) REFERENCES Place(id_place)
);

INSERT INTO Person(id_person, firstname, lastname, email, company, activity) VALUES 
    (default, 'Bruno', 'Charles', 'bru@gmail.com', 'Apple', 'Développeur'),
    (default, 'Valérie', 'Martin', 'val@gmail.com', 'LVMH', 'RH'),
    (default, 'François', 'Bernard', 'fran@gmail.com', 'Microsoft', 'Chef de projet');

INSERT INTO Place(id_place, place_name, longitude, latitude) VALUES
    (default, 'Le Dauphin', 3.1585527 ,50.7217242),
    (default, 'Le Saint Martin', 3.152189, 50.730964),
    (default, 'Montuno', 3.1566333, 50.7068672),
    (default, 'L''Union Fait La Sauce', 3.1652662, 50.7111926),
    (default, 'DOLLY BAR', 3.1723186, 50.7166204);

INSERT INTO is_in(id_place, id_person, date) VALUES 
    (1, 1, '2023-11-30 22:20:00'),
    (4, 3, '2023-12-05 21:30:00'),
    (4, 2, '2023-12-04 20:00:00');