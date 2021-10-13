-- #1 List all customers who live in Texas (use JOINs)
SELECT * 
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- #2 Get all payments above $6.99 with the Customer's Full Name
SELECT payment_id, amount, first_name, last_name
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;
-- #3 Show all customers names who have made at least 4 payments(use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	HAVING COUNT(payment_id) >= 4
);
-- #4 List all customers that live in Nepal (use the city table)
SELECT *
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN(
		SELECT city_id
		FROM city
		WHERE country_id IN(
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
);
-- #5 Which staff member (first/last name) had the most transactions?
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT(payment_id) DESC;
-- John Stephens with 7304 transactions
-- #6 Which movie title(s) has been rented the most?
SELECT title, COUNT(rental_date)
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY title
ORDER BY COUNT(rental_date) DESC;
-- Bucket Brotherhood with 34 rentals
-- #7 Show all customers who have made a single payment above $6.99
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT DISTINCT customer_id
	FROM payment
	WHERE amount > 6.99
);
-- #8 Which employee gave out the most free rentals?
SELECT first_name, last_name
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE amount = 0
-- Mike Hillyer with 15 free rentals
