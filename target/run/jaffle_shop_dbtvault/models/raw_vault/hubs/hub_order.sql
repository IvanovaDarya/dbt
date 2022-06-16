
      

    insert into "postgres"."dbt"."hub_order" ("order_pk", "order_key", "load_date", "record_source")
    (
       select "order_pk", "order_key", "load_date", "record_source"
       from "hub_order__dbt_tmp144536596135"
    );
  