CREATE OR REPLACE FUNCTION getTopMonths(numeric, integer) 
RETURNS TABLE(
	año int,
	mes int, 
	articulos numeric(10,0), 
	euros numeric(10,2)) 
AS $$
BEGIN
RETURN QUERY
	SELECT date_part('year',orderdate)::int AS year, date_part('month',orderdate)::int AS mes, SUM(quantity)::numeric as productos, 		SUM(totalamount) as importe
	FROM orders NATURAL JOIN orderdetail
	GROUP BY year, mes
	HAVING SUM(quantity) > $1 OR SUM(totalamount) > $2
	ORDER BY year;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM getTopMonths(19000, 360000);
