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
SELECT film.title AS 'Titulo', language.name AS 'Idioma', (SELECT MAX(rental_rate) FROM film AS f WHERE f.language_id = film.language_id) as max_precio
FROM film
LEFT JOIN language ON film.language_id = language.language_id
ORDER BY language.name DESC ;
-- 10

SELECT film.title AS 'Titulo', language.name AS 'Idioma', (SELECT MAX(rental_rate) FROM film AS f WHERE f.language_id = film.language_id) as max_precio, film.length as Duracion_p
FROM film
LEFT JOIN language ON film.language_id = language.language_id INNER JOIN sakila.film_category fc2 ON film.film_id = fc2.film_id INNER JOIN sakila.category c2 ON fc2.category_id = c2.category_id
WHERE film.length > (SELECT avg(f2.length) from film  f2 INNER JOIN sakila.film_category fc ON f2.film_id = fc.film_id INNER JOIN sakila.category c ON fc.category_id = c.category_id
                             WHERE c.category_id = c2.category_id)
ORDER BY language.name DESC ;

-- 11
SELECT customer.first_name, customer.last_name, p.amount, (SELECT avg(p2.amount) from customer c2 INNER JOIN sakila.payment p2 ON c2.customer_id = p2.customer_id INNER JOIN sakila.address a ON c2.address_id = a.address_id WHERE a2.city_id = a.city_id)
FROM customer INNER JOIN payment p ON customer.customer_id = p.customer_id INNER JOIN sakila.address a2 ON customer.address_id = a2.address_id

GROUP BY customer.first_name, customer.last_name, a2.city_id;
-- test
SELECT avg(p.amount) FROM payment p INNER JOIN sakila.customer c ON p.customer_id = c.customer_id INNER JOIN sakila.address a ON c.address_id = a.address_id
GROUP BY city_id;

-- 12
SELECT rental.rental_id, c3.country as Pais, staff_id
from rental
INNER JOIN sakila.customer c ON rental.customer_id = c.customer_id
INNER JOIN address a ON c.address_id = a.address_id
INNER JOIN sakila.city c2 ON a.city_id = c2.city_id
INNER JOIN sakila.country c3 ON c2.country_id = c3.country_id
WHERE c3.country_id =(
                        SELECT c4.country_id as country_id_staff
                        FROM country c4
                        INNER JOIN sakila.city c5 ON c4.country_id = c5.country_id
                        INNER JOIN sakila.address a2 ON c5.city_id = a2.city_id
                        INNER JOIN sakila.staff s ON a2.address_id = s.address_id
                        WHERE rental.staff_id = s.staff_id
                        );


-- 13

-- FUNCIONA
select category.name, (SELECT avg(f2.`rental_rate`) from film f2 where f2.rental_rate = f.rental_rate) as 'promedio'
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN sakila.film f ON film_category.film_id = f.film_id
INNER JOIN inventory ON f.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name
HAVING promedio > (SELECT avg(f3.rental_rate) FROM film f3 ) AND (SELECT count(f4.film_id) from film f4 INNER JOIN sakila.film_category fc ON f4.film_id = fc.film_id INNER JOIN sakila.category c ON fc.category_id = c.category_id)> 50;

-- gpt
SELECT
    category.name,
    AVG(f.rental_rate) AS promedio
FROM
    category
INNER JOIN
    film_category ON category.category_id = film_category.category_id
INNER JOIN
    sakila.film f ON film_category.film_id = f.film_id
INNER JOIN
    inventory ON f.film_id = inventory.film_id
INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY
    category.category_id
HAVING
    promedio > (SELECT AVG(rental_rate) FROM sakila.film) AND
    (SELECT COUNT(*)
     FROM sakila.film f2
     INNER JOIN sakila.film_category fc ON f2.film_id = fc.film_id
     WHERE fc.category_id = category.category_id) > 50;
