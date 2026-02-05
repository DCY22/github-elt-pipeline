-- models/marts/mart_repo_overview.sql

with commits_summary as (
    select
        repository,
        count(*) as total_commits,
        min(commit_created_at) as first_commit_date,
        max(commit_created_at) as last_commit_date,
        count(distinct author_id) as unique_commit_authors
    from {{ ref('stg_commits') }}
    group by repository
),

issues_summary as (
    select
        repository,
        count(*) as total_issues,
        sum(case when state = 'open' then 1 else 0 end) as open_issues,
        sum(case when state = 'closed' then 1 else 0 end) as closed_issues,
        min(created_at) as first_issue_date,
        max(closed_at) as last_closed_issue_date
    from {{ ref('stg_issues') }}
    group by repository
)


select
    c.repository,
    c.total_commits,
    c.first_commit_date,
    c.last_commit_date,
    c.unique_commit_authors,
    
    i.total_issues,
    i.open_issues,
    i.closed_issues,
    i.first_issue_date,
    i.last_closed_issue_date

from commits_summary c
left join issues_summary i
    on c.repository = i.repository

