*&---------------------------------------------------------------------*
*& Report zmvc_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmvc_example.

DATA: mo_mng TYPE REF TO zcl_mvc_mng_controller.

TYPES: BEGIN OF ts_scr100_param,
         name    TYPE c LENGTH 20,
         surname TYPE c LENGTH 20,
       END OF ts_scr100_param.

TYPES: BEGIN OF ts_scr110_param,
         name    TYPE c LENGTH 20,
         surname TYPE c LENGTH 20,
       END OF ts_scr110_param.


DATA: gs_scr100_param  TYPE ts_scr100_param,
      gs_scr_110_param TYPE ts_scr110_param.

DATA: gv_ok_code LIKE sy-ucomm,
      gv_sub_scr LIKE sy-dynnr.

START-OF-SELECTION.

  mo_mng = zcl_mvc_mng_controller=>s_factory( ).
  mo_mng->set_mvc_pattern( iv_class_name = 'zcl_mvc_sc$_controller' iv_pattern = '$' ).

  CALL SCREEN 100.

  INCLUDE zmvc_example_o01.
  INCLUDE zmvc_example_i01.
