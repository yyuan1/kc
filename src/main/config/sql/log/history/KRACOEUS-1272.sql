# Add KULUSER as a Person; it is an internal user required by Rice
#
insert into KIM_PERSONS_T (ID, USERNAME, PASSWORD) values (8, 'KULUSER', 'fK69ATFsAydwQuteang+xMva+Tc=');
insert into PERSON (PERSON_ID, LAST_NAME, FIRST_NAME, FULL_NAME, USER_NAME, OFFICE_LOCATION, HOME_UNIT, KIM_PERSON_ID, UPDATE_TIMESTAMP, UPDATE_USER, VER_NBR) values ('000000000','KULUSER','KULUSER','KULUSER','KULUSER','Kuali Foundation','000001', 8, SYSDATE,'KRADEV','1');