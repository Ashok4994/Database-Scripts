/*
  Script:      020_DBAatCAS_IT335_RO_VALIDATION.sql
  Author:      Carolina Ardura
  Date:        03/01/2019
  Purpose:     Validate synonym creation.
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

spo 020_DBAatCAS_IT335_RO_VALIDATION_&filename1..log;

SELECT 'current user is ' || USER || ' at ' FROM dual;

SELECT TO_CHAR(SYSDATE,'DD-Mon-YYYY HH24:MI:SS') date_ FROM dual;


DECLARE
  str_audit           VARCHAR2(10000);
  str_err             VARCHAR2(10000);
  v_varchar           VARCHAR2(50);
  v_ext               VARCHAR(10);
  str_syn             VARCHAR2(100);
  str_schema          VARCHAR2(100);
  str_validation_type VARCHAR2(100);

BEGIN
  str_err   := NULL;
  str_audit := NULL;
  
  -- Validate PKG_FORM_SUBMISSION rollout

  -- Set these 3 variables for your package.
  str_syn             := 'PKG_FORM_SUBMISSION';
  str_schema          := 'ACCOUNT';
  str_validation_type := 'ROLLOUT'; -- Should be either 'ROLLOUT' or 'ROLLBACK'

  IF (str_validation_type = 'ROLLOUT') THEN
    v_ext := '_P';
  ELSE
    v_ext := '_R';
  END IF;

  -- Validate Synonym
  BEGIN
    -- Select synonym   
    SELECT table_name
      INTO v_varchar
      FROM dba_synonyms
     WHERE synonym_name = str_syn
       AND owner = 'PUBLIC'
       AND table_owner = str_schema;
    
    -- Validate synonym created and pointing to correct package
    IF v_varchar = str_syn || v_ext THEN
      str_audit := str_audit || 'Public synonym ' || str_syn ||
                   ' is created for ' || v_varchar || ' in the database' ||
                   chr(13);
    ELSE
      str_err := str_err || '- Public synonym is NOT created for ' ||
                 str_syn || v_ext || ' in the database' || chr(13);
    END IF;
    
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      str_err := str_err || '- Public synonym is NOT created!' || chr(13);
  END;
  
  
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
