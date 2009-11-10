INSERT INTO AWARD_STATUS ( STATUS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 1, 'Active', sysdate, user ); 
INSERT INTO AWARD_STATUS ( STATUS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 3, 'Pending', sysdate, user ); 
INSERT INTO AWARD_STATUS ( STATUS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 2, 'Inactive', sysdate, user ); 
INSERT INTO AWARD_STATUS ( STATUS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 4, 'Terminated', sysdate, user ); 
INSERT INTO AWARD_STATUS ( STATUS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 5, 'Closed', sysdate, user ); 
INSERT INTO AWARD_STATUS ( STATUS_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 6, 'Hold', sysdate, user ); 

INSERT INTO FP_DOC_TYPE_T (FDOC_TYP_CD,FDOC_NM,FDOC_TYP_ACTIVE_CD) 
 				VALUES ('ADST','AwardStatus','Y');