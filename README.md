# International Admissions Analytics

This project models and analyzes international admissions data using SQL and a relational database design. The goal is to support admissions reporting, enrollment trend analysis, and decision-making around applicant status, program interest, term activity, and enrollment outcomes.

## Project Overview

The database is designed around the admissions lifecycle:

- Applicant demographic and source information
- Program and major interest
- Application term activity
- Application decision outcomes
- Enrollment and withdrawal indicators

The project demonstrates relational database design, SQL querying, and analytics thinking for higher education admissions reporting.

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
sql/queries.sql         SQL analysis queries
docs/data-model.md      Data model notes and table descriptions
```

## Example Analysis

One query identifies applicants who were confirmed and enrolled:

```sql
SELECT ap.applicant_id, att.application_status, ad.admit
FROM applicant ap
JOIN applicant_term att
  ON ap.applicant_id = att.applicant_id
JOIN application_decision ad
  ON att.profile_id = ad.profile_id
WHERE ad.enrolled = 1
  AND att.application_status = 'Confirmed';
```

## Skills Demonstrated

- SQL querying
- Relational database design
- Primary and foreign key modeling
- Admissions analytics
- Enrollment reporting
- Data modeling with Oracle SQL Developer Data Modeler

## Privacy Note

This repository contains schema and query examples only. It should not include private student records, personally identifiable information, or confidential admissions data.
