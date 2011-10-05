--Create new Permissions
INSERT INTO KRIM_PERM_T (PERM_ID, OBJ_ID, VER_NBR, PERM_TMPL_ID, NMSPC_CD, NM, DESC_TXT)
VALUES(KRIM_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT PERM_TMPL_ID FROM KRIM_PERM_TMPL_T WHERE NM = 'Default' AND NMSPC_CD='KUALI'), 'KC-NEGOTIATION', 'CREATE NEGOTIATION', 'Create a new negotiation permission')
/
INSERT INTO KRIM_PERM_T (PERM_ID, OBJ_ID, VER_NBR, PERM_TMPL_ID, NMSPC_CD, NM, DESC_TXT)
VALUES(KRIM_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT PERM_TMPL_ID FROM KRIM_PERM_TMPL_T WHERE NM = 'Default' AND NMSPC_CD='KUALI'), 'KC-NEGOTIATION', 'MODIFY NEGOTIATION', 'Edit an existing negotiation permission')
/
INSERT INTO KRIM_PERM_T (PERM_ID, OBJ_ID, VER_NBR, PERM_TMPL_ID, NMSPC_CD, NM, DESC_TXT)
VALUES(KRIM_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT PERM_TMPL_ID FROM KRIM_PERM_TMPL_T WHERE NM = 'Default' AND NMSPC_CD='KUALI'), 'KC-NEGOTIATION', 'MODIFY ACTIVITIES', 'Edit the activities on an existing negotiation permission')
/
INSERT INTO KRIM_PERM_T (PERM_ID, OBJ_ID, VER_NBR, PERM_TMPL_ID, NMSPC_CD, NM, DESC_TXT)
VALUES(KRIM_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT PERM_TMPL_ID FROM KRIM_PERM_TMPL_T WHERE NM = 'Default' AND NMSPC_CD='KUALI'), 'KC-NEGOTIATION', 'VIEW NEGOTIATION - UNRESTRICTED', 'View all information on a negotiation permission')
/
INSERT INTO KRIM_PERM_T (PERM_ID, OBJ_ID, VER_NBR, PERM_TMPL_ID, NMSPC_CD, NM, DESC_TXT)
VALUES(KRIM_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT PERM_TMPL_ID FROM KRIM_PERM_TMPL_T WHERE NM = 'Default' AND NMSPC_CD='KUALI'), 'KC-NEGOTIATION', 'VIEW NEGOTIATION', 'View all non-restricted information on a negotiation permission')
/
--create role types
INSERT INTO KRIM_TYP_T (KIM_TYP_ID, OBJ_ID, VER_NBR, NM, SRVC_NM, ACTV_IND, NMSPC_CD)
  VALUES( KRIM_TYP_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'Derived Role: Negotiation Negotiator', 'negotiationNegotiatorDerivedRoleType', 'Y', 'KC-NEGOTIATION') 
/
INSERT INTO KRIM_TYP_T (KIM_TYP_ID, OBJ_ID, VER_NBR, NM, SRVC_NM, ACTV_IND, NMSPC_CD)
  VALUES( KRIM_TYP_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'Derived Role: Negotiation Investigators', 'negotiationPersonDerivedRoleType', 'Y', 'KC-NEGOTIATION') 
/
--create new roles
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'Negotiator', 'KC-NEGOTIATION', 'The Negotiator role', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NM = 'Derived Role: Negotiation Negotiator'), 'Y', SYSDATE)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'Negotiation Administrator', 'KC-NEGOTIATION', 'The Negotiation Administrator role', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NM = 'Default'), 'Y', SYSDATE)
/
INSERT INTO KRIM_TYP_T (KIM_TYP_ID, OBJ_ID, VER_NBR, NM, SRVC_NM, ACTV_IND, NMSPC_CD)
  VALUES( KRIM_TYP_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'Derived Role: Negotiation Investigators', 'negotiationPersonDerivedRoleType', 'Y', 'KC-NEGOTIATION') 
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'Investigators', 'KC-NEGOTIATION', 'The Negotiation Investigators role', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NM = 'Derived Role: Negotiation Investigators'), 'Y', SYSDATE)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'PI', 'KC-NEGOTIATION', 'The Negotiation Principle Investigator role', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NM = 'Derived Role: Negotiation Investigators'), 'Y', SYSDATE)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'COI', 'KC-NEGOTIATION', 'The Negotiation Co-Investigator role', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NM = 'Derived Role: Negotiation Investigators'), 'Y', SYSDATE)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, 'KP', 'KC-NEGOTIATION', 'The Negotiation Key Person role', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NM = 'Derived Role: Negotiation Investigators'), 'Y', SYSDATE)
/
--associate roles with permissions
    --NEGOTIATOR
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'CREATE NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'MODIFY NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'MODIFY ACTIVITIES' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION - UNRESTRICTED' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --NEGOTIATION ADMINISTRATOR
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiation Administrator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'CREATE NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiation Administrator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'MODIFY NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiation Administrator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION - UNRESTRICTED' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --OSP ADMINISTRATOR
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'OSP Administrator' AND NMSPC_CD='KC-ADM'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION - UNRESTRICTED' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --UNIT ADMINISTRATOR
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Unit Administrator' AND NMSPC_CD='KC-WKFLW'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --NEGOTIATION INVESTIGATORS
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Investigators' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --NEGOTIATION PI
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'PI' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --NEGOTIATION CO-PI
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'COI' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
    --NEGOTIATION KEY PERSON
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES (KRIM_ROLE_PERM_ID_BS_S.NEXTVAL, SYS_GUID(), 1, (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'KP' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NM = 'VIEW NEGOTIATION' AND NMSPC_CD='KC-NEGOTIATION'), 'Y')
/
--ASSOCIATE ROLES TO PERSON
INSERT INTO KRIM_ROLE_MBR_T (ROLE_MBR_ID, VER_NBR, OBJ_ID, ROLE_ID, MBR_ID, MBR_TYP_CD, ACTV_FRM_DT, ACTV_TO_DT, LAST_UPDT_DT)
VALUES (KRIM_ROLE_MBR_ID_BS_S.NEXTVAL, 1, SYS_GUID(), (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiation Administrator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PRNCPL_ID FROM KRIM_PRNCPL_T WHERE PRNCPL_NM = 'quickstart'), 'P', NULL, NULL, SYSDATE)
/
INSERT INTO KRIM_ROLE_MBR_T (ROLE_MBR_ID, VER_NBR, OBJ_ID, ROLE_ID, MBR_ID, MBR_TYP_CD, ACTV_FRM_DT, ACTV_TO_DT, LAST_UPDT_DT)
VALUES (KRIM_ROLE_MBR_ID_BS_S.NEXTVAL, 1, SYS_GUID(), (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE ROLE_NM = 'Negotiation Administrator' AND NMSPC_CD='KC-NEGOTIATION'), (SELECT PRNCPL_ID FROM KRIM_PRNCPL_T WHERE PRNCPL_NM = 'jtester'), 'P', NULL, NULL, SYSDATE)
/
COMMIT
/
