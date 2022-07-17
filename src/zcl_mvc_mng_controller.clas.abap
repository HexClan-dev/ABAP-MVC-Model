CLASS zcl_mvc_mng_controller DEFINITION
  FINAL
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.


    CONSTANTS gc_view_mode_single TYPE c VALUE 'S' ##NO_TEXT. " Default
    CONSTANTS gc_view_mode_screen TYPE c VALUE 'M' ##NO_TEXT.

    CLASS-METHODS:
      s_factory RETURNING VALUE(ro_mng) TYPE REF TO zcl_mvc_mng_controller.

    METHODS:
      constructor,

      get_dynpro
        IMPORTING
                  iv_scr_nr        TYPE sydynnr OPTIONAL
                  iv_class_name    TYPE string OPTIONAL
                    PREFERRED PARAMETER iv_scr_nr
        RETURNING VALUE(ro_params) TYPE REF TO zcl_mvc_view_middleware,

      set_view_mode
        IMPORTING
          iv_view_mode TYPE c,

      set_middleware
        IMPORTING
          io_middleware TYPE REF TO zcl_mvc_view_middleware,

      set_mvc_pattern
        IMPORTING
          iv_class_name TYPE string
          iv_pattern    TYPE c.

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA mo_factory TYPE REF TO zcl_mvc_mng_controller .

    DATA mo_controller_list TYPE REF TO zcl_mvc_controller_list .
    DATA mv_class_model_name TYPE string .
    DATA mv_pattern TYPE c .
    DATA mv_view_mode TYPE c .
    DATA mo_view  TYPE REF TO zif_mvc_root_view.
    DATA mo_middleware TYPE REF TO zcl_mvc_view_middleware.


    METHODS create_object
      IMPORTING
                iv_class_name    TYPE string
      RETURNING VALUE(ro_object) TYPE REF TO zif_mvc_controller_list.

    METHODS create_view_model .
    METHODS convert_to_cl_name
      IMPORTING
        !iv_scr_nr        TYPE sydynnr
      RETURNING
        VALUE(rv_cl_name) TYPE string .

    METHODS:
      set_default_view_mode,
      check_view_mode.

ENDCLASS.



CLASS zcl_mvc_mng_controller IMPLEMENTATION.


  METHOD constructor.
    mo_controller_list = NEW zcl_mvc_controller_list( ).

    " Define the Middleware
    me->mo_middleware = NEW zcl_mvc_view_middleware( ).

  ENDMETHOD.


  METHOD convert_to_cl_name.
    DATA(lv_cl_name) = me->mv_class_model_name.
    REPLACE me->mv_pattern WITH iv_scr_nr INTO lv_cl_name.
    rv_cl_name = lv_cl_name.
  ENDMETHOD.


  METHOD create_view_model.

    IF me->mv_view_mode = gc_view_mode_single.
      " Single View to Store all the Necessary Parameters
      me->mo_view = NEW zcl_mvc_root_view( ).
    ELSE.
      " For Screen View Mode, each screen will store is own parameter information
    ENDIF.

  ENDMETHOD.


  METHOD get_dynpro.

    " Generate a controller form the screen number
    DATA: lo_controller TYPE REF TO zif_mvc_controller.

    IF iv_class_name IS NOT SUPPLIED.
      IF iv_scr_nr IS SUPPLIED.
        DATA(lv_scr_nr) = iv_scr_nr.
      ELSE.
        lv_scr_nr = sy-dynnr.
      ENDIF.
      DATA(lv_class_name) = me->convert_to_cl_name( lv_scr_nr ).
    ELSE.
      lv_class_name = iv_class_name.
    ENDIF.

    "Theck if the controller exist on the created list
    IF me->mo_controller_list->exists( lv_class_name ) EQ abap_true.
      lo_controller ?= me->mo_controller_list->get_item( iv_item_name = lv_class_name ).
    ELSE.
      " New Controller Creation
      DATA(lv_class_created) = me->create_object( iv_class_name = lv_class_name ).

      lo_controller ?= me->mo_controller_list->offer_last( io_object = lv_class_created iv_item_name = lv_class_name ).
    ENDIF.

    " View Middleware Controller
    me->mo_middleware->set_controller( io_controller = lo_controller ).
    ro_params ?= me->mo_middleware.

  ENDMETHOD.

  METHOD create_object.
    " Create objects dynamically
    DATA: lo_ref TYPE REF TO zif_mvc_controller_list.
    TRY.
        CREATE OBJECT lo_ref TYPE (iv_class_name).

        " Check View Mode and Assign Default One if not defined
        me->check_view_mode( ).

        IF me->mv_view_mode = gc_view_mode_single.
          " Single View for all screens
          lo_ref->initialize_view(
              io_view = me->mo_view
          ).
        ELSE.
          " Each view has its own parameters
          lo_ref->initialize_view( ).
        ENDIF.

        " Initialize the controller
        lo_ref->initialize_controller( ).

        ro_object = lo_ref.
      CATCH cx_root.
        " Handle in case that the object is not created
    ENDTRY.

  ENDMETHOD.

  METHOD set_middleware.
    " Update the middleware
    me->mo_middleware = io_middleware.

  ENDMETHOD.


  METHOD set_mvc_pattern.
    " assign the pattern information for the class name
    me->mv_class_model_name = iv_class_name.
    me->mv_pattern = iv_pattern.
    " convert to upper-case the class name
    TRANSLATE me->mv_class_model_name TO UPPER CASE.
  ENDMETHOD.


  METHOD s_factory.
    " singleton method factory
    IF mo_factory IS NOT BOUND.
      mo_factory = NEW zcl_mvc_mng_controller( ).
    ENDIF.
    ro_mng = mo_factory.
  ENDMETHOD.

  METHOD set_view_mode.

    CHECK iv_view_mode = gc_view_mode_screen OR
          iv_view_mode = gc_view_mode_single.

    me->mv_view_mode = iv_view_mode.

    me->set_default_view_mode( ).

  ENDMETHOD.


  METHOD set_default_view_mode.
    IF me->mv_view_mode = gc_view_mode_single OR
        me->mv_view_mode IS INITIAL.
      me->create_view_model( ).
    ENDIF.
  ENDMETHOD.


  METHOD check_view_mode.
    IF me->mv_view_mode IS INITIAL.
      " Default View Mode Types
      me->mv_view_mode = gc_view_mode_single.
      me->set_default_view_mode( ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
