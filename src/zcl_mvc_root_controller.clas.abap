CLASS zcl_mvc_root_controller DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_parameters .
    INTERFACES zif_linked_list .

    ALIASES initialize
      FOR zif_linked_list~initialize .

    ALIASES initialize_view
      FOR zif_linked_list~initialize_view .


    CONSTANTS gc_screen_type_normal TYPE c VALUE 'NORMAL' ##NO_TEXT.
    CONSTANTS gc_screen_type_subscr TYPE c VALUE 'SUBSCREEN' ##NO_TEXT.
    CONSTANTS gc_screen_type_modal TYPE c VALUE 'MODAL' ##NO_TEXT.

    METHODS set_status_and_title
      IMPORTING
        !iv_scr_nr      TYPE sydynnr OPTIONAL
        !iv_gui_status  TYPE gui_status OPTIONAL
        !iv_titlebar    TYPE gui_title OPTIONAL
        !iv_screen_type TYPE c DEFAULT gc_screen_type_normal .
  PROTECTED SECTION.

    METHODS:
      enable_gui_status,
      enable_titlebar.


    DATA:
      mo_view  TYPE REF TO zif_mvc_root_view,
      mo_model TYPE REF TO zif_mvc_root_model.

    DATA:
      mv_scr_nr     TYPE sydynnr,
      mv_scr_type   TYPE c,
      mv_gui_status TYPE gui_status,
      mv_titlebar   TYPE gui_title.

  PRIVATE SECTION.


ENDCLASS.



CLASS zcl_mvc_root_controller IMPLEMENTATION.

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

  METHOD initialize.
    " To be Implemented in sub-classes
  ENDMETHOD.

  METHOD enable_titlebar.
    IF me->mv_titlebar IS NOT INITIAL.
      SET TITLEBAR me->mv_titlebar.
    ENDIF.
  ENDMETHOD.


  METHOD enable_gui_status.
    IF me->mv_gui_status IS NOT INITIAL.
      SET PF-STATUS me->mv_gui_status.
    ENDIF.
  ENDMETHOD.


  METHOD set_status_and_title.
    IF iv_scr_nr     IS SUPPLIED. me->mv_scr_nr = iv_scr_nr.            ENDIF.
    IF iv_gui_status IS SUPPLIED. me->mv_gui_status = iv_gui_status.    ENDIF.
    IF iv_titlebar   IS SUPPLIED. me->mv_titlebar = iv_titlebar.        ENDIF.

    me->mv_scr_type = iv_screen_type.
  ENDMETHOD.


  METHOD zif_parameters~add_parameter.

    IF me->mo_view IS BOUND.
      me->mo_view->add_parameter(
        EXPORTING
          ir_param_value = ir_data_param
          iv_param_name  = iv_param_name
      ).
    ENDIF.

  ENDMETHOD.


  METHOD zif_parameters~get_parameters.
    IF me->mo_view IS BOUND.
      me->mo_view->get_parameters(
        CHANGING
          cs_input_paramters = cs_input_paramters
      ).
    ELSE.
      MESSAGE 'View is not defined !' TYPE 'W'.
    ENDIF.
  ENDMETHOD.


  METHOD zif_parameters~set_parameters.
    IF me->mo_view IS BOUND.
      me->mo_view->update_parameters( ir_data_param ).
    ELSE.
      MESSAGE 'View is not defined !' TYPE 'W'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
