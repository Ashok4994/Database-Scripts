/*
  Script:      INS_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION_PARMS_VAL.sql
  Author:      siturrioz
  Date:        12/03/2019
  Purpose:     Validates batch job params inserts.  
*****************************************************************************
*
* Description and details
*
*****************************************************************************/

DECLARE
  v_count    PLS_INTEGER;
  v_expected PLS_INTEGER;
  v_err_msg  VARCHAR2(1000);
  v_job_id   INTEGER;
BEGIN
  v_count    := 0;
  v_expected := 1;

  SELECT COUNT(0)
    INTO v_count
    FROM T_BATCH_JOB_PARMS t
   WHERE t.parm_key IN
         ('DigitalFormFailuresCustomerNotificationSpecialExecutionDate')
     AND t.job_id in
         (SELECT JOB_ID
            FROM T_BATCH_JOB T
           WHERE T.JOB_NAME = 'DigitalFormFailuresCustomerNotificationJob');

  IF v_count <> v_expected THEN
    v_err_msg := 'T_BATCH_JOB_PARAMS insert is not valid for job DigitalFormFailuresCustomerNotificationJob. Count is: ' ||
                 v_count || ', was expecting ' || v_expected;
  END IF;

  IF v_err_msg IS NOT NULL THEN
    RAISE_APPLICATION_ERROR(-20002,
                            'IT335 T_BATCH_JOB_PARMS rollout insert DigitalFormFailuresCustomerNotificationJob validations FAILED. Errors:' ||
                            v_err_msg);
  
  END IF;

  DBMS_OUTPUT.PUT_LINE('Insert DigitalFormFailuresCustomerNotificationJob parameters has PASSED all validations.');

END;
/
