CLASS zcl_mvc_sc0100_controller DEFINITION INHERITING FROM zcl_mvc_root_controller
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: zif_mvc_root_controller.

    METHODS:
      constructor.

  PROTECTED SECTION.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mvc_sc0100_controller IMPLEMENTATION.

  METHOD constructor.
    super->constructor( ).
    " Initialization of the classes for specific controller
    me->mo_model = NEW zcl_mvc_sc0100_model( ).
    me->mo_view  = NEW zcl_mvc_sc0100_view( ).

    " set the screen information then enable in the process after input
    me->set_status_and_title( iv_scr_nr = '0100' iv_gui_status = '' iv_titlebar = '' ).
  ENDMETHOD.

  METHOD zif_mvc_root_controller~pai.
    CASE iv_ok_code.
      WHEN 'IB'.
        "blabla

    ENDCASE.
  ENDMETHOD.

  METHOD zif_mvc_root_controller~pbo.
    " TODO -> implement the PBO


  ENDMETHOD.


  METHOD zif_mvc_root_controller~get_screen_nr.
*    rv_scr_nr = me->mv_scr_nr.

  ENDMETHOD.

ENDCLASS.
