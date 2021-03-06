DELIMITER /
INSERT INTO KRIM_TYP_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_TYP_T (KIM_TYP_ID, OBJ_ID, VER_NBR, NM, SRVC_NM, ACTV_IND, NMSPC_CD)
VALUES( (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), UUID(), 1, 'Derived Role: Active Committee Member On Iacuc Protocol', 'activeCommitteeMemberOnIacucProtocolDerivedRoleTypeService', 'Y', 'KC-IACUC')
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'Active Committee Member On Iacuc Protocol', 'KC-IACUC', 'Role members are derived from active committee members on the protocol.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_PERM_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_PERM_ID_BS_S), UUID(), 1, (SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), (SELECT PERM_ID FROM KRIM_PERM_T WHERE NMSPC_CD = 'KC-IACUC' AND NM = 'View IACUC Protocol'),'Y')
/
INSERT INTO KRIM_TYP_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_TYP_T (KIM_TYP_ID, OBJ_ID, VER_NBR, NM, SRVC_NM, ACTV_IND, NMSPC_CD)
VALUES( (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), UUID(), 1, 'Derived Role: Protocol Personnel','iacucProtocolPersonnelDerivedRoleTypeService','Y','KC-IACUC')
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'PI', 'KC-IACUC', 'The Protocol Principal Investigator role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'COI', 'KC-IACUC', 'The Protocol Co-Investigator role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'SP', 'KC-IACUC', 'The Protocol Study Personnel role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'CRC', 'KC-IACUC', 'The Protocol Correspondent CRC role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'CA', 'KC-IACUC', 'The Protocol Correspondent Administrator role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_TYP_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_TYP_T (KIM_TYP_ID,OBJ_ID,VER_NBR,NM,SRVC_NM,ACTV_IND,NMSPC_CD)
VALUES( (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), UUID(), 1, 'Derived Role: Protocol Affiliate Type','iacucProtocolAffiliateTypeDerivedRoleTypeService','Y','KC-IACUC')
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'Faculty', 'KC-IACUC', 'The Faculty Affiliate role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'Non-Faculty', 'KC-IACUC', 'The Non-Faculty Affiliate role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'Affiliate', 'KC-IACUC', 'The Protocol Affiliate role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'Student Investigator', 'KC-IACUC', 'The Protocol Student Investigator role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
INSERT INTO KRIM_ROLE_ID_BS_S VALUES(NULL)
/
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
VALUES((SELECT (MAX(ID)) FROM KRIM_ROLE_ID_BS_S), UUID(), 1, 'Faculty Supervisor', 'KC-IACUC', 'The Protocol Faculty Supervisor role.', (SELECT (MAX(ID)) FROM KRIM_TYP_ID_BS_S), 'Y', NOW())
/
DELIMITER ;
