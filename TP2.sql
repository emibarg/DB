
SELECT SUM(sakila.payment.amount)
FROM payment;
-- 2
SELECT staff.staff_id, SUM(payment.amount)
FROM payment, staff
WHERE staff.staff_id = payment.staff_id
group by staff.staff_id;
-- 3
SELECT staff.staff_id, (SUM(payment.amount) * 1000)  as PESOS
FROM payment, staff
WHERE staff.staff_id = payment.staff_id
group by staff.staff_id;
-- 4
SELECT staff.first_name as Nombre, staff.last_name as Apellido, SUM(payment.amount)   as TOTAL
FROM payment, staff
WHERE staff.staff_id = payment.staff_id
group by staff.staff_id;
-- 5
SELECT staff.staff_id,payment.payment_date as Anio , SUM(payment.amount)
FROM payment, staff
WHERE staff.staff_id = payment.staff_id and YEAR(payment.payment_date) = 2006
group by staff.staff_id;
-- 6
SELECT staff.first_name as Nombre, staff.last_name as Apellido,payment.payment_date as Anio , SUM(payment.amount)
FROM payment, staff
WHERE staff.staff_id = payment.staff_id and YEAR(payment.payment_date) = 2006
group by staff.staff_id;
-- 7
SELECT staff.first_name as Nombre, staff.last_name as Apellido,payment.payment_date as Anio , SUM(payment.amount)
FROM payment, staff
WHERE staff.staff_id = payment.staff_id and YEAR(payment.payment_date) = 2006 AND payment.amount>2.5
group by staff.staff_id
ORDER BY staff.last_name;
-- 8
SELECT staff.first_name as Nombre, staff.last_name as Apellido,payment.payment_date as Anio , SUM(payment.amount) as Precio
FROM payment, staff
WHERE staff.staff_id = payment.staff_id and YEAR(payment.payment_date) = 2006 AND payment.amount>2.5
group by staff.staff_id
ORDER BY Precio;
-- 9
SELECT staff.first_name as Nombre, staff.last_name as Apellido,payment.payment_date as Anio , SUM(payment.amount) as Precio
FROM payment, staff
WHERE staff.staff_id = payment.staff_id and YEAR(payment.payment_date) = 2006 AND payment.amount>2.5
group by staff.staff_id 
HAVING Precio>200
ORDER BY Precio;
-- 10
SELECT COUNT(*) AS CANTIDAD, YEAR(rental.rental_date) AS anio
FROM rental
GROUP BY YEAR(rental.rental_date); 
-- 11
SELECT COUNT(*) AS CANTIDAD, MONTH(rental.rental_date)as MES, YEAR(rental.rental_date) as ANIO
FROM rental
GROUP BY YEAR(rental.rental_date) , MONTH(rental.rental_date)
ORDER BY ANIO;
-- 12
SELECT COUNT(*) AS CANTIDAD, MONTH(rental.rental_date)as MES, YEAR(rental.rental_date) as ANIO
FROM rental
GROUP BY YEAR(rental.rental_date) , MONTH(rental.rental_date)
HAVING ANIO = 2005;
-- 13
SELECT COUNT(*) AS CANTIDAD, MONTH(rental.rental_date)as MES, YEAR(rental.rental_date) as ANIO
FROM rental
GROUP BY YEAR(rental.rental_date) , MONTH(rental.rental_date)
HAVING ANIO = 2005 AND CANTIDAD >2000;
-- 14
SELECT COUNT(*) AS CANTIDAD, MONTH(rental.rental_date)as MES, YEAR(rental.rental_date) as ANIO
FROM rental
GROUP BY YEAR(rental.rental_date) , MONTH(rental.rental_date)
HAVING ANIO = 2005 AND CANTIDAD >2000
ORDER BY MES DESC;
-- 15
SELECT min(film.length) as DURACION_MIN, film.rating as RATING
FROM film
GROUP BY RATING;
-- 16
SELECT COUNT(*) as CANTIDAD, film.rating as RATING
FROM film
GROUP BY RATING;
-- 17
SELECT COUNT(film.film_id) as CANTIDAD, language.name 
FROM film RIGHT JOIN  language on film.language_id = language.language_id
GROUP BY language.name;
-- 18
SELECT COUNT(*) as CANTIDAD, category.name as CATEGORIA
FROM film, film_category, category 
WHERE film.film_id = film_category.film_id AND category.category_id = film_category.category_id
GROUP BY CATEGORIA;
-- 19
SELECT DISTINCT COUNT(*) as CANTIDAD, language.name as IDIOMA, film.rating as RATING
FROM film, language
WHERE film.language_id = language.language_id
GROUP BY RATING, IDIOMA;

-- 20
SELECT COUNT(film.film_id) as CANTIDAD, language.name as IDIOMA, category.name as CATEGORIA
FROM film RIGHT JOIN  language on film.language_id = language.language_id, film_category, category 
WHERE film.film_id = film_category.film_id AND category.category_id = film_category.category_id
GROUP BY CATEGORIA, IDIOMA;
-- 21
SELECT film.title as TITULO, COUNT(*) as CANT_ACTORES
FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id and film.release_year >1980
GROUP BY TITULO
having CANT_ACTORES>10
ORDER BY CANT_ACTORES ASC;




