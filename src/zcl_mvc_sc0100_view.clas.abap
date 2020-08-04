CLASS zcl_mvc_sc0100_view DEFINITION INHERITING FROM zcl_mvc_root_view
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS display_alw.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS check_parametters.

ENDCLASS.



CLASS zcl_mvc_sc0100_view IMPLEMENTATION.


  METHOD check_parametters.

    TYPES: BEGIN OF ty_ps,
             ms TYPE string,
           END OF ty_ps.

    DATA: ls_cp TYPE ty_ps.

    me->zif_mvc_root_view~assign_parameters(
      CHANGING
        cs_input_paramters = ls_cp
    ).


  ENDMETHOD.


  METHOD display_alw.


  ENDMETHOD.

ENDCLASS.
