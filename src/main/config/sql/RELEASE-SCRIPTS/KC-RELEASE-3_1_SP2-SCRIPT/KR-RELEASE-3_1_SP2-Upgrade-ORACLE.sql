set define off\nset sqlblanklines on\nspool KR-RELEASE-3_1_SP2-Upgrade-ORACLE-Install.log
@ORACLE/DML/KR_DML_BS1_KRIM_ID_CLEAN.sql
@ORACLE/DML/KR_DML_BS2_KRIM_ID_CLEAN.sql
@ORACLE/DML/KR_DML_BS3_KRIM_PERM_T.sql
@ORACLE/DML/KR_DML_BS4_KRIM_PERM_ATTR_DATA_T.sql
@ORACLE/DML/KR_DML_BS4_KRIM_ROLE_T.sql
@ORACLE/DML/KR_DML_BS5_KRIM_ROLE_PERM_T.sql
@ORACLE/DML/KR_DML_BS6_KRIM_ROLE_MBR_T.sql
@ORACLE/DML/KR_DML_BS7_KRIM_ROLE_MBR_ATTR_DATA_T.sql
@ORACLE/DML/KR_DML_BS7_KRNS_PARM_T.sql
commit;\nexit;
