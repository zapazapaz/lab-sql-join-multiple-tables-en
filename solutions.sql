-- Add you solution queries below:
/* Write a query to display for each store its store ID, city, and country. */
SELECT stor_id, city, state
FROM `sakila`.`stores`;

		
/* Write a query to display how much business, in dollars, each store brought in. */
SELECT s.store_id, 
    SUM(p.amount) AS total_business
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN rental r ON st.staff_id = r.staff_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

/* What is the average running time of films by category? */
SELECT 
	c.name AS category_name,
	AVG(f.length) AS average_runtime
FROM category c 
JOIN film_category fc ON  c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

/*Which film categories are longest? */
SELECT 
	c.name AS category_name, 
	AVG(f.length) AS avg_runtime
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_runtime DESC;


/* Display the most frequently rented movies in descending order. */
SELECT 
	f.title AS filt_title,
    COUNT(r.rental_id) AS rental_count
FROM rental r 
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC;


/* List the top five genres in gross revenue in descending order. */
SELECT 
    c.name AS genre,
    SUM(f.rental_rate * rental_count) AS total_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN 
    (SELECT 
        i.film_id, 
        COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    GROUP BY i.film_id) AS rental_counts ON f.film_id = rental_counts.film_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

    

/* Is "Academy Dinosaur" available for rent from Store 1? */
SELECT film_id 
FROM film 
WHERE title = 'Academy Dinosaur';

CALL film_in_stock(1, 1, @film_count);
SELECT @film_count AS Available_Film_Count;
