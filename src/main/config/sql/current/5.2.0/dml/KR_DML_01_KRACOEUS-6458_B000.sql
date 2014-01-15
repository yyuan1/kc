-- Add new namespace
INSERT INTO KRCR_NMSPC_T (NMSPC_CD,OBJ_ID,VER_NBR, NM, ACTV_IND, APPL_ID )
VALUES ('KC-PROTOCOL-DOC',SYS_GUID(),1, 'IRB Protocol Doc Level Nmspc' , 'Y', 'KC')
/

-- Add new (permissionless) Aggregator role for Protocol Doc namespace
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
  VALUES(CONCAT('KC',KRIM_ROLE_ID_S.NEXTVAL), SYS_GUID(), 1, 'Protocol Aggregator', 'KC-PROTOCOL-DOC', 'Added to Document Qualified Role memberships for corresponding Role in KC-PROTOCOL namespace', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD = 'KC-SYS' AND NM = 'Unit'), 'Y', sysdate)
  /
  
-- Add new (permissionless) Viewer role for Protocol Doc namespace
INSERT INTO KRIM_ROLE_T (ROLE_ID, OBJ_ID, VER_NBR, ROLE_NM, NMSPC_CD, DESC_TXT, KIM_TYP_ID, ACTV_IND, LAST_UPDT_DT)
  VALUES(CONCAT('KC',KRIM_ROLE_ID_S.NEXTVAL), SYS_GUID(), 1, 'Protocol Viewer', 'KC-PROTOCOL-DOC', 'Added to Document Qualified Role memberships for corresponding Role in KC-PROTOCOL namespace', (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD = 'KC-SYS' AND NM = 'Unit'), 'Y', sysdate)
/

-- add all permissions from Protocol Aggregator to protocol PI derived role
INSERT INTO KRIM_ROLE_PERM_T (ROLE_PERM_ID, OBJ_ID, VER_NBR, ROLE_ID, PERM_ID, ACTV_IND)
 (SELECT CONCAT('KC',KRIM_ROLE_PERM_ID_S.NEXTVAL), SYS_GUID(), 1, R.ROLE_ID, P.PERM_ID, 'Y' FROM KRIM_ROLE_T R, (SELECT RP.PERM_ID FROM KRIM_ROLE_PERM_T RP JOIN KRIM_ROLE_T R ON RP.ROLE_ID = R.ROLE_ID where R.ROLE_NM='Protocol Aggregator' and R.NMSPC_CD='KC-PROTOCOL') P WHERE R.ROLE_NM = 'PI' and NMSPC_CD='KC-PROTOCOL')
/

-- add all role memberships that are currently in KC-PROTOCOL:Protocol Aggregator namespace:role to the KC-PROTOCOL-DOC:Protocol Aggregator 
-- also need to limit this to truly unit qualified memberships and associate the RoleMembership to the unit in ROLE_MBR_ATTR_DATA_T
DECLARE

  CURSOR role_mbr_data IS SELECT RMT.ROLE_MBR_ID, RMT.ROLE_ID, RMT.MBR_TYP_CD, RMAD.ATTR_VAL, RMAD.KIM_TYP_ID, RMAD.KIM_ATTR_DEFN_ID FROM KRIM_ROLE_MBR_T RMT 
   JOIN KRIM_ROLE_MBR_ATTR_DATA_T RMAD ON RMT.ROLE_MBR_ID = RMAD.ROLE_MBR_ID 
      WHERE RMT.ROLE_ID = (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD = 'KC-PROTOCOL' AND ROLE_NM = 'Protocol Aggregator') 
        AND RMAD.KIM_TYP_ID = (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD = 'KC-SYS' AND NM = 'Unit') 
        AND RMAD.KIM_ATTR_DEFN_ID = (SELECT KIM_ATTR_DEFN_ID FROM KRIM_ATTR_DEFN_T WHERE NM='unitNumber');
             
 BEGIN
    FOR record IN role_mbr_data 
    LOOP        
