-- CREATE DATABASE schema_d_assign;

CREATE TABLE locations (
	id serial CONSTRAINT location_p_key PRIMARY KEY,
	city varchar(50),
	state_ varchar(50),
	country varchar(50)
);


CREATE TABLE persons (
	id serial CONSTRAINT person_p_key PRIMARY KEY,
	first_name varchar(30),
	last_name varchar(30),
	age int,
	location_id integer NOT NULL REFERENCES locations(id) ON DELETE CASCADE
);


CREATE TABLE interests (
	id serial CONSTRAINT interest_p_key PRIMARY KEY,
	title varchar(50)
);

CREATE TABLE person_interests (
	person_id serial REFERENCES persons(id) ON DELETE CASCADE,
	interest_id integer REFERENCES interests(id) ON DELETE CASCADE
);

INSERT INTO locations (city, state_, country)
VALUES
	('Nashville', 'Tennessee', 'United States'),
	('Memphis', 'Tennessee', 'United States'),
	('Phoenix', 'Arizona', 'United States'),
	('Denver', 'Colorado', 'United States');


INSERT INTO persons (first_name, last_name, age, location_id)
VALUES
	('Chickie',	'Ourtic', 21,	1),
	('Hilton',	'O''Hanley', 37,	1),
	('Barbe',	'Purver',	50,	3),
	('Reeta',	'Sammons',	34,	2),
	('Abbott',	'Fisbburne',	49,	1),
	('Winnie',	'Whines',	19,	4),
	('Samantha',	'Leese',	35,	2),
	('Edouard', 'Lorimer',	29,	1),
	('Mattheus',	'Shaplin',	27,	3),
	('Donnell',	'Corney',	25,	3),
	('Wallis',	'Kauschke',	28,	3),
	('Melva',	'Lanham',	20,	2),
	('Amelina',	'McNirlan',	22,	4),
	('Courtney',	'Holley',	22,	1),
	('Sigismond',	'Vala',	21,	4),
	('Jacquelynn',	'Halfacre',	24,	2),
	('Alanna',	'Spino',	25,	3),
	('Isa',	'Slight',	32,	1),
	('Kakalina', 'Renne',	26,	3);
	
INSERT INTO interests (title)
VALUES
	('Programming'),
	('Gaming'),
	('Computers'),
	('Music'),
	('Movies'),
	('Cooking'),
	('Sports');
	

INSERT INTO person_interests (person_id, interest_id)
VALUES
	(1,	1),
	(1,	2),
	(1,	6),
	(2,	1),
	(2,	7),
	(2,	4),
	(3,	1),
	(3,	3),
	(3,	4),
	(4,	1),
	(4,	2),
	(4,	7),
	(5,	6),
	(5,	3),
	(5,	4),
	(6,	2),
	(6,	7),
	(7,	1),
	(7,	3),
	(8,	2),
	(8,	4),
	(9,	5),
	(9,	6),
	(10,	7),
	(10,	5),
	(11,	1),
	(11,	2),
	(11,	5),
	(12,	1),
	(12,	4),
	(12,	5),
	(13,	2),
	(13,	3),
	(13,	7),
	(14,	2),
	(14,	4),
	(14,	6),
	(15,	1),
	(15,	5),
	(15,	7),
	(16,	2),
	(16,	3),
	(16,	4),
	(17,	1),
	(17,	3),
	(17,	5),
	(17,	7),
	(18,	2),
	(18,	4),
	(18,	6),
	(19,	1),
	(19,	2),
	(19,	3),
	(19,	4),
	(19,	5),
	(19,	6),
	(19,	7);

CREATE TABLE age_updates (
	first_name varchar(50),
	last_name varchar(50)
);

INSERT INTO age_updates(first_name, last_name)
VALUES 
	('Chickie', 'Ourtic'),
	('Winnie', 'Whines'),
	('Edouard', 'Lorimer'),
	('Courtney', 'Holley'),
	('Melva', 'Lanham'),
	('Isa', 'Slight'),
	('Abbott', 'Fisbburne'),
	('Reeta', 'Sammons');


UPDATE persons
SET age = age + 1
WHERE (first_name IN (SELECT first_name FROM age_updates))
		AND (last_name IN (SELECT last_name FROM age_updates));


DROP TABLE age_updates;


CREATE TABLE account_del (
	first_name varchar(50),
	last_name varchar(50)
);

INSERT INTO account_del (first_name, last_name)
VALUES
	('Hilton',	'O''Hanley'),
	('Alanna', 	'Spino');



