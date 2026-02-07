with issues as (

    select
        issue_id,
        issue_number,
        state,
        created_at,
        closed_at,
        comment_count,
        author_id as contributor_id
    from {{ ref('stg_issues') }}

)

select *
from issues
