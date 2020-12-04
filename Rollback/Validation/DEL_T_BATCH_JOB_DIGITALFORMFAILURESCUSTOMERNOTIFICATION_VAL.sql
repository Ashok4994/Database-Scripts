/*
  Script:      DEL_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION.sql
  Author:      siturrioz 
  Date:        12/03/2019
  Purpose:     Validates batch job inserts rollback.  
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
    v_expected := 0;

    SELECT COUNT(0)
      INTO v_count
      FROM T_BATCH_JOB
     WHERE JOB_NAME IN ('DigitalFormFailuresCustomerNotificationJob');

    IF v_count <> v_expected THEN
        v_err_msg := 'T_BATCH_JOB DigitalFormFailuresCustomerNotificationJob rollback is not valid. Count is: ' ||
                     v_count || ', was expecting ' || v_expected;
    END IF;


    IF v_err_msg IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20002,
                                'IT-335 T_BATCH_JOB DigitalFormFailuresCustomerNotificationJob rollback validations FAILED. Errors:' ||
                                 v_err_msg);
    
    END IF;

    DBMS_OUTPUT.PUT_LINE('Delete DigitalFormFailuresCustomerNotificationJob has PASSED all validations.');

END;
/
