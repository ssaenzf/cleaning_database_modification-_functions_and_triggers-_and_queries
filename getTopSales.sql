CREATE OR REPLACE FUNCTION getTopSales(integer) 
RETURNS TABLE(
	año int,
	pelicula varchar(255),
	ventas numeric)
AS $$

BEGIN
RETURN QUERY
	SELECT DISTINCT ON (year) date_part('year',orders.orderdate) AS year, movietitle, SUM(quantity) AS sales
	from orders
	inner join orderdetail
	on orders.orderid=orderdetail.orderid
	inner join products
	on products.prod_id=orderdetail.prod_id
	inner join imdb_movies
	on imdb_movies.movieid=products.movieid
	inner join (select date_part('year',orders.orderdate) as years from orders WHERE date_part('year',orders.orderdate) <2020  and 		date_part('year',orders.orderdate) >2014) as n_year
	on date_part('year',orders.orderdate) = n_year.years
	GROUP BY date_part('year',orders.orderdate), movietitle
	ORDER BY year,sales desc;
END;

$$ LANGUAGE SQL;
