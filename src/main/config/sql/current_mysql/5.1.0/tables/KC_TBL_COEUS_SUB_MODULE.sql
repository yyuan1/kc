DELIMITER /
alter table COEUS_SUB_MODULE add REQUIRE_UNIQUE_QUESTIONNAIRE CHAR(1) DEFAULT 'N'
/

update COEUS_SUB_MODULE set REQUIRE_UNIQUE_QUESTIONNAIRE = 'Y' where MODULE_CODE = 3 and SUB_MODULE_CODE = 3
/

DELIMITER ;
