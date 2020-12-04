/*
  Script:      INS_T_BATCH_JOB_DIGITALFORMFAILURESINTERNALNOTIFICATION_PARMS.sql
  Schema:      BATCH
  Author:      siturrioz
  Date:        12/02/2019
  Purpose:     Insert params for jobs
*/
DECLARE

  v_user_env     VARCHAR2(500);
  v_subject_env   VARCHAR2(250);
  
    TYPE param_rec IS RECORD(
        param_key   T_BATCH_JOB_PARMS.parm_key%TYPE,
        param_value T_BATCH_JOB_PARMS.parm_value%TYPE,
        param_desc  T_BATCH_JOB_PARMS.parm_desc%TYPE);

    TYPE param_rec_t IS TABLE OF param_rec INDEX BY PLS_INTEGER;
    v_params param_rec_t;
    v_job_id NUMBER;
    v_count  NUMBER;

BEGIN

    SELECT SYS_CONTEXT('USERENV', 'INSTANCE_NAME')
      INTO v_user_env
      FROM dual;

    CASE v_user_env
        WHEN 'casdev02' THEN
            v_subject_env := 'Dev02';
        WHEN 'casts01' THEN
            v_subject_env := 'Test01';
        WHEN 'casts02' THEN
            v_subject_env := 'Test02';
        WHEN 'casts03' THEN
            v_subject_env := 'Test03';
        WHEN 'casts04' THEN
            v_subject_env := 'Test04';
        WHEN 'casts05' THEN
            v_subject_env := 'Test05';
        WHEN 'casts06' THEN
            v_subject_env := 'Test06';
        WHEN 'casts07' THEN
            v_subject_env := 'Test07';
        WHEN 'casts08' THEN
            v_subject_env := 'Test08';
        WHEN 'casts09' THEN
            v_subject_env := 'Test09';
        WHEN 'cashf01' THEN
            v_subject_env := 'Hf01';
        WHEN 'casrl01' THEN
            v_subject_env := 'Rl01';
        WHEN 'castr01' THEN
            v_subject_env := 'Tr01';
        WHEN 'casstg01' THEN
            v_subject_env := 'Stg01';
        WHEN 'casn01' THEN
            v_subject_env := 'Prod';
		WHEN 'cas' THEN
            v_subject_env := 'Prod';
        ELSE
            RAISE_APPLICATION_ERROR(-20002,
                                    'Invalid Database environment ' ||
                                     v_user_env);
    END CASE;
    
    SELECT JOB_ID
      INTO v_job_id
      FROM T_BATCH_JOB T
     WHERE T.JOB_NAME = 'DigitalFormFailuresInternalNotificationJob';

    v_params(1).param_key := 'DigitalFormFailuresInternalNotificationEmailTo';
    v_params(1).param_desc := 'Email recipient if any failure is found';
    v_params(1).param_value := 'NOC@creditone.com';
    
    v_params(2).param_key := 'DigitalFormFailuresInternalNotificationEmailFrom';
    v_params(2).param_desc := 'Email sender for job Error';
    v_params(2).param_value := 'digital.form.job@creditone.com';
    
    v_params(3).param_key := 'DigitalFormFailuresInternalNotificationEmailSubject';
    v_params(3).param_desc := 'Email subject for job Error';
    v_params(3).param_value := '['|| UPPER(v_subject_env) ||'] Digital Form Errors';
    
    v_params(4).param_key := 'DigitalFormFailuresInternalNotificationSpecialExecutionDate';
    v_params(4).param_desc := 'If not null it will be used as execution date';
    v_params(4).param_value := 'NONE';


    FOR i IN v_params.first .. v_params.last
    LOOP
    
        SELECT COUNT(1)
          INTO v_count
          FROM T_BATCH_JOB_PARMS
         WHERE JOB_ID = v_job_id
           AND PARM_KEY = v_params(i).param_key;
    
        IF v_count = 0 THEN
          DBMS_OUTPUT.PUT_LINE('Insert DigitalFormFailuresInternalNotificationJob Param' ||  v_params(i).param_key );
            INSERT INTO T_BATCH_JOB_PARMS
                (PARM_ID,
                 JOB_ID,
                 PARM_KEY,
                 PARM_VALUE,
                 PARM_DESC)
            VALUES
                (BATCH_JOB_PARM_SEQ.NEXTVAL,
                 v_job_id,
                 v_params(i).param_key,
                 v_params(i).param_value,
                 v_params(i).param_desc);
        END IF;
    
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Insert DigitalFormFailuresInternalNotificationJob parameters SUCCESSFUL on T_BATCH_JOB_PARMS');
END;
/
