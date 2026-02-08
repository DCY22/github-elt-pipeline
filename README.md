# GitHub Repo Activity ELT Pipeline (Airbyte → Snowflake → dbt)

## Project Summary
This project builds an end-to-end ELT pipeline to extract GitHub repository activity data and transform it into analytics-ready models for reporting.

**Repository Tracked:** - dbt-labs/dbt-core (LINK - https://github.com/dbt-labs/dbt-core )
**Goal:** The goal of this project is to create analytics-ready tables that can be used to track the contributor activity for this GitHub repo, measuring issues (open vs closed) by contributor, commits per contributor, and repository-level overview statistics.

---

## Tech Stack
- **Data Source:** GitHub API
- **Ingestion Tool:** Airbyte
- **Data Warehouse:** Snowflake
- **Transformation Tool:** dbt Cloud
- **Version Control:** GitHub

---

## Architecture
### Data Flow
GitHub API → Airbyte → Snowflake (RAW) → dbt (STAGING → MARTS)

---

## Data Warehouse Design
This project follows a **dimensional modeling approach** using a fact constellation (galaxy schema) design.

### Schemas Used
- **RAW:** - RAW_GITHUB
- **STAGING:** - DBT_DCARTER_STAGING
- **MARTS:** DBT_DCARTER_MARTS

---

## dbt Model Structure

### Staging Models
These models clean and standardize raw GitHub data loaded by Airbyte.

- `stg_commits`
- `stg_issues`
- `stg_contributor_activity`

---

### Dimension Models
- `dim_contributor`  
  **Description:** - Contains unique contributor-level metadata (GitHub user ID and username) used as a shared dimension for joining issue and activity fact tables.

---

### Fact Models
- `fact_issues`  
  **Description:** - Fact table containing issue-level activity for the repository, including one record per issue with contributor keys, issue state, and relevant timestamps for analytics and reporting.

- `fact_contributor_activity`  
  **Description:** - Fact table containing contributor-level activity metrics for the repository, including aggregated counts of commits, pull requests, and issues by contributor and repository.

---

### Reporting Models
These models provide aggregated reporting-ready outputs for dashboards and analysis.

- `mart_repo_overview`
- `mart_issues`
- `mart_contributor_summary`

---

## Key Business Questions Supported
This pipeline supports analytics such as:
- Who are the most active contributors in the repository (issues and commits)?
- How many issues are open vs closed, and what is the overall closure rate?
- What is the overall health of the repo, based on open issues and recent commit activity?

---

## Data Quality Testing
This project includes dbt tests to ensure the reliability of the analytics models.

### Test Types Implemented
- `not_null`
- `unique`
- `relationships`
- `accepted_values`
- singular tests