-- SELECT * 
-- FROM person_interests AS pi LEFT JOIN persons AS p ON pi.person_id = p.id
-- 		LEFT JOIN interests AS i ON pi.person_id = i.id
-- 		LEFT JOIN locations AS loc ON p.location_id = loc.id
-- ORDER BY p.last_name, p.first_name, p.id;
 
 --ROWS BEFORE DELETION FROM ABOVE QUERY: 57
--ROWS AFTER DELETION: 50


-- SELECT * 
-- FROM person_interests AS pi LEFT JOIN persons AS p ON pi.person_id = p.id
-- 		LEFT JOIN interests AS i ON pi.person_id = i.id
-- 		LEFT JOIN locations AS loc ON p.location_id = loc.id
-- WHERE p.first_name IN (SELECT first_name FROM account_del)
-- 		AND p.last_name IN (SELECT last_name FROM account_del)
-- ORDER BY p.last_name, p.first_name, p.id;

--BEFORE DELETION: THE ABOVE QUERY RETURNS 7 ROWS: THREE FOR HILTON AND FOUR FOR ALANNA
--AFTER DELETION: ZERO ROWS


DELETE FROM persons
WHERE (first_name IN (SELECT first_name FROM account_del)) 
		AND	(last_name IN (SELECT last_name FROM account_del));

DROP TABLE account_del;

--NUMBER 11 QUERIES START HERE:

--Get all the names (first and last) of the people using the application (Columns to SELECT = firstName & lastName)

-- SELECT 
-- 	first_name, 
-- 	last_name
-- FROM persons
-- ORDER BY last_name, first_name;


--Find all the people who live in Nashville, TN (Columns to SELECT = firstName, lastName, city, & state)

-- SELECT
-- 	p.first_name,
-- 	p.last_name, 
-- 	loc.city,
-- 	loc.state_
-- FROM persons AS p LEFT JOIN locations AS loc
-- 		ON p.location_id = loc.id
-- WHERE (loc.city = 'Nashville') AND (loc.state_ = 'Tennessee')
-- ORDER BY last_name, first_name;



-- Use COUNT & GROUP BY to figure out how many people live in each 
-- --of our four cities (Resulting Columns: city & count)

-- SELECT
-- 	loc.city,
-- 	count(*)
-- FROM persons AS p LEFT JOIN locations AS loc
-- 		ON p.location_id = loc.id
-- GROUP BY loc.city, loc.state_
-- ORDER BY loc.city, loc.state_;



-- Use COUNT & GROUP BY to determine how many people are interested 
-- --in each of the 7 interests (Resulting Columns: title & count)

-- SELECT 
-- 	i.title AS "interest title",
-- 	count(*) AS "number of people interested"
-- FROM person_interests AS pi LEFT JOIN interests AS i
-- 		ON pi.interest_id = i.id
-- GROUP BY pi.interest_id, i.title
-- ORDER BY i.title;


-- Write a query that finds the names (first and last) of all the people 
-- --who live in Nashville, TN and are interested in programming 
-- --(Columns to SELECT = firstName, lastName, city, state, & interest title)

-- SELECT 
-- 	p.first_name,
-- 	p.last_name,
-- 	loc.city,
-- 	loc.state_,
-- 	i.title
-- FROM person_interests AS pi LEFT JOIN interests AS i
-- 			ON pi.interest_id = i.id
-- 		LEFT JOIN persons AS p ON pi.person_id = p.id
-- 		LEFT JOIN locations AS loc ON p.location_id = loc.id
-- WHERE i.title = 'Programming' AND loc.city = 'Nashville'
-- ORDER BY last_name, first_name;



-- OPTIONAL BONUS: Use GROUP BY with cases to determine how many people there are 
-- --in each of the following age ranges: 20-30, 30-40, 40-50 
-- --(Resulting Columns: range & count)

-- WITH age_groups (age_group) AS
-- 	(SELECT 
-- 	 	CASE WHEN age BETWEEN 20 AND 29 THEN '20-29'
-- 	 		WHEN age BETWEEN 30 AND 39 THEN '30-39'
-- 	 		WHEN age BETWEEN 40 AND 50 THEN '40-50'
-- 	 		ELSE 'other'
-- 	 	END	
-- 	FROM persons)
-- SELECT 
-- 	age_group,
-- 	count(*)
-- FROM age_groups
-- GROUP BY age_group
-- ORDER BY age_group;

