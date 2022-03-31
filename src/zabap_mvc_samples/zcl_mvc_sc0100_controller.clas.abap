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



CLASS ZCL_MVC_SC0100_CONTROLLER IMPLEMENTATION.


  METHOD initialize.

    " Initialization of the classes for specific controller
    me->mo_model = NEW zcl_mvc_sc0100_model( ).

    " set the screen information then enable in the process after input
    me->set_status_and_title( iv_scr_nr = '0110' iv_gui_status = '' iv_titlebar = '' ).

    "initialize the GLobal parameter
    me->add_parameter( iv_param_name = 'SCREEN_NR' ir_data_param = '0110').

  ENDMETHOD.


  METHOD zif_mvc_controller~pai.
    " PAI

    CASE iv_ok_code.
      WHEN 'IB'.
        "blabla

      WHEN 'BACK' OR 'EXIT'.
        LEAVE TO SCREEN 0.

    ENDCASE.
  ENDMETHOD.


  METHOD zif_mvc_controller~pbo.
    " PBO -> logic implementation

  ENDMETHOD.
ENDCLASS.
