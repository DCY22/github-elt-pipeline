with base as (

    select
        i.issue_id,
        i.issue_number,
        i.repository,
        i.state,
        i.created_at,
        i.closed_at,
        i.comment_count,
        i.is_pull_request,

        -- contributor info for the author of the issue
        c.contributor_id,
        c.contributor_login,
        c.contributor_name

    from {{ ref('stg_issues') }} i
    left join {{ ref('stg_contributor_activity') }} c
        on i.author_id = c.contributor_id  -- or i.author_id depending on your staging model
),

aggregated as (

    select
        repository,
        contributor_id,
        contributor_login,
        contributor_name,
        count(distinct issue_id) as total_issues,
        sum(case when state = 'closed' then 1 else 0 end) as closed_issues,
        sum(case when state = 'open' then 1 else 0 end) as open_issues,
        avg(DATEDIFF(day, created_at, closed_at)) as avg_days_to_close
    from base
    group by 1,2,3,4
)

select *
from aggregated