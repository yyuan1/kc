CREATE TABLE PROTOCOL_SUBMISSION (
    SUBMISSION_ID                   NUMBER(12) NOT NULL,
    PROTOCOL_NUMBER                 VARCHAR2(20) NOT NULL,
    SEQUENCE_NUMBER                 NUMBER(4) NOT NULL,
    SUBMISSION_NUMBER               NUMBER(4) NOT NULL,
    SCHEDULE_ID                     VARCHAR2(10),
    COMMITTEE_ID                    VARCHAR2(15),
    PROTOCOL_ID                     NUMBER(12,0) NOT NULL,
    SCHEDULE_ID_FK                  NUMBER(12),
    COMMITTEE_ID_FK                 NUMBER(12),
    SUBMISSION_TYPE_CODE            VARCHAR2(3) NOT NULL,
    SUBMISSION_TYPE_QUAL_CODE       VARCHAR2(3),
    SUBMISSION_STATUS_CODE          VARCHAR2(3) NOT NULL,
    PROTOCOL_REVIEW_TYPE_CODE       VARCHAR2(3) NOT NULL,
    SUBMISSION_DATE                 DATE NOT NULL,
    COMMENTS                        VARCHAR2(2000),
    COMM_DECISION_MOTION_TYPE_CODE  VARCHAR2(3),
    YES_VOTE_COUNT                  NUMBER(3),
    NO_VOTE_COUNT                   NUMBER(3),
    ABSTAINER_COUNT                 NUMBER(3),
    VOTING_COMMENTS                 VARCHAR2(2000),
    UPDATE_TIMESTAMP                DATE,
    UPDATE_USER                     VARCHAR2(60),
    VER_NBR                         NUMBER(8,0) DEFAULT 1 NOT NULL,
    OBJ_ID                          VARCHAR2(36) DEFAULT SYS_GUID() NOT NULL);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT PK_PROTOCOL_SUBMISSION
PRIMARY KEY (SUBMISSION_ID);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION1
FOREIGN KEY (PROTOCOL_ID)
REFERENCES PROTOCOL (PROTOCOL_ID);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION2
FOREIGN KEY (SCHEDULE_ID_FK)
REFERENCES COMM_SCHEDULE (ID);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION3
FOREIGN KEY (COMMITTEE_ID_FK)
REFERENCES COMMITTEE (ID);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION4
FOREIGN KEY (PROTOCOL_REVIEW_TYPE_CODE)
REFERENCES PROTOCOL_REVIEW_TYPE (PROTOCOL_REVIEW_TYPE_CODE);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION5
FOREIGN KEY (SUBMISSION_STATUS_CODE)
REFERENCES SUBMISSION_STATUS (SUBMISSION_STATUS_CODE);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION6
FOREIGN KEY (SUBMISSION_TYPE_CODE)
REFERENCES SUBMISSION_TYPE (SUBMISSION_TYPE_CODE);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION7
FOREIGN KEY (SUBMISSION_TYPE_QUAL_CODE)
REFERENCES SUBMISSION_TYPE_QUALIFIER (SUBMISSION_TYPE_QUAL_CODE);

ALTER TABLE PROTOCOL_SUBMISSION
ADD CONSTRAINT FK_PROTOCOL_SUBMISSION8
FOREIGN KEY (COMM_DECISION_MOTION_TYPE_CODE)
REFERENCES COMM_DECISION_MOTION_TYPE (COMM_DECISION_MOTION_TYPE_CODE);
