{{
    config(
        enabled=True
    )
}}

select date_trunc('week', order_date) order_week, status, count(1)
from {{ref('sat_order_details')}} sod
group by  date_trunc('week', order_date), status
order by 1 desc
