
update orderdetail
 set price = tab.price*power(0.98,tab.year)
from 
(select orderdetail.orderid, orderdetail.prod_id,products.price,date_part('year',current_date)-date_part('year',orders.orderdate) as year
from orderdetail 
inner join products on orderdetail.prod_id=products.prod_id 
inner join orders on orders.orderid=orderdetail.orderid) 
AS tab 
WHERE tab.orderid = orderdetail.orderid;

