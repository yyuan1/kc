-- KEW data for Proposal Development Person Certification Questionnaire

INSERT INTO KREW_ACTN_TKN_S VALUES (NULL);
INSERT INTO KREW_ACTN_TKN_T (ACTN_TKN_ID,DOC_HDR_ID,PRNCPL_ID,ACTN_CD,ACTN_DT,DOC_VER_NBR,CUR_IND,VER_NBR) 
  VALUES ((SELECT MAX(ID) FROM KREW_ACTN_TKN_S),(SELECT DOC_HDR_ID FROM KREW_DOC_HDR_T WHERE TTL = 'Proposal Person Certification'),'admin','S',STR_TO_DATE('20100708','%Y%m%d'),1,1,1);
INSERT INTO KREW_ACTN_TKN_S VALUES (NULL);
INSERT INTO KREW_ACTN_TKN_T (ACTN_TKN_ID,DOC_HDR_ID,PRNCPL_ID,ACTN_CD,ACTN_DT,DOC_VER_NBR,CUR_IND,VER_NBR) 
  VALUES ((SELECT MAX(ID) FROM KREW_ACTN_TKN_S),(SELECT DOC_HDR_ID FROM KREW_DOC_HDR_T WHERE TTL = 'Proposal Person Certification'),'admin','C',STR_TO_DATE('20100708','%Y%m%d'),1,1,1);
  
COMMIT;