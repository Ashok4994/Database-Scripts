DECLARE
  V_COUNT                 NUMBER;
  V_TABLE                 VARCHAR2(500);
  V_WEB_MESSAGE_TYPE_ID             T_LU_WEB_MESSAGE_TYPE.WEB_MESSAGE_TYPE_ID%TYPE := -1;
  V_WEB_MESSAGE_VERSION_ID          T_WEB_MESSAGE_VERSION.WEB_MESSAGE_VERSION_ID%TYPE := -1;
  
  TYPE T_MESSAGE_TYPE IS VARRAY(7) OF T_LU_WEB_MESSAGE_TYPE.WEB_MESSAGE_TYPE%TYPE;
  
  A_MESSAGE_TYPES T_MESSAGE_TYPE := 
    T_MESSAGE_TYPE(
         'MsgNameChangeFormSubmissionConfirmation',
         'MsgPowerOfAttorneyFormSubmissionConfirmation',
         'MsgSCRAFormSubmissionConfirmation',
         'MsgPaymentVerificationFormSubmissionConfirmation',
         'MsgIdentityVerificationFormSubmissionConfirmation',
         'MsgOtherInquiriesFormSubmissionConfirmation',
         'MsgFormSubmissionFailure'                  
  );

BEGIN
  
 FOR MT_INDEX in 1..A_MESSAGE_TYPES.COUNT LOOP  

     V_WEB_MESSAGE_TYPE_ID := -1;
     
     -- First, check if the message type record already exists 
     SELECT   COUNT(1)
     INTO     V_COUNT
     FROM     T_LU_WEB_MESSAGE_TYPE 
     WHERE    WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);
     
     IF V_COUNT = 1 THEN

       -- Get the ID, and then the version ID
       SELECT   NVL(WEB_MESSAGE_TYPE_ID,-1)
       INTO     V_WEB_MESSAGE_TYPE_ID
       FROM     T_LU_WEB_MESSAGE_TYPE 
       WHERE    WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);
                 
       SELECT   NVL(WEB_MESSAGE_VERSION_ID,-1)
       INTO     V_WEB_MESSAGE_VERSION_ID
       FROM     T_WEB_MESSAGE_VERSION 
       WHERE    WEB_MESSAGE_TYPE_ID = V_WEB_MESSAGE_TYPE_ID;
                                    
       DECLARE
     
         CURSOR MESSAGE_HISTORY IS
           SELECT   WEB_MESSAGE_HISTORY_ID
           FROM     T_WEB_MESSAGE_HISTORY 
           WHERE    WEB_MESSAGE_VERSION_ID = V_WEB_MESSAGE_VERSION_ID;
           
         V_WEB_MESSAGE_HISTORY_ID          T_WEB_MESSAGE_HISTORY.WEB_MESSAGE_HISTORY_ID%TYPE := -1;

       BEGIN
       
         OPEN MESSAGE_HISTORY;
         LOOP
           
           FETCH MESSAGE_HISTORY INTO V_WEB_MESSAGE_HISTORY_ID;
           EXIT WHEN MESSAGE_HISTORY%NOTFOUND;
           
           -- Delete related records
           DELETE FROM T_WEB_MESSAGE_PARAMS 
           WHERE WEB_MESSAGE_HISTORY_ID = V_WEB_MESSAGE_HISTORY_ID;
             
           DBMS_OUTPUT.PUT_LINE('A record with ' || V_WEB_MESSAGE_HISTORY_ID || ' history id was deleted (Code: ' || A_MESSAGE_TYPES(MT_INDEX));
         
           DELETE FROM T_WEB_MESSAGE_HISTORY 
           WHERE WEB_MESSAGE_HISTORY_ID = V_WEB_MESSAGE_HISTORY_ID;
           
           DBMS_OUTPUT.PUT_LINE('A record with ' || V_WEB_MESSAGE_HISTORY_ID || ' history id was deleted (Code: ' || A_MESSAGE_TYPES(MT_INDEX));
           
         END LOOP;
         
         CLOSE MESSAGE_HISTORY;
         
       END;
     
     DELETE FROM T_WEB_MESSAGE_VERSION 
     WHERE WEB_MESSAGE_VERSION_ID = V_WEB_MESSAGE_VERSION_ID;
     DBMS_OUTPUT.PUT_LINE('A record with ' || V_WEB_MESSAGE_VERSION_ID || ' id was deleted (Code: ' || A_MESSAGE_TYPES(MT_INDEX));

     DELETE FROM T_LU_WEB_MESSAGE_TYPE 
     WHERE WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);    
     DBMS_OUTPUT.PUT_LINE('A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' code in was deleted.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' id not exist');
   END IF;
            
   COMMIT;
     
END LOOP; 

END;

/
      
