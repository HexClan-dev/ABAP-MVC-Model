CLASS zcl_mvc_sc0100_controller DEFINITION
  PUBLIC
  INHERITING FROM zcl_mvc_root_controller
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mvc_controller .


  PROTECTED SECTION.
    METHODS initialize REDEFINITION.


  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_mvc_sc0100_controller IMPLEMENTATION.



  METHOD initialize.

    " Initialization of the classes for specific controller
    me->mo_model = NEW zcl_mvc_sc0100_model( ).

    " set the screen information then enable in the process after input
    me->set_status_and_title( iv_scr_nr = '0110' iv_gui_status = '' iv_titlebar = '' ).

    "initialize the GLobal parameter
    me->set_parameter( iv_param_name = 'SCREEN_NR' ir_param_value = '0110').

  ENDMETHOD.


  METHOD zif_mvc_controller~pai.
    " PAI -> Logic implementation

    CASE iv_ok_code.
      WHEN 'IB'.
        " IB OK Code

    ENDCASE.
  ENDMETHOD.


  METHOD zif_mvc_controller~pbo.
    " PBO -> logic implementation

  ENDMETHOD.
ENDCLASS.
