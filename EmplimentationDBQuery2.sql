CREATE DATABASE movie
GO
USE movie
GO
CREATE SCHEMA movies
GO
CREATE TABLE movies.actor
(
act_id INT PRIMARY KEY,
act_fname CHAR(20),
act_lname CHAR(20),
act_gender CHAR(1)
);
--M TO M WITH MOVIE

CREATE TABLE movies.movie
(
mov_id INT PRIMARY KEY,
mov_title CHAR(50),
mov_year INT,
mov_time INT,
mov_lang CHAR(50),
mov_dt_rel DATE,
mov_rel_country CHAR(5)
);


--M TO M WITH MOVIE
CREATE TABLE movies.director
(
dir_id INT PRIMARY KEY,
dir_fname CHAR(20),
dir_lname CHAR(20)
);


--M TO M WITH MOVIE
CREATE TABLE movies.reviewer
(
rev_id int PRIMARY KEY,
rev_name CHAR(30)
);

--M TO M WITH MOVIE
CREATE TABLE movies.gener
(
gen_id INT PRIMARY KEY,
gen_title CHAR(30)
);

--M TO M WITH MOVIE
CREATE TABLE movies.rating
(
mov_id INT,
rev_id INT,
rev_sales INT,
num_o_rating int
PRIMARY KEY(rev_id, mov_id)
FOREIGN KEY (rev_id) REFERENCES movies.reviewer(rev_id),
FOREIGN KEY (mov_id) REFERENCES movies.movie(mov_id)
);

CREATE TABLE movies.movie_diraction
(
dir_id INT,
mov_id INT
PRIMARY KEY(dir_id, mov_id)
FOREIGN KEY (dir_id) REFERENCES movies.director(dir_id),
FOREIGN KEY (mov_id) REFERENCES movies.movie(mov_id)
);



CREATE TABLE movies.movieCast
(
act_id INT,
mov_id INT,
role CHAR(30)
PRIMARY KEY(act_id, mov_id),
FOREIGN KEY (act_id) REFERENCES movies.actor(act_id),
FOREIGN KEY (mov_id) REFERENCES movies.movie(mov_id)
);


CREATE TABLE movies.movie_generes
(
mov_id INT,
gen_id INT
PRIMARY KEY(GEN_id, mov_id)
FOREIGN KEY (GEN_id) REFERENCES movies.gener(gen_id),
FOREIGN KEY (mov_id) REFERENCES movies.movie(mov_id)
);