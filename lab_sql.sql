USE SAKILA;

#1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country
FROM store s
JOIN city c ON s.address_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

#2. Write a query to display how much business, in dollars, each store brought in
SELECT 
    store.store_id,
    SUM(payment.amount) AS total_revenue
FROM 
    payment
JOIN 
    rental ON payment.rental_id = rental.rental_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    store ON inventory.store_id = store.store_id
GROUP BY 
    store.store_id;

#3. What is the average running time of films by category?
SELECT 
    category.name AS category_name,
    AVG(film.length) AS average_running_time
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name;

#4. Which film categories are longest?
SELECT 
    category.name AS category_name,
    AVG(film.length) AS average_running_time
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name
ORDER BY 
    average_running_time DESC;

#5. Display the most frequently rented movies in descending order
SELECT 
    film.title AS film_title,
    COUNT(rental.rental_id) AS rental_count
FROM 
    rental
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film ON inventory.film_id = film.film_id
GROUP BY 
    film.title
ORDER BY 
    rental_count DESC;

#6. List the top five genres in gross revenue in descending order.
SELECT 
    category.name AS genre,
    SUM(payment.amount) AS total_revenue
FROM 
    payment
JOIN 
    rental ON payment.rental_id = rental.rental_id
JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN 
    film_category ON inventory.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name
ORDER BY 
    total_revenue DESC
LIMIT 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    film.title, 
    inventory.store_id
FROM 
    inventory
JOIN 
    film ON inventory.film_id = film.film_id
WHERE 
    film.title = 'Academy Dinosaur' 
    AND inventory.store_id = 1;
