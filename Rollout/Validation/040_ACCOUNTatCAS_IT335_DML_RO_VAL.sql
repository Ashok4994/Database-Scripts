/*
  Script:      040_ACCOUNTatCAS_IT335_DML_RO_VAL.sql
  Author:      Matias Mendoza
  Date:        11/12/2019
  Purpose:     Validate new form names and descriptions
*****************************************************************************
*
* Validate new form names and descriptions
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
  
spo 040_ACCOUNTatCAS_IT335_DML_RO_VAL_&filename1..log;

ALTER SESSION SET CURRENT_SCHEMA = ACCOUNT;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT SYS_CONTEXT('USERENV','INSTANCE_NAME') FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

DECLARE
  V_COUNT      		  PLS_INTEGER;
  str_audit           VARCHAR2(10000);
  str_err             VARCHAR2(10000);
  V_TABLE                 VARCHAR2(500);
  V_FORM_NAME                       T_LU_DIGITAL_FORM_DESCRIPTION.FORM_NAME%TYPE;
  
  TYPE T_FORM_NAMES IS VARRAY(6) OF T_LU_DIGITAL_FORM_DESCRIPTION.FORM_NAME%TYPE;
  TYPE T_DESCRIPTIONS is VARRAY(6) OF VARCHAR2(100);
  
  A_FORM_NAMES T_FORM_NAMES := 
    T_FORM_NAMES(
         'NAME_CHANGE',
         'POWER_OF_ATTORNEY',
         'MILITARY_SCRA',
         'PAYMENT_VERIFICATION_LETTER',
         'IDENTIFICATION_DOCUMENTS',
         'CS_INQUIRIES'         
  );
  
  A_DESCRIPTIONS T_DESCRIPTIONS := 
    T_DESCRIPTIONS(
      'Name Change Request',
	  'Power of Attorney Request',
	  'Service Members Civil Relief Act Request',
	  'Payment Verification',
	  'Identification Verification',
	  'All Other Inquiries'
	  );

BEGIN

  FOR FN_INDEX in 1..A_FORM_NAMES.COUNT LOOP  
  
		str_err   := NULL;
		str_audit := NULL;

		--validation in table T_LU_DIGITAL_FORM_DESCRIPTION
		V_TABLE := 'T_LU_DIGITAL_FORM_DESCRIPTION';

		-- Check if record already exists
		SELECT   COUNT(1)
        INTO     V_COUNT
        FROM     T_LU_DIGITAL_FORM_DESCRIPTION 
        WHERE    FORM_NAME = A_FORM_NAMES(FN_INDEX);
				
		IF (V_COUNT = 1) THEN			
			str_audit := str_audit ||'A record with name ''' || A_FORM_NAMES(FN_INDEX) || ''' and description ''' || A_DESCRIPTIONS(FN_INDEX) || ''' in ' || V_TABLE || ' table exists. Validation OK.' || chr(13);
		
		ELSE
			str_err := str_err || 'A record with name ''' || A_FORM_NAMES(FN_INDEX) || ''' and description ''' || A_DESCRIPTIONS(FN_INDEX) || ''' in ' || V_TABLE || ' table did not exist. Validation FAILED!.' || chr(13);
		END IF;


		IF (NVL(LENGTH(str_err), 0) = 0) THEN
			DBMS_OUTPUT.PUT_LINE('Validation successfull!' || chr(13));
			DBMS_OUTPUT.PUT_LINE(str_audit);
		ELSE
			DBMS_OUTPUT.PUT_LINE('VALIDATION FAILED!' || chr(13));
			DBMS_OUTPUT.PUT_LINE('Audit Data:');
			DBMS_OUTPUT.PUT_LINE(str_audit);
			DBMS_OUTPUT.PUT_LINE('Error Data:');
			DBMS_OUTPUT.PUT_LINE(str_err);
			RAISE_APPLICATION_ERROR(-20001,
								  'Audit Data: ' ||
								  str_audit || chr(13) || 'Error Data: ' ||
								  chr(13) || str_err || chr(13));
		END IF;
	
	END LOOP;

END;
/

SELECT TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS') date_
  FROM dual;

sho ERRORS 
spo OFF
