CREATE OR REPLACE PACKAGE PKG_FORM_SUBMISSION_P AS

    TYPE t_form_submission_ref_cursor IS REF CURSOR;

    /**************************VERSION CONTROL LOG*****************************
    *
    * DATE          AccuRev Version      WHO                  Comments
    * 03/01/2019    IT-335               CAROLINA ARDURA      Initial creation
    
    ***************************VERSION CONTROL LOG******************************/

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FORM_SUBMISSION_INSERT
    *  Created:     03/01/2019
    *  Author:
    *
    *  Description:  Inserts into the table T_DIGITAL_FORM_SUBMISSION.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  03/01/2019   IT-335              JULIAN GUTIERREZ      Initial creation
    ******************************************************************************/
    PROCEDURE PR_FORM_SUBMISSION_INSERT(p_credit_account_id    IN T_DIGITAL_FORM_SUBMISSION.CREDIT_ACCOUNT_ID%TYPE,
                                        p_form_name            IN T_DIGITAL_FORM_SUBMISSION.FORM_NAME%TYPE,
                                        p_created              IN T_DIGITAL_FORM_SUBMISSION.CREATED_DATE%TYPE,
                                        p_status               IN T_DIGITAL_FORM_SUBMISSION.STATUS%TYPE,
                                        p_external_case_number IN T_DIGITAL_FORM_SUBMISSION.EXTERNAL_CASE_NUMBER%TYPE,
                                        p_form_submission_id   OUT T_DIGITAL_FORM_SUBMISSION.FORM_SUBMISSION_ID%TYPE);

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FORM_SUBMISSION_UPDATE
    *  Created:     03/01/2019
    *  Author:
    *
    *  Description:  Updates the table T_DIGITAL_FORM_SUBMISSION.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  03/01/2019   IT-335              JULIAN GUTIERREZ      Initial creation
    ******************************************************************************/
    PROCEDURE PR_FORM_SUBMISSION_UPDATE(p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION.FORM_SUBMISSION_ID%TYPE,
                                        p_status             IN T_DIGITAL_FORM_SUBMISSION.STATUS%TYPE,
                                        p_modified           IN T_DIGITAL_FORM_SUBMISSION.MODIFIED_DATE%TYPE,
                                        p_external_case_number IN T_DIGITAL_FORM_SUBMISSION.EXTERNAL_CASE_NUMBER%TYPE);

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_GET_BY_CREDIT_ACCOUNT
    *  Created:     04/05/2019
    *  Author:
    *
    *  Description:  Gets the forms by credit account.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  04/05/2019   IT-335              CARLOS MENDOZA      Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_BY_CREDIT_ACCOUNT(p_credit_account_id IN T_DIGITAL_FORM_SUBMISSION.CREDIT_ACCOUNT_ID%TYPE,
                                       p_result            OUT t_form_submission_ref_cursor);


    /******************************************************************************
    *  Title:        PR_FORM_SUBMISSION_HISTORY_INSERT
    *  Created:      01/22/2020
    *  Author:       siturrioz
    *
    *  Description: Insert a Form Submission History
    *
    *  Modifications:
    *    Date            Who                    Description
    *    
    ******************************************************************************/
    PROCEDURE PR_FORM_SUBMISSION_HISTORY_INSERT(
          p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_ID%TYPE,  
          p_created_date IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CREATED_DATE%TYPE,  
          p_status IN T_DIGITAL_FORM_SUBMISSION_HISTORY.STATUS%TYPE,  
          p_captured_data IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CAPTURED_DATA%TYPE,  
          p_sanitized_files IN T_DIGITAL_FORM_SUBMISSION_HISTORY.SANITIZED_FILES%TYPE,            
          p_action IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ACTION%TYPE,            
          p_error_details IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ERROR_DETAILS%TYPE,                       
          p_recovered IN T_DIGITAL_FORM_SUBMISSION_HISTORY.RECOVERED%TYPE,                                 
          p_form_submission_history_id OUT T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_HISTORY_ID%TYPE
          );  
          
    /******************************************************************************
    *  Title:        PR_FORM_SUBMISSION_HISTORY_UPDATE
    *  Created:      01/22/2020
    *  Author:       siturrioz
    *
    *  Description: Update Form Submission History
    *
    *  Modifications:
    *    Date            Who                    Description
    *    
    ******************************************************************************/
    PROCEDURE PR_FORM_SUBMISSION_HISTORY_UPDATE(p_form_submission_history_id IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_HISTORY_ID%TYPE,  
          p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_ID%TYPE,  
          p_created_date IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CREATED_DATE%TYPE,  
          p_status IN T_DIGITAL_FORM_SUBMISSION_HISTORY.STATUS%TYPE,  
          p_captured_data IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CAPTURED_DATA%TYPE,
          p_sanitized_files IN T_DIGITAL_FORM_SUBMISSION_HISTORY.SANITIZED_FILES%TYPE,
          p_action IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ACTION%TYPE,
          p_error_details IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ERROR_DETAILS%TYPE,
          p_recovered IN T_DIGITAL_FORM_SUBMISSION_HISTORY.RECOVERED%TYPE          
            );  

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FAILURES_FOR_DATE_PERIOD
    *  Created:     10/24/2019
    *  Author:
    *
    *  Description:  Get the form submissions failures from the table T_DIGITAL_FORM_SUBMISSION_HISTORY.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  10/24/2019   IT-335              CARLOS MENDOZA        Initial creation
    ******************************************************************************/
    PROCEDURE PR_FAILURES_FOR_DATE_PERIOD(p_start_date IN DATE,
                                          p_end_date   IN DATE,
                                          p_result     OUT t_form_submission_ref_cursor);

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_GET_SUBMITTED_FORMS_FOR_DATE
    *  Created:     10/24/2019
    *  Author:
    *
    *  Description:  Get the submitted forms from the table T_DIGITAL_FORM_SUBMISSION_HISTORY.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  10/24/2019   IT-335              CARLOS MENDOZA        Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_SUBMITTED_FORMS_FOR_DATE(p_process_date IN DATE,
                                              p_result       OUT t_form_submission_ref_cursor);
                        
  /******************************************************************************
    *
    *  Title:       PKG_FORM_SUBMISSION_P.PR_FAILURES_FOR_DATE
    *  Created:     11/20/2019
    *  Author:
    *
    *  Description:  Get the form submissions failures from the table T_DIGITAL_FORM_SUBMISSION_HISTORY have not been completed for a date.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  11/20/2019   IT-335              CARLOS MENDOZA        Initial creation
    ******************************************************************************/
    PROCEDURE PR_FAILURES_FOR_DATE(p_date IN DATE,
                                          p_result     OUT t_form_submission_ref_cursor);
                      
  /******************************************************************************
    *
    *  Title:       PKG_FORM_SUBMISSION_P.PR_GET_FS_BY_ID
    *  Created:     11/20/2019
    *  Author:
    *
    *  Description:  Gets a form submission by id.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  11/20/2019   IT-335              CARLOS MENDOZA      Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_FS_BY_ID(p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION.FORM_SUBMISSION_ID%TYPE,
                                       p_result            OUT t_form_submission_ref_cursor);

  /******************************************************************************
    *
    *  Title:       PKG_FORM_SUBMISSION_P.PR_GET_PENDING_NOTIFICATION_FAILURES
    *  Created:     11/28/2019
    *  Author:
    *
    *  Description:  Gets a list of Form Submissions pending to notify the customer
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  11/28/2019   IT-335              SEBASTIAN ITURRIOZ      Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_PENDING_NOTIFICATION_FAILURES(p_date IN DATE,
      p_result     OUT t_form_submission_ref_cursor);                     
    
    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FORMHISTORY_BY_ID
    *  Created:     12/06/2019
    *  Author:
    *
    *  Description:  Gets a form submissions history by id from the table T_DIGITAL_FORM_SUBMISSION_HISTORY.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  12/06/2019   IT-335              LAURA BOF             Initial creation
    ******************************************************************************/
    PROCEDURE PR_FORMHISTORY_BY_ID(p_form_history_id   IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_HISTORY_ID%TYPE,
                                          p_result     OUT t_form_submission_ref_cursor);
    
    
