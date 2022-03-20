CLASS zcl_mvc_view_middleware DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:

      constructor
        IMPORTING
          io_controller TYPE REF TO zif_mvc_controller.

    METHODS:
      get_params
        CHANGING  cs_parameter         TYPE any OPTIONAL
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

    METHODS:
      set_params
        IMPORTING is_parameter         TYPE any OPTIONAL
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

    METHODS:
      update_params
        CHANGING  cs_parameter         TYPE any OPTIONAL
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.


    METHODS:
      controller
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

    METHODS:
      delete_params
        IMPORTING iv_param_name        TYPE char50
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: mo_controller TYPE REF TO zif_mvc_controller.


    METHODS: middleware
      RETURNING VALUE(ro_view) TYPE REF TO zif_mvc_root_view.

ENDCLASS.



CLASS zcl_mvc_view_middleware IMPLEMENTATION.


  METHOD constructor.
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

  METHOD controller.
    " No parameter is defined
    ro_controller = me->mo_controller.
  ENDMETHOD.



  METHOD middleware.
    " Define the Middleware Logic for the view
    DATA: lo_controller TYPE REF TO zcl_mvc_root_controller.

    lo_controller ?= me->mo_controller.

    ro_view = lo_controller->get_view( ).

  ENDMETHOD.

ENDCLASS.
