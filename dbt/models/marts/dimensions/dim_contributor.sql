with contributors as (

    select
        contributor_id,
        contributor_login,
        contributor_type as type
    from {{ ref('stg_contributor_activity') }}

)

select distinct *
from contributors