EXECUTE IMMEDIATE 'INSERT INTO KRIM_ROLE_MBR_T (ROLE_MBR_ID,ROLE_ID,MBR_ID,MBR_TYP_CD,LAST_UPDT_DT,OBJ_ID,VER_NBR) 
   VALUES (CONCAT(''KC'',KRIM_ROLE_MBR_ID_S.NEXTVAL),(SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD = ''KC-PROTOCOL-DOC'' AND ROLE_NM = ''Protocol Aggregator''),(:1),(:2),SYSDATE,SYS_GUID(),1 )' USING record.ROLE_MBR_ID, record.MBR_TYP_CD;


EXECUTE IMMEDIATE 'INSERT INTO KRIM_ROLE_MBR_ATTR_DATA_T (ATTR_DATA_ID,ROLE_MBR_ID,KIM_TYP_ID,KIM_ATTR_DEFN_ID,ATTR_VAL,OBJ_ID,VER_NBR) 
   VALUES (CONCAT(''KC'',KRIM_ATTR_DATA_ID_S.NEXTVAL),CONCAT(''KC'',KRIM_ROLE_MBR_ID_S.CURRVAL),(:1),(:2),(:3),SYS_GUID(),1)' USING record.KIM_TYP_ID, record.KIM_ATTR_DEFN_ID, record.ATTR_VAL;
   
           	COMMIT;
    END LOOP;
END;
/

-- add all role memberships that are currently in KC-PROTOCOL:Protocol Viewer namespace:role to the KC-PROTOCOL-DOC:Protocol Viewer 
-- also need to limit this to truly unit qualified memberships and associate the RoleMembership to the unit in ROLE_MBR_ATTR_DATA_T
DECLARE

  CURSOR role_mbr_data IS SELECT RMT.ROLE_MBR_ID, RMT.ROLE_ID, RMT.MBR_TYP_CD, RMAD.ATTR_VAL, RMAD.KIM_TYP_ID, RMAD.KIM_ATTR_DEFN_ID FROM KRIM_ROLE_MBR_T RMT 
   JOIN KRIM_ROLE_MBR_ATTR_DATA_T RMAD ON RMT.ROLE_MBR_ID = RMAD.ROLE_MBR_ID 
      WHERE RMT.ROLE_ID = (SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD = 'KC-PROTOCOL' AND ROLE_NM = 'Protocol Viewer') 
        AND RMAD.KIM_TYP_ID = (SELECT KIM_TYP_ID FROM KRIM_TYP_T WHERE NMSPC_CD = 'KC-SYS' AND NM = 'Unit') 
        AND RMAD.KIM_ATTR_DEFN_ID = (SELECT KIM_ATTR_DEFN_ID FROM KRIM_ATTR_DEFN_T WHERE NM='unitNumber');
             
 BEGIN
    FOR record IN role_mbr_data 
    LOOP        
EXECUTE IMMEDIATE 'INSERT INTO KRIM_ROLE_MBR_T (ROLE_MBR_ID,ROLE_ID,MBR_ID,MBR_TYP_CD,LAST_UPDT_DT,OBJ_ID,VER_NBR) 
   VALUES (CONCAT(''KC'',KRIM_ROLE_MBR_ID_S.NEXTVAL),(SELECT ROLE_ID FROM KRIM_ROLE_T WHERE NMSPC_CD = ''KC-PROTOCOL-DOC'' AND ROLE_NM = ''Protocol Viewer''),(:1),(:2),SYSDATE,SYS_GUID(),1 )' USING record.ROLE_MBR_ID, record.MBR_TYP_CD;
      

EXECUTE IMMEDIATE 'INSERT INTO KRIM_ROLE_MBR_ATTR_DATA_T (ATTR_DATA_ID,ROLE_MBR_ID,KIM_TYP_ID,KIM_ATTR_DEFN_ID,ATTR_VAL,OBJ_ID,VER_NBR) 
   VALUES (CONCAT(''KC'',KRIM_ATTR_DATA_ID_S.NEXTVAL),CONCAT(''KC'',KRIM_ROLE_MBR_ID_S.CURRVAL),(:1),(:2),(:3),SYS_GUID(),1)' USING record.KIM_TYP_ID, record.KIM_ATTR_DEFN_ID, record.ATTR_VAL;
   
           	COMMIT;
    END LOOP;
END;
/
