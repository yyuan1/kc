CREATE TABLE IACUC_BATCH_CORRESPONDENCE ( 
    BATCH_CORRESPONDENCE_TYPE_CODE VARCHAR2(3) NOT NULL, 
    DESCRIPTION VARCHAR2(200) NOT NULL, 
    DAYS_TO_EVENT_UI_TEXT VARCHAR2(400) NOT NULL,
    SEND_CORRESPONDENCE VARCHAR2(10) NOT NULL,
    FINAL_ACTION_DAY NUMBER(3,0), 
    FINAL_ACTION_TYPE_CODE VARCHAR2(3), 
    FINAL_ACTION_CORRESP_TYPE VARCHAR2(3), 
    UPDATE_TIMESTAMP DATE NOT NULL, 
    UPDATE_USER VARCHAR2(60) NOT NULL, 
    VER_NBR NUMBER(8,0) DEFAULT 1 NOT NULL, 
    OBJ_ID VARCHAR2(36) DEFAULT SYS_GUID() NOT NULL)
/


-- Primary Key Constraint 
ALTER TABLE IACUC_BATCH_CORRESPONDENCE 
ADD CONSTRAINT PK_BATCH_CORRESPONDENCE 
PRIMARY KEY (BATCH_CORRESPONDENCE_TYPE_CODE)
/

