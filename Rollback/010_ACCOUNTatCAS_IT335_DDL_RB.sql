/*
  Script:      010_ACCOUNTatCAS_IT335_DDL_RB.sql
  Author:      Carlos Mendoza
  Date:        06/24/2019
  Purpose:     IT-335 DDL Rollback script for ACCOUNT schema.  
*/

SET TERMOUT ON
SET ECHO Off
SET LINESIZE 80
--SET ESCAPE ^
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')     filename
  FROM dual; 
  
--- Example spool  40_ProductAtCas_WO88359_Deploy_&filename1..log
spool  010_ACCOUNTatCAS_IT335_DDL_RB_&filename1..log

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;
 
SELECT 'current user is ' || USER || ' at '
  FROM dual;


SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;


@T_DIGITAL_FORM_SUBMISSION_HISTORY_RB.sql
sho ERRORS

@SEQ_DIGITAL_FORM_SUBMISSION_HISTORY_RB.sql
sho ERRORS


@T_DIGITAL_FORM_SUBMISSION_RB.sql
sho ERRORS
@SEQ_DIGITAL_FORM_SUBMISSION_RB.sql
sho ERRORS

@T_LU_DIGITAL_FORM_DESCRIPTION_RB.sql
sho ERRORS

@PKG_FORM_SUBMISSION_RB.sql

  
SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF 
