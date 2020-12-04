/*
  Script:      030_CUSTOMERatCAS_IT335_DML_RO.sql
  Author:      Gustavo Lara
  Date:        08/27/2019
  Purpose:     Insert new web note
*****************************************************************************
*
* Insert new web note
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
  
spo 030_CUSTOMERatCAS_IT335_DML_RO_&filename1..log;

ALTER SESSION SET CURRENT_SCHEMA = CUSTOMER;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT SYS_CONTEXT('USERENV','INSTANCE_NAME') FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

@INSERT_NOTE.SQL;
sho ERRORS;

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF
