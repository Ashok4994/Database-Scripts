/*
  Script:      PKG_FORM_SUBMISSION_RB.sql
  Schema:      ACCOUNT
  Author:      Carolina Ardura
  Project:     IT-335
  Date:        2019-03-01
  Purpose:     Remove PKG for generic form submission
*/

DECLARE
  v_count NUMBER;
BEGIN
  SELECT 
    COUNT(1)
  INTO v_count 
  FROM dba_objects
 WHERE object_name = 'PKG_FORM_SUBMISSION_P';  

  IF (v_count = 1) THEN 
      EXECUTE IMMEDIATE 'DROP PACKAGE PKG_FORM_SUBMISSION_P';
  END IF;
   
END;
/



