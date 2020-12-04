/*
  Script:      T_LU_DIGITAL_FORM_DESCRIPTION_RB.sql
  Schema:      ACCOUNT
  Author:      Matias Mendoza
  Date:        11/12/2019
  Purpose:     Rollback of the creation of the table T_LU_DIGITAL_FORM_DESCRIPTION.  
*/

DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(1) 
  INTO v_count 
  FROM all_tables
  WHERE UPPER(table_name) = 'T_LU_DIGITAL_FORM_DESCRIPTION';
  
  IF (v_count = 1) THEN 
      execute immediate 'DROP TABLE T_LU_DIGITAL_FORM_DESCRIPTION';
  END IF;
   
END;
/
