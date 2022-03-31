CLASS zcl_mvc_sc0111_controller DEFINITION
  PUBLIC
  INHERITING FROM zcl_mvc_root_sub_controller
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mvc_controller .

  PROTECTED SECTION.
    METHODS: initialize REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_MVC_SC0111_CONTROLLER IMPLEMENTATION.


  METHOD initialize.
    " set the subscreen number for the sub scr controller
    me->set_sub_screen_nr( '0111' ).

  ENDMETHOD.


  METHOD zif_mvc_controller~pai.

    "PAI checking for Subscreen Controller
    CASE iv_ok_code.
      WHEN ''.

    ENDCASE.

  ENDMETHOD.


  METHOD  zif_mvc_controller~pbo.
    " Read database information from the Model

  ENDMETHOD.
ENDCLASS.
