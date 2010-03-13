ALTER TABLE BUDGET_RATE_AND_BASE DROP PRIMARY KEY CASCADE;

ALTER TABLE BUDGET_RATE_AND_BASE ADD ( BUDGET_ID NUMBER (12, 0),
		BUDGET_RATE_AND_BASE_ID NUMBER(12,0),
		BUDGET_DETAILS_CAL_AMTS_ID NUMBER(12,0),
		BUDGET_DETAILS_ID NUMBER(12,0) )
	MODIFY (PROPOSAL_NUMBER NULL,
		VERSION_NUMBER NULL,
		BUDGET_PERIOD_NUMBER NULL );

ALTER TABLE BUDGET_RATE_AND_BASE 
    ADD CONSTRAINT BUDGET_RATE_AND_BASE_PK 
            PRIMARY KEY (BUDGET_RATE_AND_BASE_ID) ;
            
