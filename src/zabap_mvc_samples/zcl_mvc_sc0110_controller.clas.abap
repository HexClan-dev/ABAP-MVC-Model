CLASS zcl_mvc_sc0110_controller DEFINITION INHERITING FROM zcl_mvc_root_sub_controller
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES:
      zif_mvc_controller.


  PROTECTED SECTION.
    METHODS: initialize REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_mvc_sc0110_controller IMPLEMENTATION.

  METHOD initialize.
    " set the subscreen number for the sub scr controller
    me->set_sub_screen_nr( '0110' ).

  ENDMETHOD.

  METHOD  zif_mvc_controller~pbo.
    " PBO

  ENDMETHOD.

  METHOD zif_mvc_controller~pai.

    " Update SCREEN_Number Value
    me->add_parameter( iv_param_name = 'SCREEN_NR' ir_data_param = '0111').

    "PAI checking for Subscreen Controller
    CASE iv_ok_code.
      WHEN ''.

    ENDCASE.

  ENDMETHOD.


ENDCLASS.
