-- Confirmed applicants who enrolled
SELECT ap.applicant_id, att.application_status, ad.admit
FROM applicant ap
JOIN applicant_term att
  ON ap.applicant_id = att.applicant_id
JOIN application_decision ad
  ON att.profile_id = ad.profile_id
WHERE ad.enrolled = 1
  AND att.application_status = 'Confirmed';

-- Count or inspect enrolled application decision records
SELECT enrolled
FROM application_decision
WHERE enrolled = 1;
