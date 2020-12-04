/*
  Script:      010_ACCOUNTatCAS_IT335_DDL_RO.sql
  Author:      Carlos Mendoza
  Date:        06/24/2019
  Purpose:     IT-335 DDL Rollout script for ACCOUNT schema.  
*/

SET TERMOUT ON
SET ECHO Off
spool empty.sql
spool off

SET LINESIZE 80
--SET ESCAPE ^
SET SERVEROUTPUT ON SIZE 10000
WHENEVER SQLERROR EXIT ROLLBACK
column filename new_val filename1 
COLUMN script_name new_val _script_name

SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')     filename
  FROM dual; 
  
--- Example spool  40_ProductAtCas_WO88359_Deploy_&filename1..log
spool  010_ACCOUNTatCAS_IT335_DDL_RO_&filename1..log

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;
 
SELECT 'current user is ' || USER || ' at '
  FROM dual;


SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;


--TABLE T_DIGITAL_FORM_SUBMISSION

DEFINE target_table_name = "T_DIGITAL_FORM_SUBMISSION"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from dba_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN
  v_script_name := '&&_script_name';
  if v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  end if;
END;
/

@&_script_name


--SQUENCE SEQ_DIGITAL_FORM_SUBMISSION

DEFINE target_sequence_name = "SEQ_DIGITAL_FORM_SUBMISSION"

SELECT CASE WHEN MAX(SEQUENCE_NAME) IS NULL THEN '&target_sequence_name' ELSE 'empty.sql' END AS script_name from ALL_SEQUENCES where SEQUENCE_NAME = '&target_sequence_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN
  v_script_name := '&&_script_name';
  if v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Sequence &&target_sequence_name already exists. Skipped.');
  end if;
  
END;
/

@&_script_name

--TABLE T_DIGITAL_FORM_SUBMISSION_HISTORY

DEFINE target_table_name = "T_DIGITAL_FORM_SUBMISSION_HISTORY"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from dba_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN
  v_script_name := '&&_script_name';
  if v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  end if;
  
END;
/

@&_script_name

--SQUENCE SEQ_DIGITAL_FORM_SUBMISSION_HISTORY

DEFINE target_sequence_name = "SEQ_DIGITAL_FORM_SUBMISSION_HISTORY"

SELECT CASE WHEN MAX(SEQUENCE_NAME) IS NULL THEN '&target_sequence_name' ELSE 'empty.sql' END AS script_name from ALL_SEQUENCES where SEQUENCE_NAME = '&target_sequence_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN
  v_script_name := '&&_script_name';
  if v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Sequence &&target_sequence_name already exists. Skipped.');
  end if;
  
END;
/

@&_script_name

--TABLE T_LU_DIGITAL_FORM_DESCRIPTION

DEFINE target_table_name = "T_LU_DIGITAL_FORM_DESCRIPTION"

SELECT CASE WHEN MAX(table_name) IS NULL THEN '&target_table_name' ELSE 'empty.sql' END AS script_name from dba_tables where table_name = '&target_table_name';

DECLARE
  v_script_name VARCHAR2(256);
BEGIN
  v_script_name := '&&_script_name';
  if v_script_name = 'empty.sql' THEN
    DBMS_OUTPUT.PUT_LINE('Table &&target_table_name already exists. Skipped.');
  end if;
END;
/

@&_script_name


--PKG_FORM_SUBMISSION_P
@PKG_FORM_SUBMISSION_P.sql


SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF 
