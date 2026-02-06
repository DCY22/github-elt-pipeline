with source as (

    select
        id as issue_id,
        number as issue_number,
        repository,
        state,
        comments as comment_count,
        created_at,
        updated_at,
        closed_at,
        user,
        assignee,
        pull_request

    from {{ source('github_raw', 'issues') }}
),

parsed as (

    select
        issue_id,
        issue_number,
        repository,
        state,
        comment_count,
        created_at,
        updated_at,
        closed_at,

        -- user who opened the issue
        user:login::string as author_login,
        user:id::integer as author_id,
        user:type::string as author_type,

        -- PR detection (not sure if will be used)
        pull_request is not null as is_pull_request,
        pull_request:merged_at::timestamp as pr_merged_at,
        pull_request as pull_request_json

    from source
)

select *
from parsed
