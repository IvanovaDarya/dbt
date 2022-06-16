{{
    config(
        enabled=True
    )
}}

with all_periods as (
	select customer_pk, effective_from,
	coalesce(lead(effective_from) over(PARTITION by customer_pk order by effective_from), '9999-01-31 00:00:00') - interval '1 microseconds' effective_to
	from (select customer_pk, effective_from--, customer_hashdiff, record_source
				from {{ref('sat_customer_details')}}
	  			union
	  	  select customer_pk, effective_from--, customer_hashdiff, record_source
	  	  		from {{ref('sat_customer_crm')}}   ) t
),
cust_details_periods as (
	select customer_pk, first_name, last_name, email,  effective_from, --customer_pk,  customer_hashdiff, effective_from,
	coalesce(lead(effective_from) over(PARTITION by customer_pk order by effective_from), '9999-01-31 00:00:00') - interval '1 microseconds' effective_to
			from {{ref('sat_customer_details')}}  t
),
cust_crm_periods as (
	select customer_pk, country, age, effective_from, --customer_pk,  customer_hashdiff, effective_from,
	coalesce(lead(effective_from) over(PARTITION by customer_pk order by effective_from), '9999-01-31 00:00:00') - interval '1 microseconds' effective_to
			from {{ref('sat_customer_crm')}} t
),
pit_table as (
		select ap.*,
		cdp.first_name, cdp.last_name, cdp.email,
		--cdp.customer_hashdiff details_hashdiff, cdp.effective_from cd_effective_from, cdp.effective_to cd_effective_to,
		ccp.country, ccp.age
    	--ccp.customer_hashdiff crm_hashdiff, ccp.effective_from crm_effective_from, ccp.effective_to crm_effective_to
		from all_periods ap
		left join cust_details_periods cdp
			on cdp.customer_pk = ap.customer_pk
			and (cdp.effective_from between ap.effective_from and ap.effective_to
				or cdp.effective_to between ap.effective_from and ap.effective_to
				)
		left join cust_crm_periods ccp
			on ccp.customer_pk = ap.customer_pk
			and (ccp.effective_from between ap.effective_from and ap.effective_to
				or ccp.effective_to between ap.effective_from and ap.effective_to
				)
)

select * from pit_table
--where customer_pk = 'ec8956637a99787bd197eacd77acce5e'