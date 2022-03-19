CLASS zcl_mvc_sc0100_controller DEFINITION
  PUBLIC
  INHERITING FROM zcl_mvc_root_controller
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mvc_root_controller .

    METHODS initialize REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_mvc_sc0100_controller IMPLEMENTATION.



  METHOD initialize.

    " Initialization of the classes for specific controller
    me->mo_model = NEW zcl_mvc_sc0100_model( ).

    " set the screen information then enable in the process after input
    me->set_status_and_title( iv_scr_nr = '0110' iv_gui_status = '' iv_titlebar = '' ).

    "initialize the GLobal parameter
    me->zif_parameters~add_parameter( iv_param_name = 'SCREEN_NR' ir_data_param = '0110').

  ENDMETHOD.


  METHOD zif_mvc_root_controller~pai.
    me->zif_parameters~set_parameters( ir_data_param = ir_data_param ).

    CASE iv_ok_code.
      WHEN 'IB'.
        "blabla

    ENDCASE.
  ENDMETHOD.


  METHOD zif_mvc_root_controller~pbo.
    " PBO -> logic implementation

    me->zif_parameters~get_parameters(
      CHANGING
        cs_input_paramters = cs_input_paramters
    ).

  ENDMETHOD.
ENDCLASS.