END PKG_FORM_SUBMISSION_P;
/
CREATE OR REPLACE PACKAGE BODY PKG_FORM_SUBMISSION_P AS
    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FORM_SUBMISSION_INSERT
    *  Created:     03/01/2019
    *  Author:
    *
    *  Description:  Inserts into the table T_DIGITAL_FORM_SUBMISSION.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  03/01/2019   IT-335              JULIAN GUTIERREZ      Initial creation
    ******************************************************************************/

    PROCEDURE PR_FORM_SUBMISSION_INSERT(p_credit_account_id  IN T_DIGITAL_FORM_SUBMISSION.CREDIT_ACCOUNT_ID%TYPE,
                                        p_form_name          IN T_DIGITAL_FORM_SUBMISSION.FORM_NAME%TYPE,
                                        p_created            IN T_DIGITAL_FORM_SUBMISSION.CREATED_DATE%TYPE,
                                        p_status             IN T_DIGITAL_FORM_SUBMISSION.STATUS%TYPE,
                                        p_external_case_number  IN T_DIGITAL_FORM_SUBMISSION.EXTERNAL_CASE_NUMBER%TYPE,
                                        p_form_submission_id OUT T_DIGITAL_FORM_SUBMISSION.FORM_SUBMISSION_ID%TYPE) IS
    BEGIN
        -- Insert
        INSERT INTO T_DIGITAL_FORM_SUBMISSION
            (FORM_SUBMISSION_ID,
             FORM_NAME,
             CREDIT_ACCOUNT_ID,
       CREATED_DATE,
       STATUS,
       EXTERNAL_CASE_NUMBER)
        VALUES
            (SEQ_DIGITAL_FORM_SUBMISSION.NEXTVAL,
             p_form_name,
             p_credit_account_id,
             p_created,
       p_status,
       p_external_case_number)
        RETURNING FORM_SUBMISSION_ID INTO p_form_submission_id;
    
        COMMIT;
    END PR_FORM_SUBMISSION_INSERT;

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FORM_SUBMISSION_UPDATE
    *  Created:     03/01/2019
    *  Author:
    *
    *  Description:  Updates the table T_DIGITAL_FORM_SUBMISSION.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  03/01/2019   IT-335              JULIAN GUTIERREZ      Initial creation
    ******************************************************************************/
    PROCEDURE PR_FORM_SUBMISSION_UPDATE(p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION.FORM_SUBMISSION_ID%TYPE,
                                        p_status             IN T_DIGITAL_FORM_SUBMISSION.STATUS%TYPE,
                                        p_modified           IN T_DIGITAL_FORM_SUBMISSION.MODIFIED_DATE%TYPE,
                                        p_external_case_number IN T_DIGITAL_FORM_SUBMISSION.EXTERNAL_CASE_NUMBER%TYPE) IS
    BEGIN
        UPDATE T_DIGITAL_FORM_SUBMISSION
           SET STATUS         = p_status,
               MODIFIED_DATE     = p_modified,
               EXTERNAL_CASE_NUMBER = p_external_case_number
         WHERE FORM_SUBMISSION_ID = p_form_submission_id;
    
        COMMIT;
    END PR_FORM_SUBMISSION_UPDATE;

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_GET_BY_CREDIT_ACCOUNT
    *  Created:     04/05/2019
    *  Author:
    *
    *  Description:  Gets the forms by credit account.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  04/05/2019   IT-335              CARLOS MENDOZA      Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_BY_CREDIT_ACCOUNT(p_credit_account_id IN T_DIGITAL_FORM_SUBMISSION.CREDIT_ACCOUNT_ID%TYPE,
                                       p_result            OUT t_form_submission_ref_cursor) IS
    BEGIN
        OPEN p_result FOR
            SELECT fs.FORM_NAME,
                   FORM_SUBMISSION_ID,
                   STATUS,
                   CREATED_DATE,
                   MODIFIED_DATE,
                   CREDIT_ACCOUNT_ID,
                   EXTERNAL_CASE_NUMBER,
      dfd.FORM_DESC
              FROM T_DIGITAL_FORM_SUBMISSION fs
              INNER JOIN T_LU_DIGITAL_FORM_DESCRIPTION dfd ON fs.FORM_NAME = dfd.FORM_NAME
             WHERE CREDIT_ACCOUNT_ID = p_credit_account_id
       ORDER BY CREATED_DATE DESC;
    END PR_GET_BY_CREDIT_ACCOUNT;

    /******************************************************************************
    *  Title:        PR_INSERT_FORM_SUBMISSION_HISTORY
    *  Created:      01/22/2020
    *  Author:       siturrioz
    *
    *  Description: Inserts a Form Submission History
    *
    *  Modifications:
    *    Date            Who                    Description
    *    
    ******************************************************************************/
  PROCEDURE PR_FORM_SUBMISSION_HISTORY_INSERT( 
        P_FORM_SUBMISSION_ID IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_ID%TYPE,  
        P_CREATED_DATE IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CREATED_DATE%TYPE,  
        P_STATUS IN T_DIGITAL_FORM_SUBMISSION_HISTORY.STATUS%TYPE,  
        P_CAPTURED_DATA IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CAPTURED_DATA%TYPE,  
        P_SANITIZED_FILES IN T_DIGITAL_FORM_SUBMISSION_HISTORY.SANITIZED_FILES%TYPE,          
        P_ACTION IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ACTION%TYPE,            
        P_ERROR_DETAILS IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ERROR_DETAILS%TYPE,                               
        P_RECOVERED IN T_DIGITAL_FORM_SUBMISSION_HISTORY.RECOVERED%TYPE,
        P_FORM_SUBMISSION_HISTORY_ID OUT T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_HISTORY_ID%TYPE
          ) IS

    BEGIN
          
          INSERT INTO T_DIGITAL_FORM_SUBMISSION_HISTORY
          (   FORM_SUBMISSION_HISTORY_ID,
              FORM_SUBMISSION_ID,
              CREATED_DATE,
              STATUS,
              CAPTURED_DATA,
              SANITIZED_FILES,
              ACTION,
              RECOVERED,
              ERROR_DETAILS
        )
          VALUES
          (   SEQ_DIGITAL_FORM_SUBMISSION_HISTORY.nextval,
              p_form_submission_id,
              p_created_date,
              p_status,
              p_captured_data,
              p_sanitized_files,
              p_action,
              p_recovered,
              p_error_details)
          RETURNING FORM_SUBMISSION_HISTORY_ID INTO p_form_submission_history_id;

          COMMIT;             

  END PR_FORM_SUBMISSION_HISTORY_INSERT;

  /******************************************************************************
  *  Title:        PR_FORM_SUBMISSION_HISTORY_UPDATE
  *  Created:      01/22/2020
  *  Author:       siturrioz
  *
  *  Description: Update Form Submission History
  *
  *  Modifications:
  *    Date            Who                    Description
  *    
  ******************************************************************************/
  PROCEDURE PR_FORM_SUBMISSION_HISTORY_UPDATE(      p_form_submission_history_id IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_HISTORY_ID%TYPE,  
        p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_ID%TYPE,  
        p_created_date IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CREATED_DATE%TYPE,  
        p_status IN T_DIGITAL_FORM_SUBMISSION_HISTORY.STATUS%TYPE,  
        p_captured_data IN T_DIGITAL_FORM_SUBMISSION_HISTORY.CAPTURED_DATA%TYPE,
        p_sanitized_files IN T_DIGITAL_FORM_SUBMISSION_HISTORY.SANITIZED_FILES%TYPE,
        p_action IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ACTION%TYPE,
        p_error_details IN T_DIGITAL_FORM_SUBMISSION_HISTORY.ERROR_DETAILS%TYPE,
        p_recovered IN T_DIGITAL_FORM_SUBMISSION_HISTORY.RECOVERED%TYPE        
          ) IS

    BEGIN
        
        UPDATE T_DIGITAL_FORM_SUBMISSION_HISTORY T
           SET  T.FORM_SUBMISSION_HISTORY_ID = p_form_submission_history_id,
                T.FORM_SUBMISSION_ID = p_form_submission_id,
                T.CREATED_DATE = p_created_date,
                T.STATUS = p_status,
                T.CAPTURED_DATA = p_captured_data,
                T.SANITIZED_FILES = p_sanitized_files,
                T.ACTION = p_action,
                T.RECOVERED = p_recovered,
                T.ERROR_DETAILS = p_error_details
      WHERE T.FORM_SUBMISSION_HISTORY_ID = p_form_submission_history_id;

        COMMIT;

    END PR_FORM_SUBMISSION_HISTORY_UPDATE;  
  
  /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FAILURES_FOR_DATE_PERIOD
    *  Created:     10/24/2019
    *  Author:
    *
    *  Description:  Get the form submissions failures from the table T_DIGITAL_FORM_SUBMISSION_HISTORY.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  10/24/2019   IT-335              CARLOS MENDOZA        Initial creation
    ******************************************************************************/
    PROCEDURE PR_FAILURES_FOR_DATE_PERIOD(p_start_date IN DATE,
                                          p_end_date   IN DATE,
                                          p_result     OUT t_form_submission_ref_cursor) IS
    BEGIN
        OPEN p_result FOR
            SELECT fsh.CREATED_DATE,
                   dfd.FORM_DESC AS form_name,
                   fs.CREDIT_ACCOUNT_ID,
                   fsh.ERROR_DETAILS,
                   fsh.STATUS
              FROM T_DIGITAL_FORM_SUBMISSION_HISTORY fsh
             INNER JOIN T_DIGITAL_FORM_SUBMISSION fs
                ON fsh.FORM_SUBMISSION_ID = fs.FORM_SUBMISSION_ID
             INNER JOIN T_LU_DIGITAL_FORM_DESCRIPTION dfd
                ON dfd.FORM_NAME = fs.FORM_NAME
             WHERE fsh.STATUS <> 'Completed'
               AND trunc(fsh.CREATED_DATE) BETWEEN p_start_date AND
                   p_end_date;
    END PR_FAILURES_FOR_DATE_PERIOD;

    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_GET_SUBMITTED_FORMS_FOR_DATE
    *  Created:     10/24/2019
    *  Author:
    *
    *  Description:  Get the submitted forms from the table T_DIGITAL_FORM_SUBMISSION_HISTORY.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  10/24/2019   IT-335              CARLOS MENDOZA        Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_SUBMITTED_FORMS_FOR_DATE(p_process_date IN DATE,
                                              p_result       OUT t_form_submission_ref_cursor) IS
        beginMonthDateTime DATE;
        beginYearDateTime  DATE;
        endDateTime        DATE;
        process_date       DATE := trunc(p_process_date);
    BEGIN
        IF to_char(process_date, 'D') = '1' THEN
            process_date := process_date - INTERVAL '2' DAY;
        END IF;
        beginMonthDateTime := trunc(process_date, 'MONTH');
        beginYearDateTime  := trunc(process_date, 'YEAR');
        endDateTime        := trunc(process_date + 1) - INTERVAL '1' SECOND;
    
    
        OPEN p_result FOR
            WITH all_submissions AS
             (SELECT a.form_name,
                     trunc(b.created_date) AS created_date
                FROM T_DIGITAL_FORM_SUBMISSION_HISTORY b
               INNER JOIN T_DIGITAL_FORM_SUBMISSION a
                  ON b.FORM_SUBMISSION_ID = a.FORM_SUBMISSION_ID
               WHERE trunc(b.created_date) BETWEEN beginYearDateTime AND
                     endDateTime)
            SELECT dfd.FORM_DESC as form_name,
                   SUM(CASE
                           WHEN f.created_date = process_date THEN
                            1
                           ELSE
                            0
                       END) AS daily,
                   SUM(CASE
                           WHEN f.created_date BETWEEN beginMonthDateTime AND
                                endDateTime THEN
                            1
                           ELSE
                            0
                       END) AS monthly,
                   SUM(1) AS yearly
              FROM T_LU_DIGITAL_FORM_DESCRIPTION dfd
             INNER JOIN all_submissions f
                ON f.form_name = dfd.form_name
             GROUP BY dfd.FORM_DESC
             ORDER BY dfd.FORM_DESC;
    
    
    END PR_GET_SUBMITTED_FORMS_FOR_DATE;

    /******************************************************************************
    *
    *  Title:       PKG_FORM_SUBMISSION_P.PR_FAILURES_DATE
    *  Created:     11/20/2019
    *  Author:
    *
    *  Description:  Get the form submissions failures from the table T_DIGITAL_FORM_SUBMISSION_HISTORY have not been completed for a date.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  11/20/2019   IT-335              CARLOS MENDOZA        Initial creation
    ******************************************************************************/
    PROCEDURE PR_FAILURES_FOR_DATE(p_date IN DATE,
                                          p_result     OUT t_form_submission_ref_cursor) IS
    BEGIN
  
      OPEN p_result FOR
            SELECT FORM_SUBMISSION_HISTORY_ID,
             FORM_SUBMISSION_ID,
                   CREATED_DATE,
           CAPTURED_DATA,
           SANITIZED_FILES,
           ACTION,
                   ERROR_DETAILS,
                   STATUS
            FROM T_DIGITAL_FORM_SUBMISSION_HISTORY
            WHERE (STATUS = 'CompletedPartially' OR
                   STATUS = 'CompletedPartiallyRejectedFiles' OR
                   STATUS = 'NotificationPending')
               AND trunc(CREATED_DATE) = trunc(NVL(p_date, CREATED_DATE))
      ORDER BY CREATED_DATE DESC;
  END PR_FAILURES_FOR_DATE; 

    /******************************************************************************
    *
    *  Title:       PKG_FORM_SUBMISSION_P.PR_GET_FS_BY_ID
    *  Created:     11/20/2019
    *  Author:
    *
    *  Description:  Gets a form submission by id.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  11/20/2019   IT-335              CARLOS MENDOZA      Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_FS_BY_ID(p_form_submission_id IN T_DIGITAL_FORM_SUBMISSION.FORM_SUBMISSION_ID%TYPE,
                                       p_result            OUT t_form_submission_ref_cursor) IS
    BEGIN
    OPEN p_result FOR
            SELECT fs.FORM_NAME,
                   FORM_SUBMISSION_ID,
                   STATUS,
                   CREATED_DATE,
                   MODIFIED_DATE,
                   CREDIT_ACCOUNT_ID,
                   EXTERNAL_CASE_NUMBER,
                   dfd.FORM_DESC
             FROM T_DIGITAL_FORM_SUBMISSION fs
             INNER JOIN T_LU_DIGITAL_FORM_DESCRIPTION dfd ON fs.FORM_NAME = dfd.FORM_NAME
             WHERE FORM_SUBMISSION_ID = p_form_submission_id
       ORDER BY CREATED_DATE DESC;
    END PR_GET_FS_BY_ID;


    /******************************************************************************
    *
    *  Title:       PKG_FORM_SUBMISSION_P.PR_GET_PENDING_NOTIFICATION_FAILURES
    *  Created:     12/02/2019
    *  Author:
    *
    *  Description:  Get the list of records in PendingNotification
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  12/02/2019   IT-335              SEBASTIAN ITURRIOZ      Initial creation
    ******************************************************************************/
    PROCEDURE PR_GET_PENDING_NOTIFICATION_FAILURES(p_date IN DATE,
                                       p_result            OUT t_form_submission_ref_cursor) IS
    BEGIN
      OPEN p_result FOR
            SELECT DFSH.FORM_SUBMISSION_HISTORY_ID,
             DFS.FORM_SUBMISSION_ID,
             DFSH.CREATED_DATE,
             DFSH.ACTION,
             DFSH.STATUS,
             DFS.CREDIT_ACCOUNT_ID,
             DFSH.CAPTURED_DATA,
             DFSH.SANITIZED_FILES,
             DFSH.ERROR_DETAILS,
             DFSH.RECOVERED
             FROM T_DIGITAL_FORM_SUBMISSION_HISTORY DFSH
             JOIN T_DIGITAL_FORM_SUBMISSION DFS ON DFS.FORM_SUBMISSION_ID = DFSH.FORM_SUBMISSION_ID
             WHERE (DFSH.status = 'NotificationPending'
                  OR (DFSH.status <> 'CustomerNotified' 
                     AND DFSH.status <> 'Completed'
                     AND DFSH.status <> 'FailedUnrecoverableData'))                 
                  AND trunc(DFSH.CREATED_DATE) < trunc(NVL(p_date, DFSH.CREATED_DATE))
                  AND trunc(DFSH.CREATED_DATE) >= (SYSDATE-30)
      ORDER BY CREATED_DATE DESC;     
    END PR_GET_PENDING_NOTIFICATION_FAILURES;
 
    /******************************************************************************
    *
    *  Title:       ACCOUNT.PKG_FORM_SUBMISSION_P.PR_FORMHISTORY_BY_ID
    *  Created:     12/06/2019
    *  Author:
    *
    *  Description:  Gets a form submissions history by id from the table T_DIGITAL_FORM_SUBMISSION_HISTORY.
    *
    *
    *  DATE         AccuRev Version     WHO                   Comments
    *  12/06/2019   IT-335              LAURA BOF             Initial creation
    ******************************************************************************/
    PROCEDURE PR_FORMHISTORY_BY_ID(p_form_history_id   IN T_DIGITAL_FORM_SUBMISSION_HISTORY.FORM_SUBMISSION_HISTORY_ID%TYPE,
                                          p_result     OUT t_form_submission_ref_cursor) IS
    BEGIN
        OPEN p_result FOR
            SELECT FORM_SUBMISSION_HISTORY_ID,
       FORM_SUBMISSION_ID,
                   CREATED_DATE,
       STATUS,
       CAPTURED_DATA,
       SANITIZED_FILES,
                   ERROR_DETAILS,
                   ACTION,
                   RECOVERED
              FROM T_DIGITAL_FORM_SUBMISSION_HISTORY
              WHERE form_submission_history_id = p_form_history_id;
    END PR_FORMHISTORY_BY_ID;

END PKG_FORM_SUBMISSION_P;
/
GRANT EXECUTE ON PKG_FORM_SUBMISSION_P TO RPTSRVC;
GRANT EXECUTE ON PKG_FORM_SUBMISSION_P TO BATCH;
