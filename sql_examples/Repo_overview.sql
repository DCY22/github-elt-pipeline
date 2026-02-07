-- reporting marts are already aggregated and ready for dashboards.

select
    repository,
    total_commits,
    unique_commit_authors,
    total_issues,
    open_issues,
    closed_issues,
    first_commit_date,
    last_commit_date
from DBT_DCARTER_MARTS.reporting_repo_overview;
