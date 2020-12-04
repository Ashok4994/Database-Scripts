/*
  Script:      020_DBAatCAS_IT335_RB.sql
  Author:      Carolina Ardura
  Date:        03/01/2019
  Purpose:     Run database deployment.
*/

SET TERMOUT ON
SET ECHO OFF
SET LINESIZE 80
--SET ESCAPE ^
--SET DEFINE OFF
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK
column filename NEW_VAL filename1 

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')  filename
  FROM dual;

spo 020_DBAatCAS_IT335_RB_&filename1..log;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

DECLARE 
   v_count NUMBER := 0;
BEGIN
/* *** */

  SELECT COUNT(1)
  INTO v_count
  FROM dba_SYNONYMS
  WHERE SYNONYM_name = 'PKG_FORM_SUBMISSION'
  AND owner = 'PUBLIC'
  AND table_owner = 'ACCOUNT';
      
  IF v_count > 0 THEN
     EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM PKG_FORM_SUBMISSION';
  END IF;

/* *** */
END;
/

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

sho ERRORS
spo OFF
