with source as (

    select
        -- Contributor identifiers
        id,
        login,
        type,
        site_admin,

        -- Profile info
        name,

        -- Repo context
        repository,
        
        -- Contribution data
        total,
        weeks
    from {{ source('github_raw', 'contributor_activity') }}
),

parsed as (

    select
        -- Contributor
        id as contributor_id,
        login as contributor_login,
        type as contributor_type,
        site_admin as is_site_admin,

        -- Profile
        name as contributor_name,

        -- Repository
        repository,

        -- Activity
        total as total_commits,
        weeks as weekly_activity
    from source
)

select *
from parsed
