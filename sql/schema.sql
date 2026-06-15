CREATE TABLE program (
  program_id INTEGER PRIMARY KEY,
  major_1 VARCHAR2(70),
  major_2 VARCHAR2(70),
  major_3 VARCHAR2(70)
);

CREATE TABLE application_decision (
  application_id VARCHAR2(50) PRIMARY KEY,
  term_code INTEGER,
  started INTEGER,
  submit INTEGER,
  complete INTEGER,
  admit INTEGER,
  denied INTEGER,
  confirmed INTEGER,
  enrolled INTEGER,
  withdrawn INTEGER,
  withdraw_after_accept INTEGER,
  withdraw_after_confirm INTEGER,
  withdraw_before_confirm INTEGER,
  profile_id VARCHAR2(20)
);

CREATE TABLE applicant (
  applicant_id INTEGER PRIMARY KEY,
  country VARCHAR2(50),
  city VARCHAR2(50),
  citizenship VARCHAR2(50),
  residency VARCHAR2(50),
  high_school_country VARCHAR2(50),
  application_source VARCHAR2(50),
  application_id VARCHAR2(50),
  applicant_type VARCHAR2(50),
  program_id INTEGER,
  CONSTRAINT applicant_program_fk
    FOREIGN KEY (program_id)
    REFERENCES program (program_id),
  CONSTRAINT applicant_app_decision_fk
    FOREIGN KEY (application_id)
    REFERENCES application_decision (application_id)
);

CREATE TABLE term (
  term_code INTEGER,
  intended_term VARCHAR2(10),
  profile_id VARCHAR2(20) PRIMARY KEY
);

CREATE TABLE applicant_term (
  applicant_id INTEGER,
  profile_id VARCHAR2(20),
  application_status VARCHAR2(50),
  application_substatus VARCHAR2(50),
  term_code INTEGER,
  CONSTRAINT applicant_term_pk
    PRIMARY KEY (applicant_id, profile_id),
  CONSTRAINT applicant_term_applicant_fk
    FOREIGN KEY (applicant_id)
    REFERENCES applicant (applicant_id),
  CONSTRAINT applicant_term_term_fk
    FOREIGN KEY (profile_id)
    REFERENCES term (profile_id)
);

ALTER TABLE application_decision
ADD CONSTRAINT application_decision_term_fk
  FOREIGN KEY (profile_id)
  REFERENCES term (profile_id);
