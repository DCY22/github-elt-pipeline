-- Shows issue volume (open and closed) by contributor

select
    d.contributor_login,
    count(*) as total_issues,
    sum(case when f.state = 'open' then 1 else 0 end) as open_issues,
    sum(case when f.state = 'closed' then 1 else 0 end) as closed_issues
from marts.fact_issues f
join marts.dim_contributor d
    on f.contributor_id = d.contributor_id
group by 1
order by total_issues desc;
