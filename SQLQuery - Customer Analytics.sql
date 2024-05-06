SELECT 
c.customer_unique_id,
DATEDIFF(day, max(o.order_date) OVER (ORDER BY o.order_date DESC), '2018-10-17' ) AS difference_in_days

FROM customers c

join (select 
            od.customer_id,
            od.order_purchase_timestamp as order_date
         from orders od
         where 1=1
         and  od.order_status in ('delivered','invoiced', 'shipped') -- Only orders that are 'confirmed'
         ORDER BY od.order_purchase_timestamp desc
         ) o on o.customer_id = c.customer_id

group by c.customer_unique_id


select COUNT(distinct customer_unique_id) from customers



select 
c.customer_unique_id, c.customer_id, o.order_id, o.order_status, p.*
from customers c 
join orders o on o.customer_id = c.customer_id
left join order_payments p on o.order_id = p.order_id
where 1=1
and c.customer_unique_id = '830d5b7aaa3b6f1e9ad63703bec97d23'  