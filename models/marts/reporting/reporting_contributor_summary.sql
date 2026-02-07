with contributor_info as (

    select
        contributor_id,
        contributor_login,
        repository
    from {{ ref('stg_contributor_activity') }}

),

commit_agg as (

    select
        author_id as contributor_id,
        repository,
        count(commit_sha) as total_commits,
        max(committed_at) as last_commit_date
    from {{ ref('stg_commits') }}
    group by author_id, repository

),

issue_agg as (

    select
        author_id as contributor_id,
        repository,
        count(issue_id) as total_issues,
        count(case when is_pull_request then 1 end) as total_prs,
        max(closed_at) as last_issue_date
    from {{ ref('stg_issues') }}
    group by author_id, repository

)

select
    ci.contributor_id,
    ci.contributor_login,
    ci.repository,

    coalesce(ca.total_commits, 0) as total_commits,
    coalesce(ca.last_commit_date, null) as last_commit_date,

    coalesce(ia.total_issues, 0) as total_issues,
    coalesce(ia.total_prs, 0) as total_prs,
    coalesce(ia.last_issue_date, null) as last_issue_date

from contributor_info ci
left join commit_agg ca
    on ci.contributor_id = ca.contributor_id
    and ci.repository = ca.repository
left join issue_agg ia
    on ci.contributor_id = ia.contributor_id
    and ci.repository = ia.repository
