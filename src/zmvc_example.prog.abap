*&---------------------------------------------------------------------*
*& Report zmvc_example
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmvc_example.

DATA: mo_mng TYPE REF TO zcl_mvc_mng_controller.

TYPES: BEGIN OF ts_main_param,
         name      TYPE c LENGTH 20,
         surname   TYPE c LENGTH 20,
         screen_nr LIKE sy-dynnr,
       END OF ts_main_param.

DATA: gs_main_param  TYPE ts_main_param.

DATA: gv_ok_code LIKE sy-ucomm,
      gv_sub_scr LIKE sy-dynnr.


START-OF-SELECTION.

  mo_mng = zcl_mvc_mng_controller=>s_factory( ).
  mo_mng->set_mvc_pattern( iv_class_name = 'zcl_mvc_sc$_controller' iv_pattern = '$' ).
  mo_mng->set_view_mode( iv_view_mode = zcl_mvc_mng_controller=>gc_view_mode_single  ). " Default Type

  CALL SCREEN 100.

  INCLUDE zmvc_example_o01.
  INCLUDE zmvc_example_i01.
