*&---------------------------------------------------------------------*
*& Report ZBK_DRIVERSMART
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_driversmart.

DATA: gv_fm_name TYPE RS38L_FNAM,
      gs_controls TYPE SSFCTRLOP,
      gs_output_opt TYPE SSFCOMPOP.

START-OF-SELECTION.

gs_controls-no_dialog = abap_true.
gs_controls-preview   = abap_true.
gs_output_opt-tddest = 'LP01'.

"Program for Reading , Updating , Inserting & Deleting data from a table

TABLES: ZCALISAN_TABLOSU. "Employee Table
DATA: lt_itab   TYPE TABLE OF ZCALISAN_TABLOSU,  "Internal table for employee basic details table
      lwa_emp   TYPE ZCALISAN_TABLOSU, "Workarea for employee basic details table
      lt_itab1  TYPE TABLE OF ZCALISAN_ADRES, "Internal table for employee address details table
      lwa_emp1  TYPE ZCALISAN_ADRES, "Workarea for employee address details table
      lt_itab2  TYPE TABLE OF ZCALISAN_MAAS,  "Internal table for employee salary details table
      lwa_emp2  TYPE ZCALISAN_MAAS, "Workarea for employee salary details table
      toplam_maas TYPE ZCAL_MAAS, "total salary
      vergi       TYPE ZCAL_MAAS, "total vergi
      c         TYPE ZCAL_MAAS, "vergi percentage
      mevcut    TYPE ZCAL_MAAS. "mevcut salary
PARAMETER: p_calid TYPE char8.
SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE text-101. "selection screen block
PARAMETERS:p_rad1 RADIOBUTTON GROUP rg1 USER-COMMAND flag DEFAULT 'X',
           p_rad2 RADIOBUTTON GROUP rg1,
           p_rad3 RADIOBUTTON GROUP rg1,
           p_rad4 RADIOBUTTON GROUP rg1,
           p_rad5 RADIOBUTTON GROUP rg1.
SELECTION-SCREEN END OF BLOCK blk1.


PARAMETERS:
  p_calad TYPE char20 MODIF ID pa1, "parameter for first name
  p_calsd TYPE char20 MODIF ID pa2, "parameter for last name
  p_sehir  TYPE char20 MODIF ID pa3, "parameter for city name
  p_a_mas  TYPE char20 MODIF ID pa4.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    CASE screen-group1. "selecion of parameters on the basis of radiobutton selection
      WHEN 'PA1'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad5 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'PA2'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad5 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
      WHEN 'PA3'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad5 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
        WHEN 'PA4'.
        IF p_rad1 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad2 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad3 = 'X'.
          screen-active = '1'.
        ENDIF.
        IF p_rad4 = 'X'.
          screen-active = '0'.
        ENDIF.
        IF p_rad5 = 'X'.
          screen-active = '0'.
        ENDIF.
        MODIFY SCREEN.
    ENDCASE.


  ENDLOOP.

AT SELECTION-SCREEN ON RADIOBUTTON GROUP rg1. "Auto-Popullating data in parameters
  IF p_rad3 EQ 'X'. "if update radio button is selected
    SELECT  CAL_ADI CAL_SOYADI
         FROM ZCALISAN_TABLOSU
         INTO CORRESPONDING FIELDS OF TABLE lt_itab
       WHERE CAL_ID = p_calid.
    IF sy-subrc = 0.
      LOOP AT lt_itab INTO lwa_emp.
        p_calad = lwa_emp-CAL_ADI.
        p_calsd = lwa_emp-CAL_SOYADI.
      ENDLOOP.
    ENDIF.
  ENDIF.
