
CREATE OR REPLACE VIEW OSP$SCHOOL_CODE ( SCHOOL_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER) 
	   AS select SCHOOL_CODE, DESCRIPTION, UPDATE_TIMESTAMP, UPDATE_USER
	from SCHOOL_CODE
