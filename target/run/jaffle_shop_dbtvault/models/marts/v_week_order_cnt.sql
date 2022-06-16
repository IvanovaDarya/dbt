
  create view "postgres"."dbt"."v_week_order_cnt__dbt_tmp" as (
    

select date_trunc('week', order_date) order_week, status, count(1)
from "postgres"."dbt"."sat_order_details" sod
group by  date_trunc('week', order_date), status
order by 1 desc
  );
