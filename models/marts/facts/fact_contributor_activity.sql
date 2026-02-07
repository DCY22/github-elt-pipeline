with commits as (

    select
        author_id as contributor_id,
        count(*) as commit_count
    from {{ ref('stg_commits') }}
    group by 1

),

issues as (

    select
        author_id as contributor_id,
        count(*) as issues_opened
    from {{ ref('stg_issues') }}
    group by 1

),

final as (

    select
        coalesce(c.contributor_id, i.contributor_id) as contributor_id,
        coalesce(c.commit_count, 0) as commit_count,
        coalesce(i.issues_opened, 0) as issues_opened
    from commits c
    full outer join issues i
        on c.contributor_id = i.contributor_id

)

select *
from final
where contributor_id is not null
