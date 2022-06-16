
      

    insert into "postgres"."dbt"."link_customer_order" ("link_customer_order_pk", "customer_pk", "order_pk", "load_date", "record_source")
    (
       select "link_customer_order_pk", "customer_pk", "order_pk", "load_date", "record_source"
       from "link_customer_order__dbt_tmp172709923695"
    );
  