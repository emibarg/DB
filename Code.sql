select *
from actor;


select actor.first_name as Nombre, actor.last_name as Apellido
from actor;

select actor.first_name as Nombre
from actor
order by actor.first_name desc;

select film.title as Titulo, film.rating as Clasificacion
from film 
where film.rating = "PG" or film.rating = "R";

select film.title as titulo, film.length as Duracion, film.language_id
from film
where film.length >=120 and film.language_id = 5;

select film.title as titulo, film.length as Duracion, film.language_id
from film
where film.length >=120 and film.language_id = 1
order by film.length;

select customer.first_name as cliente, 'Activo' as estado
from customer;

select payment.amount*0.9 as 'Total - 10%' 
from payment;

select actor.first_name as nombre_actor, film.title as titulo
from film_actor, actor, film
where actor.actor_id = film_actor.actor_id and film.film_id = film_actor.film_id;

select actor.first_name as nombre_actor, film.title as titulo, film.release_year as fecha_lanzamiento
from film_actor, actor, film
where actor.actor_id = film_actor.actor_id and film.film_id = film_actor.film_id and film.release_year<1990
order by film.length asc;

select film.title as titulo, rental.rental_date as fecha_alq, category.name as categoria
from film, rental, inventory,film_category, category
where film.film_id = inventory.film_id and rental.inventory_id = inventory.inventory_id  and (rental.rental_date>'2004-12-31' and rental.rental_date<'2006-01-01') and film.film_id = film_category.film_id and category.category_id = film_category.category_id and category.name = "Drama";

select count(rental.rental_id) as total_alq
from rental;

select max(film.length)
from film;

select sum(payment.amount)
from payment

 