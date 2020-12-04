/*
  Script:      050_BATCHatCAS_IT335_DML_RO_VALIDATION.sql
  Schema:      BATCH
  Author:      siturrioz
  Date:        12/03/2019
  Purpose:     Validate 050_BATCHatCAS_IT335_DML.sql

*/

SET TERMOUT ON
SET ECHO Off
SET LINESIZE 80
SET SERVEROUTPUT ON SIZE 10000

WHENEVER SQLERROR EXIT ROLLBACK

COLUMN filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')     filename
  FROM dual; 
  
spool  050_BATCHatCAS_IT335_DML_RO_VALIDATION_&filename1..log

ALTER SESSION SET CURRENT_SCHEMA = BATCH;
 
SELECT 'current user is ' || USER || ' at '
  FROM dual;


SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

@INS_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION_VAL.sql;

@INS_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION_PARMS_VAL.sql;

@INS_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION_VAL.sql;

@INS_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION_PARMS_VAL.sql;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF 
