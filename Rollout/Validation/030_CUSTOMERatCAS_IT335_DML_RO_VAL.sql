/*
  Script:      030_CUSTOMERatCAS_IT335_DML_RO_VAL.sql
  Author:      Gustavo Lara
  Date:        08/27/2019
  Purpose:     Validate new web note
*****************************************************************************
*
* Validate new web note
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
  
spo 030_CUSTOMERatCAS_IT335_DML_RO_VAL_&filename1..log;

ALTER SESSION SET CURRENT_SCHEMA = CUSTOMER;
 
SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT SYS_CONTEXT('USERENV','INSTANCE_NAME') FROM dual;
 
SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;

DECLARE
  V_COUNT      		  PLS_INTEGER;
  str_audit           VARCHAR2(10000);
  str_err             VARCHAR2(10000);
  V_TABLE                 VARCHAR2(500);
  V_WEB_MESSAGE_TYPE_ID   T_LU_WEB_MESSAGE_TYPE.WEB_MESSAGE_TYPE_ID%TYPE;
  
  TYPE T_MESSAGE_TYPE IS VARRAY(7) OF T_LU_WEB_MESSAGE_TYPE.WEB_MESSAGE_TYPE%TYPE;
  TYPE T_MESSAGES is VARRAY(7) OF VARCHAR2(512);
  
  A_MESSAGE_TYPES T_MESSAGE_TYPE := 
    T_MESSAGE_TYPE(
         'MsgNameChangeFormSubmissionConfirmation',
         'MsgPowerOfAttorneyFormSubmissionConfirmation',
         'MsgSCRAFormSubmissionConfirmation',
         'MsgPaymentVerificationFormSubmissionConfirmation',
         'MsgIdentityVerificationFormSubmissionConfirmation',
         'MsgOtherInquiriesFormSubmissionConfirmation',
         'MsgFormSubmissionFailure'
  );
  
  A_MESSAGES T_MESSAGES := 
    T_MESSAGES(
      'Your Name Change Request form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Power of Attorney Request form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Military Service Members Civil Relief Act (SCRA) form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Payment Verification form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Identity Verification form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your inquiry was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'We were not able to process the form {0} submitted on {1} due to internal problems, please resubmit the form.'            
    );

BEGIN

  FOR MT_INDEX in 1..A_MESSAGE_TYPES.COUNT LOOP  
  
		str_err   := NULL;
		str_audit := NULL;

		--Insert in table T_LU_WEB_MESSAGE_TYPE
		V_TABLE := 'T_LU_WEB_MESSAGE_TYPE';

		-- Check if record already exists
		SELECT   COUNT(1)
		INTO     V_COUNT
		FROM     T_LU_WEB_MESSAGE_TYPE 
		WHERE    WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);
				
		IF (V_COUNT = 1) THEN			
			str_audit := str_audit ||'A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' code in ' || V_TABLE || ' table exists. Validation OK.' || chr(13);
			
			SELECT   WEB_MESSAGE_TYPE_ID
			INTO     V_WEB_MESSAGE_TYPE_ID
			FROM     T_LU_WEB_MESSAGE_TYPE 
			WHERE    WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);
			
		ELSE
			str_err := str_err || 'A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' code in ' || V_TABLE || ' table did not exist. Validation FAILED!.' || chr(13);
		END IF;


-----------------------------------------------------------------------------------------------------------

		--Insert in table T_WEB_MESSAGE_VERSION
		V_TABLE := 'T_WEB_MESSAGE_VERSION';

		-- Check if record already exists
		SELECT   COUNT(1)
		INTO     V_COUNT
		FROM     T_WEB_MESSAGE_VERSION 
		WHERE    WEB_MESSAGE_TYPE_ID = V_WEB_MESSAGE_TYPE_ID
		AND		 WEB_MESSAGE = A_MESSAGES(MT_INDEX);
					  
		IF (V_COUNT = 1) THEN
			str_audit := str_audit ||'A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' id in ' || V_TABLE || ' table exists. Validation OK.' || chr(13);
		ELSE      
			str_err := str_err || 'A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' id in ' || V_TABLE || ' table did not exist. Validation FAILED!.' || chr(13);
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
