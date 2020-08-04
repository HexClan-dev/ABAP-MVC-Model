CLASS zcl_mvc_root_controller DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: zif_parameters.

    CONSTANTS: gc_screen_type_normal VALUE 'NORMAL',
               gc_screen_type_subscr VALUE 'SUBSCREEN',
               gc_screen_type_modal  VALUE 'MODAL'.

    METHODS:
      set_status_and_title
        IMPORTING
          iv_scr_nr      TYPE sydynnr       OPTIONAL
          iv_gui_status  TYPE gui_status    OPTIONAL
          iv_titlebar    TYPE gui_title     OPTIONAL
          iv_screen_type TYPE c DEFAULT gc_screen_type_normal.

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

  METHOD set_status_and_title.
    IF iv_scr_nr     IS SUPPLIED. me->mv_scr_nr = iv_scr_nr.            ENDIF.
    IF iv_gui_status IS SUPPLIED. me->mv_gui_status = iv_gui_status.    ENDIF.
    IF iv_titlebar   IS SUPPLIED. me->mv_titlebar = iv_titlebar.        ENDIF.

    me->mv_scr_type = iv_screen_type.
  ENDMETHOD.

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

  METHOD zif_parameters~get_parameters.
    IF me->mo_view IS BOUND.
      me->mo_view->assign_parameters(
        CHANGING
          cs_input_paramters = cs_input_paramters
      ).
    ELSE.
      MESSAGE 'View is not defined !' TYPE 'W'.
    ENDIF.
  ENDMETHOD.

  METHOD zif_parameters~set_parameters.
    IF me->mo_view IS BOUND.
      me->mo_view->set_parameters( ir_data_param ).
    ELSE.
      MESSAGE 'View is not defined !' TYPE 'W'.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
