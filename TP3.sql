
-- 1
SELECT staff.first_name as 'Nombre', staff.last_name as 'Apellido', address.address as 'Direccion', addy.address as 'Dir tienda'
from ((staff inner join address on staff.address_id = address.address_id), (staff f inner join store on f.store_id = store.store_id)) inner join address addy on addy.address_id = store.address_id
where f.staff_id = staff.staff_id;

-- 2
select staff.first_name as 'Nombre', rental.rental_id as 'RENTA'
from staff left join rental on staff.staff_id = rental.staff_id
order by staff.last_name desc ;

-- 3
select staff.first_name as 'Nombre', sum(payment.amount) as 'total'
from staff left join payment on staff.staff_id = payment.staff_id
group by staff.first_name;

-- 4
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', rental.rental_id as 'RENTAL'
from customer left join rental on customer.customer_id = rental.customer_id
order by Apellido desc;
-- 5
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', rental.rental_id as 'RENTAL'
from customer left join rental on customer.customer_id = rental.customer_id
where rental.rental_id is null
order by Apellido desc;

-- 6
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', sum(payment.amount) as 'Gastado'
from customer inner join rental on customer.customer_id = rental.customer_id, rental r inner join payment on r.rental_id = payment.rental_id
where r.rental_id = rental.rental_id
group by Apellido
order by Gastado asc;

-- 7
select film.title as 'TITULO', language.name as 'LENGUAJE'
from film right join language on film.language_id=language.language_id
where language.language_id =2 or language.language_id >=5
order by LENGUAJE, TITULO;

-- 8
select language.name as 'LENGUAJE', count(film_id) as 'CANTIDAD'
from film right join language on film.language_id=language.language_id

group by LENGUAJE;

-- 9
select film.title as 'TITULO', language.name as 'LENGUAJE'
from film right join language on film.language_id=language.language_id
where language.language_id in (select language.language_id from
                                                               language where language.language_id = 2 or language.language_id = 5)
order by LENGUAJE, TITULO;
-- 10
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', city.city as 'Ciudad'
from (select customer.address_id , city.city from (customer inner join address on customer.address_id = address.address_id) inner join city on address.city_id = city.city_id where city.city != 'California') as c, city, customer
where city.city =c.city and customer.address_id = c.address_id;
-- 11
select s.store_id
from  store as s
where s.store_id not in (select staff.store_id from staff inner join payment on staff.staff_id = payment.staff_id);

-- 12
select film.title as titulo, film.replacement_cost as costo_reemplazo
from film
where film.replacement_cost > (select avg(film.replacement_cost) from film);
-- 13
select film.title as titulo, film.replacement_cost as costo_reemplazo
from film, category
where film.replacement_cost  >some  (select avg(film.replacement_cost) from film, language where film.language_id = language.language_id group by film.language_id)
group by film.language_id,film.title;
-- 14
select film.title as titulo
from film
where film.language_id!=1;

-- 15
select film.title as Titulo, category.name as 'Categoria'
from film inner join film_category on film.film_id = film_category.film_id, category
where film_category.category_id not in (select category.category_id from category where category.name = 'Action' or category.name ='Drama') and category.category_id = film_category.category_id;

-- 16
select film.title as Titulo, category.name as 'Categoria', film.rating as 'Rating'
from film inner join film_category on film.film_id = film_category.film_id, category,(select category_id from category where category.name = 'Family') as f
where category.category_id = film_category.category_id and film.rating> (select max(film.rating) from film where category.name= 'Family');
-- 17

select film.title as Titulo, category.name as 'Categoria', film.rating as 'Rating'
from film inner join film_category on film.film_id = film_category.film_id, category,(select category_id from category where category.name = 'Family') as f
where category.category_id = film_category.category_id and film.rating> (select min(film.rating) from film where category.name= 'Family');


-- 18
Select film.title as Titulo, film.replacement_cost as 'Costo de reemplazo', category.name as 'Categoria'
from film inner join film_category on film.film_id = film_category.film_id inner join category on film_category.category_id = category.category_id
where film.replacement_cost < some (select  max(f1.replacement_cost) from film f1 inner join film_category on f1.film_id = film_category.film_id inner join category on film_category.category_id = category.category_id where category.category_id = film_category.category_id and category.name = 'Drama')
order by film.title;
-- 19

SELECT customer.first_name as 'Nombre',  customer.last_name as 'Apellido'
from customer
where customer.customer_id in (SELECT customer.customer_id
    from customer
    inner join sakila.rental r on customer.customer_id = r.customer_id
    inner join sakila.inventory i on r.inventory_id = i.inventory_id
    inner join film_category fc on i.film_id = fc.film_id
    inner join category c on fc.category_id = c.category_id and c.category_id = 5);


-- 20.1
select category.name, avg(film.length)
from film
inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
group by category.name;

-- 20.2
select film.title, film.length
from film
where film.length>0;

-- 20.3
select film.title
from film

where film.length> all (
    select avg(film.length)
        from sakila.film
            inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
                                                            group by category.name);
-- 20.4
select film.title
from film

where film.length> all (
    select avg(avg.promedio)
    from (select avg(film.length) as promedio
        from sakila.film
            inner join film_category on film.film_id = film_category.film_id
inner join category on film_category.category_id = category.category_id
                                                            group by category.name) avg);

-- 21.1
select sum(payment.amount), c.city
from address
inner join sakila.city c on address.city_id = c.city_id
inner join customer on address.address_id = customer.address_id
inner join payment on customer.customer_id = payment.customer_id
group by c.city;
-- 21.2
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', sum(payment.amount)
from customer
inner join payment on customer.customer_id = payment.customer_id
group by customer.first_name, customer.last_name;

-- 21.3
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', sum(payment.amount) as PAGO
from customer inner join payment on customer.customer_id = payment.customer_id
group by customer.first_name, customer.last_name
having PAGO > some (select sum(payment.amount)
from address
inner join sakila.city c on address.city_id = c.city_id
inner join customer on address.address_id = customer.address_id
inner join payment on customer.customer_id = payment.customer_id
group by c.city);

-- 21.4
select customer.first_name as 'Nombre', customer.last_name as 'Apellido', sum(payment.amount) as PAGO
from customer inner join payment on customer.customer_id = payment.customer_id
group by customer.first_name, customer.last_name
having PAGO > some (select sum(payment.amount)
from address
inner join sakila.city c on address.city_id = c.city_id
inner join customer on address.address_id = customer.address_id
inner join payment on customer.customer_id = payment.customer_id
group by c.city);

