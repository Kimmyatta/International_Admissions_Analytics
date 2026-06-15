# Data Model Notes

The admissions analytics model organizes applicant, program, term, and decision data into related tables.

## Applicant

Stores applicant-level details such as country, city, citizenship, residency, high school country, application source, applicant type, program, and application decision reference.

## Program

Stores academic program or major interest fields. Applicants connect to programs through `program_id`.

## Application_Decision

Stores application progression indicators such as started, submitted, completed, admitted, denied, confirmed, enrolled, and withdrawn. It also stores withdrawal timing fields for more detailed enrollment analysis.

## Applicant_Term

Associates applicants with term profiles and application statuses. This table supports analysis of applicant progress by term.

## Term

Stores term-level identifiers, including intended term and profile ID.

## Relationship Summary

- `Applicant.program_id` references `Program.program_id`
- `Applicant.application_id` references `Application_Decision.application_id`
- `Applicant_Term.applicant_id` references `Applicant.applicant_id`
- `Applicant_Term.profile_id` references `Term.profile_id`
- `Application_Decision.profile_id` references `Term.profile_id`

## Privacy

I used anonymized data and included schema and query examples only. I did not include real applicant records or confidential admissions data.
