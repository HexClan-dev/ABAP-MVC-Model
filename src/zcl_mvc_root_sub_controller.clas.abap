CLASS zcl_mvc_root_sub_controller DEFINITION INHERITING FROM zcl_mvc_root_controller
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: zif_mvc_root_controller.

    METHODS set_active IMPORTING iv_active TYPE abap_bool DEFAULT abap_true.
    METHODS is_active   RETURNING VALUE(rv_is_active) TYPE abap_bool.


*    METHODS:
*      proces_after_input ABSTRACT
*        IMPORTING
*          iv_ok_code LIKE sy-ucomm DEFAULT sy-ucomm,
*
*      process_before_output ABSTRACT.

    METHODS
      get_sub_screen_nr
        RETURNING VALUE(rv_sub_scr_nr) TYPE sydynnr.

  PROTECTED SECTION.

    METHODS
      set_sub_screen_nr
        IMPORTING
          iv_sub_scr_nr TYPE sydynnr .


  PRIVATE SECTION.
    DATA: mv_sub_src TYPE sydynnr.
    DATA: mv_is_active TYPE abap_bool VALUE abap_true.


ENDCLASS.



CLASS zcl_mvc_root_sub_controller IMPLEMENTATION.

  METHOD set_active.
    me->mv_is_active = iv_active.

    IF iv_active EQ abap_true.
      " call the process before output
      me->zif_mvc_root_controller~pbo( ).
    ENDIF.

  ENDMETHOD.

  METHOD is_active.
    rv_is_active = me->mv_is_active.
  ENDMETHOD.

  METHOD set_sub_screen_nr.
    me->mv_sub_src = iv_sub_scr_nr.
  ENDMETHOD.

  METHOD get_sub_screen_nr.
    rv_sub_scr_nr = me->mv_sub_src.
  ENDMETHOD.

ENDCLASS.
