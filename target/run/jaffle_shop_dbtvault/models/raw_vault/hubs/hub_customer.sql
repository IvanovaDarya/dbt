
      

    insert into "postgres"."dbt"."hub_customer" ("customer_pk", "customer_key", "load_date", "record_source")
    (
       select "customer_pk", "customer_key", "load_date", "record_source"
       from "hub_customer__dbt_tmp144536374230"
    );
  