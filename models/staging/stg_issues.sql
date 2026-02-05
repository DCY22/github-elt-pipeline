with source as (

    select
        _airbyte_raw_id,
        _airbyte_extracted_at,

        id as issue_id,
        number as issue_number,

        repository,
        title,
        body,
        state,
        state_reason,
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
        _airbyte_raw_id as airbyte_raw_id,
        _airbyte_extracted_at as airbyte_extracted_at,

        issue_id,
        issue_number,
        repository,

        title,
        body,

        state,
        state_reason,
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
