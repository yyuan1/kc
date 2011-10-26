CREATE TABLE COI_DISCL_PROJECTS ( 
    COI_DISCL_PROJECTS_ID NUMBER(12,0) NOT NULL, 
    COI_DISCLOSURE_ID NUMBER(12,0) NOT NULL, 
    COI_DISCLOSURE_NUMBER VARCHAR2(20) NOT NULL, 
    SEQUENCE_NUMBER NUMBER(6,0) NOT NULL, 
    COI_PROJECT_ID VARCHAR2(20) NOT NULL, 
    COI_PROJECT_TITLE VARCHAR2(200) NOT NULL, 
    COI_PROJECT_TYPE VARCHAR2(20) NOT NULL, 
    COI_PROJECT_SPONSOR VARCHAR2(200) NOT NULL, 
    COI_PROJECT_START_DATE DATE NOT NULL, 
    COI_PROJECT_END_DATE DATE NOT NULL, 
    COI_PROJECT_FUNDING_AMOUNT NUMBER(12,2), 
    COI_PROJECT_ROLE VARCHAR2(20) NOT NULL, 
    DISCLOSURE_FLAG CHAR(1) NOT NULL, 
    UPDATE_TIMESTAMP DATE NOT NULL, 
    UPDATE_USER VARCHAR2(60) NOT NULL, 
    VER_NBR NUMBER(8,0) DEFAULT 1 NOT NULL, 
    OBJ_ID VARCHAR2(36) NOT NULL)
/
ALTER TABLE COI_DISCL_PROJECTS 
ADD CONSTRAINT COI_DISCL_PROJECTS_PK 
PRIMARY KEY (COI_DISCL_PROJECTS_ID)
/
