with source as (

    select
        -- Contributor identifiers
        id,
        login,
        type,
        site_admin,

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

        -- Repository
        repository,

        -- Activity
        total as total_commits,
        weeks as weekly_activity
    from source
)

select *
from parsed
