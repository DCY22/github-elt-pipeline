with source as (

    select
        _airbyte_raw_id,
        _airbyte_extracted_at,
        sha,
        branch,
        created_at,
        repository,

        author,
        committer,
        commit

    from {{ source('github_raw', 'commits') }}
),

parsed as (

    select
        _airbyte_raw_id,
        _airbyte_extracted_at,

        sha as commit_sha,
        repository,
        branch,

        -- commit message and timestamp info
        commit:message::string as commit_message,
        commit:committer:date::timestamp as committed_at,

        -- git author info
        commit:author:name::string as author_name,

        -- github user info
        author:login::string as github_author_login,
        author:id::integer as author_id,
        created_at as commit_created_at

    from source
)

select * from parsed
