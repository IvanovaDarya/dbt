
      

    insert into "postgres"."dbt"."sat_customer_details" ("customer_pk", "customer_hashdiff", "first_name", "last_name", "email", "effective_from", "load_date", "record_source")
    (
       select "customer_pk", "customer_hashdiff", "first_name", "last_name", "email", "effective_from", "load_date", "record_source"
       from "sat_customer_details__dbt_tmp195509747296"
    );
  