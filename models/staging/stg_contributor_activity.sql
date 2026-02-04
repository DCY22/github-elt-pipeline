with source as (

    select
        -- Airbyte metadata
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_generation_id,

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
        -- Metadata
        _airbyte_raw_id,
        _airbyte_extracted_at,
        _airbyte_generation_id,

        -- Contributor
        id as contributor_id,
        login as contributor_login,
        type as contributor_type,
        site_admin as is_site_admin,

        -- Profile
        name as contributor_name,

        -- Repository
        repository as repository_name,

        -- Activity
        total as total_commits,
        weeks as weekly_activity
    from source
)

select *
from parsed