START-OF-SELECTION.
  IF p_rad3 EQ 'X'. "Updating data
    SELECT *
         FROM ZCALISAN_TABLOSU
         INTO TABLE lt_itab
         WHERE CAL_ID = p_calid.
    UPDATE ZCALISAN_TABLOSU SET CAL_ADI = p_calad
        CAL_SOYADI = p_calsd WHERE CAL_ID = p_calid.
    UPDATE ZCALISAN_ADRES SET SEHIR = p_sehir WHERE CAL_ID = p_calid.
    UPDATE ZCALISAN_MAAS SET AZAMI_MAAS = p_a_mas WHERE CAL_ID = p_calid.
    IF sy-subrc = 0.
      MESSAGE 'Employee Record Updated' TYPE 'I'.
    ELSEIF sy-subrc <> 0 .
      MESSAGE 'Wrong Employee ID3' TYPE 'E'.
      EXIT.
    ENDIF.
    EXIT.
  ENDIF.
  IF p_rad1 EQ 'X'. "Displaying Data
    SELECT *
      FROM ZCALISAN_TABLOSU
      INTO TABLE lt_itab
      WHERE CAL_ID = p_calid.
    IF sy-subrc = 0 .
      LOOP AT lt_itab INTO lwa_emp.
        FORMAT COLOR 1 INTENSIFIED ON. "adding dark color to headings
        WRITE: /3 'Calisan ID',
                20 'Adi',
                35 'Soy Adi',
                70  'Dogum Tarihi',
                90  'Cinsiyet',
                110  'Medeni Hal',
                130  'Olusturan',
                150  'Olusturma Tarihi'.
        ULINE. " FOR UNDERLINE
        FORMAT COLOR 2 INTENSIFIED ON. "adding dark color to fields
        WRITE:/3 lwa_emp-CAL_ID, 20 lwa_emp-CAL_ADI,35 lwa_emp-CAL_SOYADI,70 lwa_emp-DOGUM_TARIHI,90 lwa_emp-CINSIYET,110 lwa_emp-MEDENI_HAL,
        130 lwa_emp-OLUSTURAN,150 lwa_emp-OLUST_TARIHI.
      ENDLOOP.
      ULINE.
      SELECT *
     FROM ZCALISAN_ADRES
     INTO TABLE lt_itab1
     WHERE CAL_ID = p_calid.
      LOOP AT lt_itab1 INTO lwa_emp1.
        FORMAT COLOR 1 INTENSIFIED ON. "adding dark color to headings
        WRITE: /3 'Calisan ID',
                20 'Daire No',
                35 'Sokak Adi',
                70  'Sehir',
                90  'Ilce',
                110  'Posta Kodu'.
        ULINE. " FOR UNDERLINE
        FORMAT COLOR 2 INTENSIFIED ON. "adding dark color to fields
        WRITE:/3 lwa_emp1-CAL_ID, 20 lwa_emp1-DAIRE_NO, 35 lwa_emp1-SOKAK_ADI,70 lwa_emp1-SEHIR,90 lwa_emp1-ILCE,110 lwa_emp1-POSTA_KODU.
      ENDLOOP.
      ULINE.
      SELECT *
      FROM ZCALISAN_MAAS
      INTO TABLE lt_itab2
      WHERE CAL_ID = p_calid.
      LOOP AT lt_itab2 INTO lwa_emp2.
        FORMAT COLOR 1 INTENSIFIED ON. "adding dark color to headings
        WRITE: /3 'Calisan ID',
                35 'Ay',
                70  'Maas Tarihi',
                90  'Brut Maas',
                110  'Yemek',
                130  'Ulasim',
                190  'Saglik',
                210  'Diger'.
        ULINE. " FOR UNDERLINE
        FORMAT COLOR 2 INTENSIFIED ON. "adding dark color to fields

        WRITE:/3 lwa_emp2-CAL_ID,35 lwa_emp2-AY,70 lwa_emp2-MAAS_GUNU,90 lwa_emp2-AZAMI_MAAS,110 lwa_emp2-YEMEK_KARTI,130 lwa_emp2-ULASIM,
        190 lwa_emp2-SAGLIK,210 lwa_emp2-DIGER.
      ENDLOOP.
      ULINE.
      toplam_maas = lwa_emp2-AZAMI_MAAS + lwa_emp2-YEMEK_KARTI + lwa_emp2-ULASIM + lwa_emp2-SAGLIK + lwa_emp2-DIGER. "total salary calculated
      WRITE:/ 'Toplam Maas = ', toplam_maas.
      IF toplam_maas < 1000.
        WRITE: 'Vergiye tabii degil!'.
      ELSEIF ( 1000 < toplam_maas AND toplam_maas < 30000 ).
        c = 30 / 100.
        vergi = c * toplam_maas. "total vergi calculated when 10000< total salary <35000
        WRITE : / 'vergi = ', vergi.
      ELSEIF ( 30000 < toplam_maas AND toplam_maas <  50000 ).
        c = 60 / 100.
        vergi = c * toplam_maas. "total vergi calculated when 30000 < total salary <50000
        WRITE : / 'vergi = ', vergi.
      ELSEIF toplam_maas > 50000.
        c = 90 / 100.
        vergi = c * toplam_maas. "total vergi calculated when total salary >50000
        WRITE : / 'vergi = ', vergi.
      ENDIF.
      mevcut = toplam_maas - vergi. "mevcut salary
      WRITE : / 'mevcut Salary' , mevcut.
    ELSEIF sy-subrc <> 0 .
      MESSAGE 'Wrong Employee ID1' TYPE 'E'.
      EXIT.
    ENDIF.
  ENDIF.

  IF p_rad2 EQ 'X'. "Inserting Data
    lwa_emp2-CAL_ID = p_calid.
    lwa_emp-CAL_ADI = p_calad.
    lwa_emp-CAL_SOYADI = p_calsd.
    lwa_emp1-SEHIR = p_sehir.
    lwa_emp2-AZAMI_MAAS = P_a_mas.
    INSERT ZCALISAN_TABLOSU FROM lwa_emp.
    INSERT ZCALISAN_ADRES FROM lwa_emp1.
    INSERT ZCALISAN_MAAS FROM lwa_emp2.
    IF sy-subrc = 0.
      MESSAGE 'Employee Record Inserted' TYPE 'I'.
    ELSEIF sy-subrc <> 0 .
      MESSAGE 'Wrong Employee ID2' TYPE 'E'.
      EXIT.
    ENDIF.
    EXIT.
  ENDIF.

  IF p_rad4 EQ 'X'. "Deleting Data
    DELETE FROM ZCALISAN_TABLOSU WHERE CAL_ID = p_calid.
    IF sy-subrc = 0.
      MESSAGE 'Employee Record Deleted' TYPE 'I'.
    ELSEIF sy-subrc <> 0 .
      MESSAGE 'Wrong Employee ID4' TYPE 'E'.
      EXIT.
    ENDIF.
  ENDIF.

