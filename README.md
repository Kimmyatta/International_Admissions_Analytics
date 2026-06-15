# International Admissions Analytics

This project models and analyzes international admissions data using SQL and a relational database design. The goal is to support admissions reporting, enrollment trend analysis, and decision-making around applicant status, program interest, term activity, application source performance, and enrollment outcomes.

## Project Overview

The database is designed around the admissions lifecycle:

- Applicant demographic and source information
- Program and major interest
- Application term activity
- Application decision outcomes
- Enrollment and withdrawal indicators

The project demonstrates relational database design, SQL querying, application progression analysis, conversion-rate reporting, and analytics thinking for higher education admissions reporting.

## Data Model

The relational model includes five main tables:

- `Applicant`
- `Program`
- `Application_Decision`
- `Applicant_Term`
- `Term`

The design connects applicants to programs, terms, application statuses, and decision outcomes so admissions teams can answer questions such as:

- Which confirmed applicants enrolled?
- Which programs receive the most interest?
- How many students were admitted, denied, confirmed, enrolled, or withdrawn?
- How do application statuses vary by term?
- Which applicant segments or sources lead to stronger enrollment outcomes?

## Files

```text
sql/schema.sql          Reconstructed relational schema from the data model
sql/queries.sql         SQL analysis queries for admissions reporting
docs/data-model.md      Data model notes and table descriptions
```

## SQL Analysis

The full SQL analysis script is in [`sql/queries.sql`](sql/queries.sql). It contains 12 portfolio-ready queries, not just the example shown below.

The query set includes:

- Application progression counts
- Application stage conversion rates
- Confirmed applicants who enrolled
- Application status breakdowns
- Applications and enrollment rate by program
- Admit and enrollment outcomes by country
- Application source performance
- Term-level application and enrollment trends
- Withdrawal timing analysis
- Withdrawal rate by program
- Applicant type outcomes
- Top cities by enrolled students

Example query identifying confirmed applicants who enrolled:

```sql
SELECT
  ap.applicant_id,
  att.application_status,
  ad.admit,
  ad.confirmed,
  ad.enrolled
FROM applicant ap
JOIN applicant_term att
  ON ap.applicant_id = att.applicant_id
JOIN application_decision ad
  ON ap.application_id = ad.application_id
WHERE ad.enrolled = 1
  AND att.application_status = 'Confirmed';
```

## Skills Demonstrated

- SQL querying
- SQL joins and aggregations
- Application progression and conversion-rate analysis
- Relational database design
- Primary and foreign key modeling
- Admissions analytics
- Enrollment reporting
- Data modeling with Oracle SQL Developer Data Modeler

## Privacy Note

I included schema and query examples only. I did not include private student records, personally identifiable information, or confidential admissions data.
