/*
  Script:      DEL_T_BATCH_JOB_DIGITALFORMFAILURESCUSTOMERNOTIFICATION.sql
  Author:      siturrioz
  Date:        12/02/2019
  Purpose:     Delete entries to the table.  
*****************************************************************************
*
* Delete batch job entries t_batch_job
*
*****************************************************************************/

DECLARE
    v_count NUMBER := 0;

BEGIN

    SELECT COUNT(1)
      INTO v_count
      FROM t_batch_job t
     WHERE t.job_name = 'DigitalFormFailuresCustomerNotificationJob';

    IF v_count = 1 THEN
    
        DELETE FROM T_BATCH_JOB t
         WHERE t.job_name = 'DigitalFormFailuresCustomerNotificationJob';
    
    END IF;

    DBMS_OUTPUT.PUT_LINE('Delete DigitalFormFailuresCustomerNotificationJob SUCCESSFUL on T_BATCH_JOB');
    COMMIT;



EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        raise_application_error(-20001,
                                'IT-335 FAILED to rollback DigitalFormFailuresCustomerNotificationJob insert into T_BATCH_JOB. Exception: ' ||
                                 SQLERRM);
    
END;
/
