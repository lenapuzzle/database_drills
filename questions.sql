-- your sql here

// Retrieval
// 1 movies from 2003
SELECT title, year FROM movies WHERE year = 2003 LIMIT 10;

--         movie         | year
-- ----------------------+------
--  American Splendor    | 2003
--  The Station Agent    | 2003
--  Finding Nemo         | 2003
--  Bad Boys II          | 2003
--  Piglet's Big Movie   | 2003
--  Dummy                | 2003
--  Old School           | 2003
--  Bend It Like Beckham | 2003
--  Lost In Translation  | 2003
--  Uptown Girls         | 2003
-- (10 rows)

// 2 movies from 2004 and rating > 90
SELECT title AS movie, rating, year FROM movies WHERE year = 2004 AND rating > 90 LIMIT 10;

                     movie                      | rating
------------------------------------------------+--------
 Little Miss Sunshine                           |     91
 Fantastic Mr. Fox                              |     93
 Ghost World                                    |     92
 Win Win                                        |     94
 The Kids Are All Right                         |     93
 Wallace & Gromit: The Curse of the Were-Rabbit |     95
 James and the Giant Peach                      |     93
 Chicken Run                                    |     97
 Risky Business                                 |     98
 An Education                                   |     94
(10 rows)

// 3 actors with last name - Wilson
SELECT name FROM actors WHERE name LIKE '%Wilson' LIMIT 10;

        actor
----------------------
 Luke Wilson
 Owen Wilson
 Andrew Wilson
 Elizabeth Wilson
 Stuart Wilson
 Brandon Thane Wilson
 Mara Wilson
 Tom Wilson
 Thomas F. Wilson
 Ben Wilson
(10 rows)

// 4 actors with first name - Owen
SELECT name AS FROM actors WHERE name LIKE 'Owen %' LIMIT 10;

      actor
-----------------
 Owen Wilson
 Sion Tudor Owen
 Gregory Owen
 Phil Owens
 Jeremy Owen
 Chris Owen
 Clive Owen
 Lisa Owen
 Michael Owen
 Owen Kline
(10 rows)

// 5 studios starts with Fox
SELECT name FROM studios WHERE name LIKE 'Fox %';

           name
--------------------------
 Fox Searchlight Pictures
 Fox Searchlight
 Fox Atomic
 Fox Home Entertainment
 Fox Faith
(5 rows)

// 6 all Disney studios
SELECT name FROM studios WHERE name LIKE '%Disney%';

              name
--------------------------------
 Walt Disney Pictures
 Disney/Pixar
 Walt Disney Pictures/PIXAR
 Walt Disney Productions
 Disney
 Walt Disney Pictures [us]
 Walt Disney Home Entertainment
 Walt Disney Studios
 Disneynature
 Walt Disney
 Walt Disney Films
(11 rows)

// 7 top 5 rated movies in 2005
SELECT title, rating FROM movies WHERE year = 2005 ORDER BY rating DESC NULLS LAST LIMIT 5;


// 8 worst 10 movies in 2000
SELECT title, rating, year FROM movies WHERE year = 2000 ORDER BY rating LIMIT 10;


// Advanced Retrieval
// 1 Walt Disney movies of 2010
SELECT title, year FROM movies JOIN studios ON movies.studio_id = studios.id WHERE year = 2010 AND studios.name = 'Walt Disney Pictures'; 

                title                | year
-------------------------------------+------
 Alice in Wonderland                 | 2010
 Toy Story 3                         | 2010
 Tangled                             | 2010
 When in Rome                        | 2010
 Tron Legacy                         | 2010
 Secretariat                         | 2010
 Prince of Persia: The Sands of Time | 2010
(7 rows)


// 2 characters of 'The Hunger Games'
SELECT character FROM cast_members JOIN movies ON movies.id = cast_members.movie_id WHERE movies.title = 'The Hunger Games' LIMIT 10;

      character
----------------------
 Katniss Everdeen
 Peeta Mellark
 Gale Hawthorne
 Haymitch Abernathy
 Effie Trinket
 Cinna
 Caesar Flickerman
 President Snow
 Seneca Crane
 Claudius Templesmith
(10 rows)

// 3 actors of 'The Hunger Games'
SELECT actors.name, movies.title, cast_members.character FROM actors JOIN cast_members ON cast_members.actor_id = actors.id JOIN movies ON cast_members.movie_id = movies.id WHERE movies.title = 'The Hunger Games' AND cast_members.character IS NOT NULL LIMIT 10;

       name        |      title       |      character
-------------------+------------------+----------------------
 Jennifer Lawrence | The Hunger Games | Katniss Everdeen
 Josh Hutcherson   | The Hunger Games | Peeta Mellark
 Liam Hemsworth    | The Hunger Games | Gale Hawthorne
 Woody Harrelson   | The Hunger Games | Haymitch Abernathy
 Elizabeth Banks   | The Hunger Games | Effie Trinket
 Lenny Kravitz     | The Hunger Games | Cinna
 Stanley Tucci     | The Hunger Games | Caesar Flickerman
 Donald Sutherland | The Hunger Games | President Snow
 Wes Bentley       | The Hunger Games | Seneca Crane
 Toby Jones        | The Hunger Games | Claudius Templesmith
(10 rows)


// Updating
// 1 update rating of Troll 2 to 500
SELECT title, rating FROM movies WHERE title = 'Troll 2';
UPDATE movies SET rating = 500 WHERE title = 'Troll 2';
SELECT title, rating FROM movies WHERE title = 'Troll 2';

  title  | rating
---------+--------
 Troll 2 |    500
(1 row)


// Deletion
// 1 delete 'Back to the Future Part III' with its cast members
DELETE FROM cast_members
WHERE cast_members.movie_id IN (
  SELECT movies.id FROM movies
  WHERE movies.name = 'Back to the Future Part III'
);
DELETE FROM movies
WHERE title = 'Back to the Future Part III';

// 2 delete all horror movies with its respective cast members
DELETE FROM cast_members
WHERE cast_members.movie_id IN (
  SELECT movies.id FROM movies
  JOIN genres ON movies.genre_id = genres.id
  WHERE genres.name = 'Horror'
);

DELETE FROM movies
WHERE movies.genre_id IN (
  SELECT genres.id FROM genres WHERE genres.name = 'Horror'
);

// Schema
// 1 table of reviews

CREATE TABLE reviews (
  id SERIAL PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  score INTEGER,
  author_name VARCHAR(255),
  movie_id INTEGER REFERENCES movies(id)
);