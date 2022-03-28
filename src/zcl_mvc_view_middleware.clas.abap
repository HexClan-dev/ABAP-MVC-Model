CLASS zcl_mvc_view_middleware DEFINITION
  PUBLIC
  CREATE PUBLIC
    GLOBAL FRIENDS zcl_mvc_mng_controller.

  PUBLIC SECTION.

    INTERFACES: zif_mvc_middleware
      ALL METHODS FINAL.

    ALIASES get_params
        FOR zif_mvc_middleware~get_params.
    ALIASES set_params
        FOR zif_mvc_middleware~set_params.
    ALIASES update_params
        FOR zif_mvc_middleware~update_params.
    ALIASES delete_params
        FOR zif_mvc_middleware~delete_params.

    " Can be redefined
    METHODS:
      pai
        IMPORTING
                  iv_ok_code           LIKE sy-ucomm DEFAULT sy-ucomm
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller,
      pbo
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.


  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: mo_controller TYPE REF TO zif_mvc_controller.


    METHODS: middleware
      RETURNING VALUE(ro_view) TYPE REF TO zif_mvc_root_view.


    METHODS:
      set_controller
        IMPORTING
          io_controller TYPE REF TO zif_mvc_controller.


ENDCLASS.



CLASS zcl_mvc_view_middleware IMPLEMENTATION.


  METHOD set_controller.
    " Assign the created Constructor
    me->mo_controller = io_controller.

  ENDMETHOD.


  METHOD get_params.
    ro_controller = me->mo_controller.

    DATA(lv_view) = me->middleware( ).

    lv_view->get_parameters(
      CHANGING
        cs_input_paramters = cs_parameter
    ).

  ENDMETHOD.

  METHOD set_params.
    ro_controller = me->mo_controller.

    DATA(lv_view) = me->middleware( ).

    lv_view->add_parameters( ir_params = is_parameter ).

  ENDMETHOD.

  METHOD delete_params.
    ro_controller = me->mo_controller.

    DATA(lv_view) = me->middleware( ).

    lv_view->delete_parameter( iv_parameter = iv_param_name ).

  ENDMETHOD.

  METHOD update_params.

    ro_controller = me->mo_controller.

    DATA(lv_view) = me->middleware( ).

    lv_view->update_parameters( ir_data_param = cs_parameter ).

  ENDMETHOD.


  METHOD middleware.
    " Define the Middleware Logic for the view
    DATA: lo_controller TYPE REF TO zcl_mvc_root_controller.

    lo_controller ?= me->mo_controller.

    ro_view = lo_controller->get_view( ).

  ENDMETHOD.

  METHOD pai.
    " Call the PAI and then return controller
    me->mo_controller->pai( iv_ok_code = iv_ok_code ).
    ro_controller = me->mo_controller.
  ENDMETHOD.

  METHOD pbo.
    " Call the PBO and then return controller
    me->mo_controller->pbo( ).
    ro_controller = me->mo_controller.
  ENDMETHOD.

ENDCLASS.
