/*
  Script:      DEL_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION_PARAMS.sql
  Author:      siturrioz
  Date:        12/03/2019
  Purpose:     Delete entries to the table.  
*****************************************************************************
*
* Delete batch job entries t_batch_job_params
*
*****************************************************************************/

DECLARE
    v_count  NUMBER := 0;
    v_job_id NUMBER;
BEGIN

    SELECT job_id
      INTO v_job_id
      FROM t_batch_job t
     WHERE t.job_name = 'DigitalFormFailuresInternalNotificationJob';

    SELECT COUNT(1)
      INTO v_count
      FROM T_BATCH_JOB_PARMS t
     WHERE t.job_id = v_job_id;

    IF v_count > 0 THEN
    
        DELETE FROM T_BATCH_JOB_PARMS t
         WHERE t.job_id = v_job_id;
    
    END IF;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        NULL;
    
        DBMS_OUTPUT.PUT_LINE('Delete DigitalFormFailuresInternalNotificationJob parameters SUCCESSFUL on T_BATCH_JOB_PARMS');
END;
/
