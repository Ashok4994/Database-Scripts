/*
  Script:      T_DIGITAL_FORM_SUBMISSION_RB.sql
  Schema:      ACCOUNT
  Author:      Carolina Ardura
  Date:        07/03/2019
  Purpose:     Rollback of the creation of the table T_DIGITAL_FORM_SUBMISSION.  
*/

DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(1) 
  INTO v_count 
  FROM all_tables
  WHERE UPPER(table_name) = 'T_DIGITAL_FORM_SUBMISSION';
  
  IF (v_count = 1) THEN 
      execute immediate 'DROP TABLE T_DIGITAL_FORM_SUBMISSION';
  END IF;
   
END;
/
