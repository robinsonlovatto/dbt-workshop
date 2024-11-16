{{ config(
    materialized='incremental',
    unique_key='id'
    )
}}

with sales as (
    select
        *
    from
        {{ ref('stg_crm__nova_tabela') }}

)
select * from sales

{% if is_incremental() %}

    --Assuming Postgres database
    where updated_at > (select max(updated_at) from {{ this }} )

{% endif %}    