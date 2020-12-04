/*
  Script:      020_DBAatCAS_IT335_RO.sql
  Author:      Carolina Ardura
  Date:        03/01/2019
  Purpose:     Create pkg synonym
*/

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80
--SET ESCAPE ^
--SET DEFINE OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK
column filename NEW_VAL filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')     filename
  FROM dual; 
  
spo 020_DBAatCAS_IT335_RO_&filename1..log

SELECT 'current user is ' || USER || ' at ' FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

/* *** */

CREATE OR REPLACE PUBLIC SYNONYM PKG_FORM_SUBMISSION FOR ACCOUNT.PKG_FORM_SUBMISSION_P;

/* *** */

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

sho ERRORS
spo OFF
