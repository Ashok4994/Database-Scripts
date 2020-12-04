/*
  Script:      040_ACCOUNTatCAS_IT335_DML_RO.sql
  Author:      Matias Mendoza
  Date:        11/12/2019
  Purpose:     Insert new form names and descriptions
*****************************************************************************
*
* Insert new form names and descriptions
*
*****************************************************************************/

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80
SET SERVEROUTPUT ON SIZE 1040040
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')  filename
  FROM dual;
  
spo 040_ACCOUNTatCAS_IT335_DML_RO_&filename1..log;

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT SYS_CONTEXT('USERENV','INSTANCE_NAME') FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@INSERT_FORM_NAME_DESC.SQL;
sho ERRORS;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF
