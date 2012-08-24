/* Database changes for Authorization Maintanence documents */
/* This script is ONLY for unit test databases, not development databases. */
/* For development databases, use 1401. */

insert into FP_DOC_TYPE_T (FDOC_TYP_CD, VER_NBR, FDOC_GRP_CD, FDOC_NM, FIN_ELIM_ELGBL_CD, FDOC_TYP_ACTIVE_CD, FDOC_RTNG_RULE_CD, FDOC_AUTOAPRV_DAYS, FDOC_BALANCED_CD, TRN_SCRBBR_OFST_GEN_IND) values ('KIRP', 1, 'KR', 'KIM ROLE-PERMISSION', 'N', 'Y', 'N', 0, 'N', 'N');

insert into FP_DOC_TYPE_T (FDOC_TYP_CD, VER_NBR, FDOC_GRP_CD, FDOC_NM, FIN_ELIM_ELGBL_CD, FDOC_TYP_ACTIVE_CD, FDOC_RTNG_RULE_CD, FDOC_AUTOAPRV_DAYS, FDOC_BALANCED_CD, TRN_SCRBBR_OFST_GEN_IND) values ('UAED', 1, 'KR', 'UNIT ACL ENTRY', 'N', 'Y', 'N', 0, 'N', 'N');

insert into FP_DOC_TYPE_T (FDOC_TYP_CD, VER_NBR, FDOC_GRP_CD, FDOC_NM, FIN_ELIM_ELGBL_CD, FDOC_TYP_ACTIVE_CD, FDOC_RTNG_RULE_CD, FDOC_AUTOAPRV_DAYS, FDOC_BALANCED_CD, TRN_SCRBBR_OFST_GEN_IND) values ('PRTD', 1, 'KR', 'PROPOSAL ROLE TEMPLATE', 'N', 'Y', 'N', 0, 'N', 'N');

create table UNIT_ACL 
(
    ID NUMBER(8) NOT NULL,
    PERSON_ID VARCHAR2(10) NOT NULL ENABLE, 
    ROLE_ID NUMBER(8) NOT NULL,
    UNIT_NUMBER VARCHAR2(8) NOT NULL, 
    SUBUNITS CHAR(1) NOT NULL,
    ACTIVE_FLAG CHAR(1) NOT NULL,
    VER_NBR NUMBER(8,0) DEFAULT 1 NOT NULL ENABLE,
    OBJ_ID VARCHAR2(36) DEFAULT SYS_GUID() NOT NULL ENABLE,
    CONSTRAINT "PK_UNIT_ACL_KRA" PRIMARY KEY ("ID") ENABLE
);

CREATE SEQUENCE SEQ_UNIT_ACL_ID INCREMENT BY 1 START WITH 1000;

alter table KIM_ROLES_PERMISSIONS_T add (ACTIVE_FLAG CHAR(1) DEFAULT 'Y' NOT NULL);

create table PROP_ROLE_TEMPLATE
(
    ID NUMBER(8) NOT NULL,
    PERSON_ID VARCHAR2(10) NOT NULL ENABLE, 
    ROLE_NAME VARCHAR2(500) NOT NULL,
    UNIT_NUMBER VARCHAR2(8) NOT NULL, 
    ACTIVE_FLAG CHAR(1) NOT NULL,
    VER_NBR NUMBER(8,0) DEFAULT 1 NOT NULL ENABLE,
    OBJ_ID VARCHAR2(36) DEFAULT SYS_GUID() NOT NULL ENABLE,
    CONSTRAINT "PK_PROP_ROLE_TEMPLATE_KRA" PRIMARY KEY ("ID") ENABLE
);

CREATE SEQUENCE SEQ_PROP_ROLE_TEMPLATE_ID INCREMENT BY 1 START WITH 1000;
