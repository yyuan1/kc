-- Dropping legacy country code tables
ALTER TABLE ROLODEX DROP CONSTRAINT FK_ROLODEX_COUNTRY_KRA;
DROP TABLE COUNTRY_CODE;
DROP TABLE KC_COUNTRY_CODES_T;
DROP SEQUENCE KC_COUNTRY_CODES_SEQ;
-- Update a few codes in bootstrap data in existing tables
UPDATE ROLODEX SET COUNTRY_CODE='CZE' WHERE COUNTRY_CODE='CSK';
UPDATE ROLODEX SET COUNTRY_CODE='DEU' WHERE COUNTRY_CODE='DDR';
UPDATE ROLODEX SET COUNTRY_CODE='ZZZ' WHERE COUNTRY_CODE='XXX';
UPDATE ROLODEX SET COUNTRY_CODE='RUS' WHERE COUNTRY_CODE='SUN';
UPDATE SPONSOR SET COUNTRY_CODE='DEU' WHERE COUNTRY_CODE='DDR';
UPDATE SPONSOR SET COUNTRY_CODE='ZZZ' WHERE COUNTRY_CODE='XXX';
UPDATE SPONSOR SET COUNTRY_CODE='RUS' WHERE COUNTRY_CODE='SUN';