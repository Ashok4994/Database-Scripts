DECLARE  
  V_COUNT                           NUMBER;
  V_TABLE                           VARCHAR2(500);
  V_FORM_NAME                       T_LU_DIGITAL_FORM_DESCRIPTION.FORM_NAME%TYPE;
  
  TYPE T_FORM_NAMES IS VARRAY(6) OF T_LU_DIGITAL_FORM_DESCRIPTION.FORM_NAME%TYPE;
  TYPE T_DESCRIPTIONS is VARRAY(6) OF VARCHAR2(100);
  
  A_FORM_NAMES T_FORM_NAMES := 
    T_FORM_NAMES(
         'NAME_CHANGE',
         'POWER_OF_ATTORNEY',
         'MILITARY_SCRA',
         'PAYMENT_VERIFICATION_LETTER',
         'IDENTIFICATION_DOCUMENTS',
         'CS_INQUIRIES'         
  );
  
  A_DESCRIPTIONS T_DESCRIPTIONS := 
    T_DESCRIPTIONS(
      'Name Change Request',
	  'Power of Attorney Request',
	  'Service Members Civil Relief Act Request',
	  'Payment Verification',
	  'Identification Verification',
	  'All Other Inquiries'
	  );
  
BEGIN
  
  FOR FN_INDEX in 1..A_FORM_NAMES.COUNT LOOP   

       --Insert in table T_LU_DIGITAL_FORM_DESCRIPTION
       V_TABLE := 'T_LU_DIGITAL_FORM_DESCRIPTION';
       
       -- Check if record already exists
       SELECT   COUNT(1)
       INTO     V_COUNT
       FROM     T_LU_DIGITAL_FORM_DESCRIPTION 
       WHERE    FORM_NAME = A_FORM_NAMES(FN_INDEX);
                          
       IF V_COUNT = 0 THEN
          INSERT INTO T_LU_DIGITAL_FORM_DESCRIPTION
              (FORM_NAME
              ,FORM_DESC)
              VALUES
              (A_FORM_NAMES(FN_INDEX),
			  A_DESCRIPTIONS(FN_INDEX))
          RETURNING FORM_NAME INTO V_FORM_NAME;
    	  
          DBMS_OUTPUT.PUT_LINE('A record with name ''' || A_FORM_NAMES(FN_INDEX) || ''' and description ''' || A_DESCRIPTIONS(FN_INDEX) || ''' in ' || V_TABLE || ' table did not exist. The record was created.');
       ELSE    	   
          DBMS_OUTPUT.PUT_LINE('A record with name ''' || A_FORM_NAMES(FN_INDEX) || ''' and description ''' || A_DESCRIPTIONS(FN_INDEX) || ''' in ' || V_TABLE || ' table already exists. No data was changed.');
       END IF;
   
   END LOOP;
   
  COMMIT;
  
END;

/
      
