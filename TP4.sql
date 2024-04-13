-- 1
SELECT avg(film.length) as 'Promedio_l_film'
from film;
-- 2
SELECT film.title, film.length as 'Promedio_l'
from film
WHERE film.length> (SELECT avg(film.length) as 'Promedio_l_film'
from film);
-- 3
SELECT MAX(film.rental_rate)
FROM film;
-- 4
SELECT film.title, film.rental_rate
FROM film
WHERE film.rental_rate = (SELECT MAX(film.rental_rate)
FROM film);
-- 5
SELECT avg(film.replacement_cost)
from film;
-- 6
SELECT film.title, film.replacement_cost
FROM film
WHERE film.replacement_cost> (SELECT avg(film.replacement_cost) FROM film);

-- 7
-- NO SE PUEDE
-- 8 NO SE PUEDE

-- El siguiente ejemplo muestra cómo se puede hacer una subconsulta con referencia externa.

-- La subconsulta chequea, para cada fila de film, el promedio de duración de las películas con el mismo rating de esa fila

-- Nótese el renombramiento de la tabla film

SELECT f.title, f.rating, f.`length`, (select avg(f2.`length`) from film f2 where f2.rating = f.rating) from film f;

-- 9
SELECT film.title AS 'Titulo', language.name AS 'Idioma', film.rental_rate
FROM film
LEFT JOIN language ON film.language_id = language.language_id;
-- 10


