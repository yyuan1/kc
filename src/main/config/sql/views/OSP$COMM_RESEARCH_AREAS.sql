CREATE OR REPLACE VIEW OSP$COMM_RESEARCH_AREAS AS SELECT
  COMMITTEE_ID,
  RESEARCH_AREA_CODE,
  UPDATE_TIMESTAMP,
  UPDATE_USER
FROM COMM_RESEARCH_AREAS;
