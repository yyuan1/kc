create table eps_proposal 
(
  document_number				number (10,0) constraint eps_proposal_n1 not null,
  proposal_number               number (12,0) constraint eps_proposal_n2 not null,
  proposal_type_code            number (3),
  status_code                   number (3),
  creation_status_code          number (3),
  base_proposal_number          varchar2 (8),
  continued_from                varchar2 (8),
  template_flag                 char (1),
  organization_id               varchar2 (8),
  performing_organization_id    varchar2 (8),
  current_account_number        char (7),
  current_award_number          char (10),
  title                         varchar2 (150),
  sponsor_code                  char (6),
  sponsor_proposal_number       varchar2 (70),
  intr_coop_activities_flag     char (1),
  intr_country_list             varchar2 (150),
  other_agency_flag             char (1),
  notice_of_opportunity_code    number (3),
  program_announcement_number   varchar2 (50),
  program_announcement_title    varchar2 (255),
  activity_type_code            varchar2 (3),
  requested_start_date_initial  date,
  requested_start_date_total    date,
  requested_end_date_initial    date,
  requested_end_date_total      date,
  duration_months               number (3),
  number_of_copies              varchar2 (7),
  deadline_date                 date,
  deadline_type                 char (1),
  mailing_address_id            number (6),
  mail_by                       char (1),
  mail_type                     varchar2 (3),
  carrier_code_type             varchar2 (3),
  carrier_code                  varchar2 (20),
  mail_description              varchar2 (80),
  mail_account_number           char (7),
  subcontract_flag              char (1),
  narrative_status              char (1),
  budget_status                 char (1),
  owned_by_unit                 varchar2 (8),
  create_timestamp              date,
  create_user                   varchar2 (8),
  update_timestamp              date          constraint eps_proposal_n5 not null,
  update_user                   varchar2 (8)  constraint eps_proposal_n6 not null,
  nsf_code                      varchar2 (15),
  prime_sponsor_code            char (6),
  cfda_number                   varchar2 (6),
  agency_program_code			varchar2(50),
  agency_division_code			varchar2(50),
  VER_NBR NUMBER(8,0) DEFAULT 1 constraint eps_proposal_n7 NOT NULL,
  OBJ_ID VARCHAR2(36) DEFAULT SYS_GUID() constraint eps_proposal_n8 NOT NULL,
  constraint eps_proposal_p1 primary key (proposal_number),
  constraint eps_proposal_c0 unique (obj_id)
);
