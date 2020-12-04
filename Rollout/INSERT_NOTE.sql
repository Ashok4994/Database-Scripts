DECLARE  
  V_COUNT                           NUMBER;
  V_TABLE                           VARCHAR2(500);
  V_WEB_MESSAGE_TYPE_ID             T_LU_WEB_MESSAGE_TYPE.WEB_MESSAGE_TYPE_ID%TYPE := -1;
  
  TYPE T_MESSAGE_TYPE IS VARRAY(7) OF T_LU_WEB_MESSAGE_TYPE.WEB_MESSAGE_TYPE%TYPE;
  TYPE T_MESSAGES is VARRAY(7) OF VARCHAR2(512);
  
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
  
  A_MESSAGES T_MESSAGES := 
    T_MESSAGES(
      'Your Name Change Request form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Power of Attorney Request form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Military Service Members Civil Relief Act (SCRA) form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Payment Verification form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your Identity Verification form was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'Your inquiry was submitted, and has been assigned Case Number: {0}. You may view your case history by selecting the ''Case History'' tab on the main ''Forms ' || chr(38) || ' File Uploads'' page <a href=''/transactional/digital-customer-service''><u>here</u></a>.',
      'We were not able to process the form {0} submitted on {1} due to internal problems, please resubmit the form.'      
    );
  
BEGIN
  
  FOR MT_INDEX in 1..A_MESSAGE_TYPES.COUNT LOOP   

       --Insert in table T_LU_WEB_MESSAGE_TYPE
       V_TABLE := 'T_LU_WEB_MESSAGE_TYPE';
       
       -- Check if record already exists
       SELECT   COUNT(1)
       INTO     V_COUNT
       FROM     T_LU_WEB_MESSAGE_TYPE 
       WHERE    WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);
                          
       IF V_COUNT = 0 THEN
          INSERT INTO T_LU_WEB_MESSAGE_TYPE
              (WEB_MESSAGE_TYPE_ID
              ,WEB_MESSAGE_TYPE)
              VALUES
              (SEQ_WEB_MESSAGE_TYPE_ID.NEXTVAL
              ,A_MESSAGE_TYPES(MT_INDEX))
          RETURNING WEB_MESSAGE_TYPE_ID INTO V_WEB_MESSAGE_TYPE_ID;
    	  
          DBMS_OUTPUT.PUT_LINE('A record with ' || A_MESSAGE_TYPES(MT_INDEX) || ' code in ' || V_TABLE || ' table did not exist. The record was created.');
       ELSE
         SELECT   WEB_MESSAGE_TYPE_ID
         INTO     V_WEB_MESSAGE_TYPE_ID
         FROM     T_LU_WEB_MESSAGE_TYPE 
         WHERE    WEB_MESSAGE_TYPE = A_MESSAGE_TYPES(MT_INDEX);
    	   
          DBMS_OUTPUT.PUT_LINE('A record with ID ' || V_WEB_MESSAGE_TYPE_ID || ' with ' || A_MESSAGE_TYPES(MT_INDEX) || ' code in ' || V_TABLE || ' table already exists. No data was changed.');
       END IF; 
       
       --Insert in table T_WEB_MESSAGE_VERSION
       V_TABLE := 'T_WEB_MESSAGE_VERSION';
       
       -- Check if record already exists
       SELECT   COUNT(1)
       INTO     V_COUNT
       FROM     T_WEB_MESSAGE_VERSION 
       WHERE    WEB_MESSAGE_TYPE_ID = V_WEB_MESSAGE_TYPE_ID;
                          
       IF V_COUNT = 0 THEN
          INSERT INTO T_WEB_MESSAGE_VERSION
            (WEB_MESSAGE_VERSION_ID
            ,WEB_MESSAGE_TYPE_ID
            ,VERSION_ACTIVE
            ,EFFECTIVE_DATE
            ,MESSAGE_TITLE
            ,WEB_MESSAGE
            ,SHOW_AS_ERROR
            ,MESSAGE_DAYS_KEPT)
            VALUES
            (SEQ_WEB_MESSAGE_VERSION_ID.NEXTVAL
            ,V_WEB_MESSAGE_TYPE_ID
            ,'Y'
            ,SYSDATE
            ,'Form Submitted:'
            ,A_MESSAGES(MT_INDEX)
            ,'N'
            ,60);
    	  
          DBMS_OUTPUT.PUT_LINE('A record with ' || V_WEB_MESSAGE_TYPE_ID || ' id in ' || V_TABLE || ' table did not exist. The record was created.');
       ELSE
          DBMS_OUTPUT.PUT_LINE('A record with ' || V_WEB_MESSAGE_TYPE_ID || ' id in ' || V_TABLE || ' table already exists. No data was changed.');
       END IF; 
   
   END LOOP;
   
  COMMIT;
  
END;

/
      
