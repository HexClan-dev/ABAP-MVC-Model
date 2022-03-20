CLASS zcl_mvc_sc0111_controller DEFINITION
  PUBLIC
  INHERITING FROM zcl_mvc_root_sub_controller
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mvc_root_controller .

    METHODS controller .

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_mvc_sc0111_controller IMPLEMENTATION.


  METHOD controller.
    " set the subscreen number for the sub scr controller
    me->set_sub_screen_nr( '0111' ).

  ENDMETHOD.


  METHOD zif_mvc_root_controller~pai.

    "PAI checking for Subscreen Controller
    CASE iv_ok_code.
      WHEN ''.

    ENDCASE.

  ENDMETHOD.


  METHOD  zif_mvc_root_controller~pbo.
    " Read database information from the Model

*    me->get_parameters(
*      CHANGING
*        cs_input_paramters = cs_input_paramters
*    ).

  ENDMETHOD.
ENDCLASS.
