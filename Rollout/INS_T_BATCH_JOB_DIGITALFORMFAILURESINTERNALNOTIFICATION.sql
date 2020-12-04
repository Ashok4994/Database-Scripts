/*
  Script:      INS_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION.sql
  Author:      siturrioz
  Date:        12/02/2019
  Purpose:     Add entries to the table.  
*****************************************************************************
*
* Inserts batch job entries to t_batch_job
*
*****************************************************************************/

DECLARE
    v_count NUMBER := 0;
BEGIN
    -- DIGITALFORMFAILURESINTERNALNOTIFICATION job creation
    SELECT COUNT(1)
      INTO v_count
      FROM t_batch_job t
     WHERE t.job_name = 'DigitalFormFailuresInternalNotificationJob';

    IF v_count = 0 THEN
    
        INSERT INTO T_BATCH_JOB
            (JOB_ID,
             JOB_NAME,
             JOB_ASSEMBLY_NAME,
             JOB_ASSEMBLY_TYPE,
             JOB_ID_DESCRIPTION,
             JOB_ACTIVE_IND,
             JOB_STEP_RESTART_ID,
             JOB_STEP_LAST_RUN_IDX)
        VALUES
            (Batch_Job_Seq.nextval,
             'DigitalFormFailuresInternalNotificationJob',
             'CreditOne.Batch.DigitalFormSubmission.dll',
             'CreditOne.Batch.DigitalFormSubmission.DigitalFormFailuresInternalNotificationJob',
             'Job to generate an internal notification in case of form submissions failures',
             'Y',
             -1,
             -1);
    
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Insert DigitalFormFailuresInternalNotificationJpb SUCCESSFUL on T_BATCH_JOB');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        raise_application_error(-20001,
                                'IT-335 FAILED to insert DigitalFormFailuresInternalNotificationJob into T_BATCH_JOB. Exception: ' ||
                                 SQLERRM);
END;
/
