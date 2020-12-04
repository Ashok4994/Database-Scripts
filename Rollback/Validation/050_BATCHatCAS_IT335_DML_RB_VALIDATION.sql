/*

  Script:      450_BATCHatCAS_RISK245_DML_RB_VALIDATION.sql
  Schema:      BATCH
  Author:      mchuburu
  Date:        08/23/2019
  Purpose:     Validates 450_BATCHatCAS_RISK245_DML_RB.sql

*/

SET TERMOUT ON
SET ECHO Off
SET LINESIZE 80
SET SERVEROUTPUT ON SIZE 10000

WHENEVER SQLERROR EXIT ROLLBACK

column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')     filename
  FROM dual; 
  
spool  450_BATCHatCAS_RISK245_DML_RB_VALIDATION_&filename1..log

ALTER SESSION SET CURRENT_SCHEMA = BATCH;
 
SELECT 'current user is ' || USER || ' at '
  FROM dual;


SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;
  

@DEL_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION_PARAMS_VAL.sql;

@DEL_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION_VAL.sql;

@DEL_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION_PARAMS_VAL.sql;

@DEL_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION_VAL.sql;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF 