/*
  Script:      SEQ_DIGITAL_FORM_SUBMISSION_RB.sql
  Schema:      ACCOUNT
  Author:      Carolina Ardura
  Date:        07/03/2019
  Purpose:     Rollback of the creation of the sequence for SEQ_DIGITAL_FORM_SUBMISSION.  
*/

DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(1) 
	INTO v_count 
	FROM all_sequences u 
	WHERE UPPER(u.sequence_name) = 'SEQ_DIGITAL_FORM_SUBMISSION';
  
  IF (v_count = 1) THEN 
      execute immediate 'DROP SEQUENCE SEQ_DIGITAL_FORM_SUBMISSION';
  END IF;
   
END;
/
