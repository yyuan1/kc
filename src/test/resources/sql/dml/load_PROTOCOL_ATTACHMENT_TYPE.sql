DELETE FROM PROTOCOL_ATTACHMENT_TYPE_GROUP;
DELETE FROM PROTOCOL_ATTACHMENT_TYPE;
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 1, 'Informed Consent Document', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 2, 'Recruitment Brochure', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 3, 'Advertisement', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 4, 'Protocol Narrative', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 5, 'Investigator Brochure', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 6, 'Children''s Assent Form', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 7, 'HIPAA Research Authorization Form', sysdate, user ); 
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 8, 'HIPAA Waiver of Research Authorization Form', sysdate, user );
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 9, 'Other', sysdate, user );
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 10, 'Adverse Event', sysdate, user );
INSERT INTO PROTOCOL_ATTACHMENT_TYPE ( TYPE_CD, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER ) 
VALUES ( 11, 'Biography', sysdate, user );

