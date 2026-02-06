with source as (

    select
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
        sha as commit_sha,
        repository,
        branch,

        -- commit message and timestamp info
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
