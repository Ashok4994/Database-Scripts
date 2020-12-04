/*
  Script:      010_ACCOUNTatCAS_IT335_DDL_RB_Validation.sql
  Author:      Carlos Mendoza
  Date:        06/24/2019
  Purpose:     IT-335 DDL Rollback validation script for ACCOUNT schema.  
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
spool  010_ACCOUNTatCAS_IT335_DDL_RB_Validation_&filename1..log

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;
 
SELECT 'current user is ' || USER || ' at '
  FROM dual;


SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

DECLARE
  v_count      		  		PLS_INTEGER;
  str_audit           		VARCHAR2(10000);
  str_err             		VARCHAR2(10000);
  str_schema             	VARCHAR2(10000);
  str_validation_type    	VARCHAR2(10000);
  str_syn             		VARCHAR2(10000);
  v_ext						VARCHAR2(10);
  

BEGIN  
str_err   := NULL;
str_audit := NULL;
str_validation_type := NULL;
str_syn := NULL;
str_schema := NULL;
v_ext := NULL;

--Validate table T_DIGITAL_FORM_SUBMISSION
SELECT COUNT(1) 
INTO v_count 
FROM all_tables u 
WHERE UPPER(u.table_name) = 'T_DIGITAL_FORM_SUBMISSION';

IF (V_COUNT = 0) THEN
	str_audit := str_audit || 'TABLE T_DIGITAL_FORM_SUBMISSION HAS BEEN DROPPED!' || chr(13);		
ELSE
	str_err := str_err || 'VALIDATION FAILED CHECKING FOR TABLE NAME T_DIGITAL_FORM_SUBMISSION! '|| chr(13);
END IF;

--Validate sequence SEQ_DIGITAL_FORM_SUBMISSION
SELECT COUNT(1) 
INTO v_count 
FROM all_sequences 
WHERE UPPER(sequence_name) = 'SEQ_DIGITAL_FORM_SUBMISSION';
	
IF (V_COUNT = 0) THEN
	str_audit := str_audit || ' SEQUENCE SEQ_DIGITAL_FORM_SUBMISSION HAS BEEN DROPPED! ' || chr(13);
ELSE
	str_err := str_err || ' VALIDATION FAILED CHECKING FOR SEQUENCE NAME SEQ_DIGITAL_FORM_SUBMISSION! ' || chr(13);
END IF;
  

--Validate table T_DIGITAL_FORM_SUBMISSION_HISTORY_HISTORY
SELECT COUNT(1) 
INTO v_count 
FROM all_tables u 
WHERE UPPER(u.table_name) = 'T_DIGITAL_FORM_SUBMISSION_HISTORY';

IF (V_COUNT = 0) THEN
	str_audit := str_audit || 'TABLE T_DIGITAL_FORM_SUBMISSION_HISTORY HAS BEEN DROPPED!' || chr(13);		
ELSE
	str_err := str_err || 'VALIDATION FAILED CHECKING FOR TABLE NAME T_DIGITAL_FORM_SUBMISSION_HISTORY! '|| chr(13);
END IF;

--Validate sequence SEQ_DIGITAL_FORM_SUBMISSION_HISTORY
SELECT COUNT(1) 
INTO v_count 
FROM all_sequences 
WHERE UPPER(sequence_name) = 'SEQ_DIGITAL_FORM_SUBMISSION_HISTORY';
	
IF (V_COUNT = 0) THEN
	str_audit := str_audit || ' SEQUENCE SEQ_DIGITAL_FORM_SUBMISSION_HISTORY HAS BEEN DROPPED! ' || chr(13);
ELSE
	str_err := str_err || ' VALIDATION FAILED CHECKING FOR SEQUENCE NAME SEQ_DIGITAL_FORM_SUBMISSION_HISTORY! ' || chr(13);
END IF;

--Validate table T_LU_DIGITAL_FORM_DESCRIPTION
SELECT COUNT(1) 
INTO v_count 
FROM all_tables u 
WHERE UPPER(u.table_name) = 'T_LU_DIGITAL_FORM_DESCRIPTION';

IF (V_COUNT = 0) THEN
	str_audit := str_audit || 'TABLE T_LU_DIGITAL_FORM_DESCRIPTION HAS BEEN DROPPED!' || chr(13);		
ELSE
	str_err := str_err || 'VALIDATION FAILED CHECKING FOR TABLE NAME T_LU_DIGITAL_FORM_DESCRIPTION! '|| chr(13);
END IF;



--Validate PKG_FORM_SUBMISSION
-- Set these 3 variables for your package.
str_syn             := 'PKG_FORM_SUBMISSION';
str_schema          := 'ACCOUNT';
str_validation_type := 'ROLLOUT'; -- Should be either 'ROLLOUT' or 'ROLLBACK'

IF (str_validation_type = 'ROLLOUT') THEN
  v_ext := '_P';
ELSE
  v_ext := '_R';
END IF;
   
-- Validate Production Package
SELECT COUNT(1)
  INTO v_count
  FROM dba_objects
 WHERE object_name = str_syn || v_ext
   AND owner = str_schema
   AND status = 'VALID';

 IF v_count = 0 THEN
    str_audit := str_audit || str_schema || '.' || str_syn || v_ext ||
                 ' package was removed from the database.' || chr(13);
  ELSE
    str_err := str_err || '- ' || str_schema || '.' || str_syn || v_ext ||
               ' package was not removed from the database!' || chr(13);
  END IF;

IF (NVL(LENGTH(str_err), 0) = 0) THEN
    DBMS_OUTPUT.PUT_LINE(str_validation_type || ' is successfull!' ||
                         chr(13));
ELSE
  DBMS_OUTPUT.PUT_LINE(str_validation_type || ' FAILED!' || chr(13));
  DBMS_OUTPUT.PUT_LINE('Audit Data:');
  DBMS_OUTPUT.PUT_LINE(str_audit);
  DBMS_OUTPUT.PUT_LINE('Error Data:');
  DBMS_OUTPUT.PUT_LINE(str_err);
  RAISE_APPLICATION_ERROR(-20001,
                          'Validation failed! ' || str_validation_type ||
                          ' FAILED!' || chr(13) || 'Audit Data: ' ||
                          str_audit || chr(13) || 'Error Data: ' ||
                          chr(13) || str_err || chr(13));
  END IF;

END;
/

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

sho ERRORS
spo OFF
