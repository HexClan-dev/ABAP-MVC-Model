CLASS zcl_mvc_mng_controller DEFINITION FINAL
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.

    INTERFACES: zif_linked_list.

    CLASS-METHODS:
      s_factory RETURNING VALUE(ro_mng) TYPE REF TO zcl_mvc_mng_controller.

    METHODS:
      constructor,

      get_con_dynpro
        IMPORTING
                  iv_scr_nr            TYPE sydynnr OPTIONAL
        RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_root_controller,

      set_mvc_pattern
        IMPORTING
          iv_class_name TYPE string
          iv_pattern    TYPE c.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_controller_list TYPE REF TO zcl_linked_list.

    DATA:
      mv_class_model_name TYPE string,
      mv_pattern          TYPE c.

    CLASS-DATA:
        mo_factory TYPE REF TO zcl_mvc_mng_controller.

    METHODS:
      create_new_controller,

      convert_to_cl_name
        IMPORTING
                  iv_scr_nr         TYPE sydynnr
        RETURNING VALUE(rv_cl_name) TYPE string.

ENDCLASS.



CLASS zcl_mvc_mng_controller IMPLEMENTATION.

  METHOD constructor.
    mo_controller_list = NEW zcl_linked_list( ).
  ENDMETHOD.

  METHOD s_factory.
    " singleton method factory
    IF mo_factory IS NOT BOUND.
      mo_factory = NEW zcl_mvc_mng_controller( ).
    ENDIF.
    ro_mng = mo_factory.
  ENDMETHOD.

  METHOD create_new_controller.
*    me->mo_controller_list->offer_first( iv_item_name = '' ).
  ENDMETHOD.

  METHOD set_mvc_pattern.
    " assign the pattern information for the class name
    me->mv_class_model_name = iv_class_name.
    me->mv_pattern = iv_pattern.
    " convert to upper-case the class name
    TRANSLATE me->mv_class_model_name TO UPPER CASE.
  ENDMETHOD.

  METHOD convert_to_cl_name.
    DATA(lv_cl_name) = me->mv_class_model_name.
    REPLACE me->mv_pattern WITH iv_scr_nr INTO lv_cl_name.
    rv_cl_name = lv_cl_name.
  ENDMETHOD.

  METHOD get_con_dynpro.
    " Generate a controller form the screen number

    IF iv_scr_nr IS SUPPLIED.
      DATA(lv_scr_nr) = iv_scr_nr.
    ELSE.
      lv_scr_nr = sy-dynnr.
    ENDIF.

    DATA(lv_class_name) = me->convert_to_cl_name( lv_scr_nr ).

    IF me->mo_controller_list->exists( lv_class_name ) EQ abap_true.
      ro_controller ?= me->mo_controller_list->get_item( iv_item_name = lv_class_name ).
    ELSE.
      "TODO -> Check if the controller exist on the linked list
      ro_controller ?= me->mo_controller_list->offer_last( lv_class_name ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
