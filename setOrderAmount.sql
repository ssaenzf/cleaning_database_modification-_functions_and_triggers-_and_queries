
update orders
set netamount = tab.sumprice,
totalamount= tab.sumprice+((tax/100)*tab.sumprice)
from (select orderdetail.orderid,sum(orderdetail.price) as sumprice 
from orderdetail
Inner join orders on orderdetail.orderid = orders.orderid
GROUP BY orderdetail.orderid) as tab 
WHERE orders.orderid=tab.orderid;