IF p_rad5 EQ 'X'. " SMARTFORM CAGIRMA
  "" FONKSIYON CAGIRMA KISMI
CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname                 = 'ZBK_SF_0001'
*   VARIANT                  = ' '
*   DIRECT_CALL              = ' '
 IMPORTING
   FM_NAME                  = gv_fm_name
* EXCEPTIONS
*   NO_FORM                  = 1
*   NO_FUNCTION_MODULE       = 2
*   DIGER                   = 3
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.

  CALL FUNCTION gv_fm_name
 EXPORTING
*   ARCHIVE_INDEX              =
*   ARCHIVE_INDEX_TAB          =
*   ARCHIVE_PARAMETERS         =
   CONTROL_PARAMETERS         = gs_controls
*   MAIL_APPL_OBJ              =
*   MAIL_RECIPIENT             =
*   MAIL_SENDER                =
   OUTPUT_OPTIONS             = gs_output_opt
   USER_SETTINGS              = ' '
* IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
*   JOB_OUTPUT_INFO            =
*   JOB_OUTPUT_OPTIONS         =
* EXCEPTIONS
*   FORMATTING_ERROR           = 1
*   INTERNAL_ERROR             = 2
*   SEND_ERROR                 = 3
*   USER_CANCELED              = 4
*   OTHERS         = 5
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  ENDIF.
