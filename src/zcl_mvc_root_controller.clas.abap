CLASS zcl_mvc_root_controller DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS gc_screen_type_normal TYPE c VALUE 'NORMAL' ##NO_TEXT.
    CONSTANTS gc_screen_type_subscr TYPE c VALUE 'SUBSCREEN' ##NO_TEXT.
    CONSTANTS gc_screen_type_modal TYPE c VALUE 'MODAL' ##NO_TEXT.

    INTERFACES zif_mvc_parameters
      FINAL METHODS
      add_parameter
      get_parameters
      set_parameters
      delete_parameter.

    INTERFACES zif_mvc_controller_list
      FINAL METHODS
      initialize_controller
      initialize_view.

    ALIASES initialize_controller
      FOR zif_mvc_controller_list~initialize_controller.
    ALIASES initialize_view
      FOR zif_mvc_controller_list~initialize_view.


    ALIASES set_parameters
      FOR zif_mvc_parameters~set_parameters.
    ALIASES get_parameters
      FOR zif_mvc_parameters~get_parameters.
    ALIASES add_parameter
       FOR zif_mvc_parameters~add_parameter.
    ALIASES delete_parameter
       FOR zif_mvc_parameters~delete_parameter.



    METHODS set_status_and_title
      IMPORTING
        !iv_scr_nr      TYPE sydynnr OPTIONAL
        !iv_gui_status  TYPE gui_status OPTIONAL
        !iv_titlebar    TYPE gui_title OPTIONAL
        !iv_screen_type TYPE c DEFAULT gc_screen_type_normal .

    METHODS:
      get_view FINAL
        RETURNING VALUE(ro_view) TYPE REF TO zif_mvc_root_view.

  PROTECTED SECTION.

    DATA mo_view TYPE REF TO zif_mvc_root_view .
    DATA mo_model TYPE REF TO zif_mvc_root_model .
    DATA mv_scr_nr TYPE sydynnr .
    DATA mv_scr_type TYPE c .
    DATA mv_gui_status TYPE gui_status .
    DATA mv_titlebar TYPE gui_title .

    METHODS enable_gui_status .
    METHODS enable_titlebar .
    METHODS initialize .
  PRIVATE SECTION.


ENDCLASS.



CLASS zcl_mvc_root_controller IMPLEMENTATION.


  METHOD enable_gui_status.
    IF me->mv_gui_status IS NOT INITIAL.
      SET PF-STATUS me->mv_gui_status.
    ENDIF.
  ENDMETHOD.


  METHOD enable_titlebar.
    IF me->mv_titlebar IS NOT INITIAL.
      SET TITLEBAR me->mv_titlebar.
    ENDIF.
  ENDMETHOD.


  METHOD initialize.
    " This will be implemented in Subclass
  ENDMETHOD.


  METHOD set_status_and_title.
    IF iv_scr_nr     IS SUPPLIED. me->mv_scr_nr = iv_scr_nr.            ENDIF.
    IF iv_gui_status IS SUPPLIED. me->mv_gui_status = iv_gui_status.    ENDIF.
    IF iv_titlebar   IS SUPPLIED. me->mv_titlebar = iv_titlebar.        ENDIF.

    me->mv_scr_type = iv_screen_type.
  ENDMETHOD.


  METHOD initialize_controller.
    " Initialize Root Controller
    me->initialize( ).

    " Make View available to the Model
    " If the Model is defined
    IF me->mo_model IS NOT INITIAL.
      me->mo_model->define_view( io_view = me->mo_view ).
    ENDIF.

  ENDMETHOD.


  METHOD initialize_view.

    " Create a View Controller automatically
    " If it has not been created before
    IF io_view IS SUPPLIED.
      me->mo_view = io_view.
    ENDIF.

    IF me->mo_view IS NOT BOUND.
      me->mo_view = NEW zcl_mvc_root_view( ).
    ENDIF.

  ENDMETHOD.


  METHOD add_parameter.

    IF me->mo_view IS BOUND.
      me->mo_view->add_parameter(
        EXPORTING
          ir_param_value = ir_data_param
          iv_param_name  = iv_param_name
      ).
    ENDIF.

  ENDMETHOD.


  METHOD get_parameters.
    IF me->mo_view IS BOUND.
      me->mo_view->get_parameters(
        CHANGING
          cs_input_paramters = cs_input_paramters
      ).
    ELSE.
      MESSAGE 'View is not defined !' TYPE 'W'.
    ENDIF.
  ENDMETHOD.


  METHOD set_parameters.
    IF me->mo_view IS BOUND.
      me->mo_view->update_parameters( ir_data_param ).
    ELSE.
      MESSAGE 'View is not defined !' TYPE 'W'.
    ENDIF.
  ENDMETHOD.

  METHOD delete_parameter.
    CHECK me->mo_view IS BOUND.

    me->mo_view->delete_parameter( iv_parameter = iv_parameter ).

  ENDMETHOD.

  METHOD get_view.
    ro_view = me->mo_view.
  ENDMETHOD.

ENDCLASS.
