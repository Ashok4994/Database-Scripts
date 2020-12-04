/*
  Script:      INS_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION_VAL.sql
  Author:      siturrioz
  Date:        12/03/2019
  Purpose:     Validates batch job inserts.  
*****************************************************************************
*
* Description and details
*
*****************************************************************************/

DECLARE

    v_count    PLS_INTEGER;
    v_expected PLS_INTEGER;
    v_err_msg  VARCHAR2(1000);

BEGIN

    v_count    := 0;
    v_expected := 1;

    SELECT COUNT(0)
      INTO v_count
      FROM T_BATCH_JOB
     WHERE JOB_NAME IN ('DigitalFormFailuresCustomerNotificationJob');

    IF v_count <> v_expected THEN
        v_err_msg := 'T_BATCH_JOB DigitalFormFailuresCustomerNotificationJob insert is not valid. Count is: ' ||
                     v_count || ', was expecting ' || v_expected;
    END IF;


    IF v_err_msg IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'IT335 T_BATCH_JOB rollout insert DigitalFormFailuresCustomerNotificationJob validations FAILED. Errors:' ||
                                 v_err_msg);
    
    END IF;

    DBMS_OUTPUT.PUT_LINE('Insert DigitalFormFailuresCustomerNotificationJob has PASSED all validations.');

END;
/
