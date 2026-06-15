-- 1. Admissions funnel summary
SELECT
  COUNT(*) AS total_applications,
  SUM(NVL(started, 0)) AS started_count,
  SUM(NVL(submit, 0)) AS submitted_count,
  SUM(NVL(complete, 0)) AS completed_count,
  SUM(NVL(admit, 0)) AS admitted_count,
  SUM(NVL(confirmed, 0)) AS confirmed_count,
  SUM(NVL(enrolled, 0)) AS enrolled_count,
  SUM(NVL(withdrawn, 0)) AS withdrawn_count
FROM application_decision;

-- 2. Funnel conversion rates
SELECT
  ROUND(SUM(NVL(submit, 0)) / NULLIF(SUM(NVL(started, 0)), 0) * 100, 2) AS started_to_submitted_rate,
  ROUND(SUM(NVL(complete, 0)) / NULLIF(SUM(NVL(submit, 0)), 0) * 100, 2) AS submitted_to_completed_rate,
  ROUND(SUM(NVL(admit, 0)) / NULLIF(SUM(NVL(complete, 0)), 0) * 100, 2) AS completed_to_admitted_rate,
  ROUND(SUM(NVL(confirmed, 0)) / NULLIF(SUM(NVL(admit, 0)), 0) * 100, 2) AS admitted_to_confirmed_rate,
  ROUND(SUM(NVL(enrolled, 0)) / NULLIF(SUM(NVL(confirmed, 0)), 0) * 100, 2) AS confirmed_to_enrolled_rate
FROM application_decision;

-- 3. Confirmed applicants who enrolled
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

-- 4. Application status breakdown
SELECT
  application_status,
  application_substatus,
  COUNT(*) AS applicant_count
FROM applicant_term
GROUP BY application_status, application_substatus
ORDER BY applicant_count DESC;

-- 5. Applications and enrollment rate by primary major
SELECT
  p.major_1,
  COUNT(*) AS total_applicants,
  SUM(NVL(ad.admit, 0)) AS admitted_count,
  SUM(NVL(ad.confirmed, 0)) AS confirmed_count,
  SUM(NVL(ad.enrolled, 0)) AS enrolled_count,
  ROUND(SUM(NVL(ad.enrolled, 0)) / NULLIF(COUNT(*), 0) * 100, 2) AS enrollment_rate
FROM applicant ap
JOIN program p
  ON ap.program_id = p.program_id
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY p.major_1
ORDER BY enrolled_count DESC;

-- 6. Admit and enrollment outcomes by country
SELECT
  ap.country,
  COUNT(*) AS applicant_count,
  SUM(NVL(ad.admit, 0)) AS admitted_count,
  SUM(NVL(ad.enrolled, 0)) AS enrolled_count,
  ROUND(SUM(NVL(ad.admit, 0)) / NULLIF(COUNT(*), 0) * 100, 2) AS admit_rate,
  ROUND(SUM(NVL(ad.enrolled, 0)) / NULLIF(COUNT(*), 0) * 100, 2) AS enrollment_rate
FROM applicant ap
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY ap.country
ORDER BY applicant_count DESC;

-- 7. Application source performance
SELECT
  ap.application_source,
  COUNT(*) AS applicant_count,
  SUM(NVL(ad.complete, 0)) AS completed_count,
  SUM(NVL(ad.admit, 0)) AS admitted_count,
  SUM(NVL(ad.enrolled, 0)) AS enrolled_count,
  ROUND(SUM(NVL(ad.enrolled, 0)) / NULLIF(COUNT(*), 0) * 100, 2) AS source_enrollment_rate
FROM applicant ap
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY ap.application_source
ORDER BY enrolled_count DESC;

-- 8. Term-level application and enrollment trends
SELECT
  t.term_code,
  t.intended_term,
  COUNT(DISTINCT att.applicant_id) AS applicant_count,
  SUM(NVL(ad.admit, 0)) AS admitted_count,
  SUM(NVL(ad.confirmed, 0)) AS confirmed_count,
  SUM(NVL(ad.enrolled, 0)) AS enrolled_count
FROM term t
JOIN applicant_term att
  ON t.profile_id = att.profile_id
JOIN applicant ap
  ON att.applicant_id = ap.applicant_id
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY t.term_code, t.intended_term
ORDER BY t.term_code;

-- 9. Withdrawal analysis by timing
SELECT
  SUM(NVL(withdrawn, 0)) AS total_withdrawn,
  SUM(NVL(withdraw_after_accept, 0)) AS withdrew_after_acceptance,
  SUM(NVL(withdraw_after_confirm, 0)) AS withdrew_after_confirmation,
  SUM(NVL(withdraw_before_confirm, 0)) AS withdrew_before_confirmation
FROM application_decision;

-- 10. Withdrawal rate by primary major
SELECT
  p.major_1,
  COUNT(*) AS total_applicants,
  SUM(NVL(ad.withdrawn, 0)) AS withdrawn_count,
  ROUND(SUM(NVL(ad.withdrawn, 0)) / NULLIF(COUNT(*), 0) * 100, 2) AS withdrawal_rate
FROM applicant ap
JOIN program p
  ON ap.program_id = p.program_id
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY p.major_1
ORDER BY withdrawal_rate DESC;

-- 11. Applicant type outcomes
SELECT
  ap.applicant_type,
  COUNT(*) AS applicant_count,
  SUM(NVL(ad.admit, 0)) AS admitted_count,
  SUM(NVL(ad.confirmed, 0)) AS confirmed_count,
  SUM(NVL(ad.enrolled, 0)) AS enrolled_count,
  ROUND(SUM(NVL(ad.enrolled, 0)) / NULLIF(SUM(NVL(ad.admit, 0)), 0) * 100, 2) AS admit_to_enroll_rate
FROM applicant ap
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY ap.applicant_type
ORDER BY applicant_count DESC;

-- 12. Top cities by enrolled students
SELECT
  ap.country,
  ap.city,
  COUNT(*) AS applicant_count,
  SUM(NVL(ad.enrolled, 0)) AS enrolled_count
FROM applicant ap
JOIN application_decision ad
  ON ap.application_id = ad.application_id
GROUP BY ap.country, ap.city
HAVING SUM(NVL(ad.enrolled, 0)) > 0
ORDER BY enrolled_count DESC, applicant_count DESC;
