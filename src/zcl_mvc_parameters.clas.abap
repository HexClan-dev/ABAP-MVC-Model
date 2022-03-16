CLASS zcl_mvc_parameters DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

*--------Types
    TYPES: BEGIN OF ty_parameter,
             name  TYPE char50,
             value TYPE string,
             type  TYPE REF TO cl_abap_datadescr,
           END OF ty_parameter.

    TYPES: tt_parameters TYPE HASHED TABLE OF ty_parameter WITH UNIQUE KEY name.
*---------END Types

    METHODS:
      add_parameters
        IMPORTING
          !is_parameters TYPE any,

      add_parameter
        IMPORTING
          !is_parameter TYPE ty_parameter,

      update_parameters
        IMPORTING
          !is_parameters TYPE any,

      get_parameters
        CHANGING
          cs_parameters TYPE any,

      get_parameter
        IMPORTING
                  iv_param_name       TYPE ty_parameter-name
        RETURNING VALUE(rs_parameter) TYPE ty_parameter,

      remove_parameter
        IMPORTING
                  !iv_parameter     TYPE char50
        RETURNING VALUE(rv_deleted) TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS:

      insert_entry
        IMPORTING
          !is_parameter TYPE ty_parameter.


    DATA: mt_parameters TYPE tt_parameters.

ENDCLASS.



CLASS zcl_mvc_parameters IMPLEMENTATION.


  METHOD add_parameters.

    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr.
    DATA: ls_comp  TYPE ty_parameter.

    TRY.
        lo_str_descr ?= cl_abap_structdescr=>describe_by_data( is_parameters ).
        DATA(lt_old_comp) = lo_str_descr->get_components( ).

        LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).
          ASSIGN COMPONENT <ls_s_line>-name OF STRUCTURE is_parameters TO FIELD-SYMBOL(<lv_value>).
          CLEAR: ls_comp.
          ls_comp-name = <ls_s_line>-name.
          ls_comp-type = <ls_s_line>-type.
          ls_comp-value = <lv_value>.
          me->insert_entry( is_parameter = ls_comp ).

        ENDLOOP.

      CATCH cx_root INTO DATA(lx_exception).
        " TODO -> Raise a specific message
    ENDTRY.

  ENDMETHOD.

  METHOD update_parameters.

    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr.
    DATA: ls_comp  TYPE ty_parameter.

    TRY.
        lo_str_descr ?= cl_abap_structdescr=>describe_by_data( is_parameters ).
        DATA(lt_old_comp) = lo_str_descr->get_components( ).

        LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).
          ASSIGN COMPONENT <ls_s_line>-name OF STRUCTURE is_parameters TO FIELD-SYMBOL(<lv_value>).
          CLEAR: ls_comp.
          ls_comp-name = <ls_s_line>-name.
          ls_comp-type = <ls_s_line>-type.
          ls_comp-value = <lv_value>.

          " Modify or append the parameter values
          me->insert_entry( is_parameter = ls_comp ).
        ENDLOOP.

      CATCH cx_root INTO DATA(lx_exception).
        " TODO -> Raise a specific message
    ENDTRY.

  ENDMETHOD.

  METHOD insert_entry.

    READ TABLE me->mt_parameters TRANSPORTING NO FIELDS WITH KEY name = is_parameter-name.

    IF sy-subrc = 0.
      MODIFY TABLE me->mt_parameters FROM is_parameter.
    ELSE.
      INSERT is_parameter INTO TABLE me->mt_parameters.
    ENDIF.

  ENDMETHOD.

  METHOD get_parameters.

    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr.
    DATA: ls_comp  TYPE ty_parameter.

    TRY.
        lo_str_descr ?= cl_abap_structdescr=>describe_by_data( cs_parameters ).
        DATA(lt_old_comp) = lo_str_descr->get_components( ).

        LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).
          CLEAR: ls_comp.

          READ TABLE me->mt_parameters INTO DATA(ls_parameter) WITH KEY name = <ls_s_line>-name.

          ASSIGN COMPONENT 'type' OF STRUCTURE <ls_s_line> TO FIELD-SYMBOL(<lv_type>).
          ASSIGN COMPONENT <ls_s_line>-name OF STRUCTURE cs_parameters TO FIELD-SYMBOL(<lv_value>).

          <lv_type> = ls_parameter-type.
          <lv_value> = ls_parameter-value.

        ENDLOOP.

      CATCH cx_root INTO DATA(lx_exception).
        " TODO -> Raise a specific message
    ENDTRY.


  ENDMETHOD.

  METHOD remove_parameter.

    DELETE me->mt_parameters WHERE name = iv_parameter.

    IF sy-subrc <> 0.
      rv_deleted = abap_false.
    ELSE.
      rv_deleted = abap_true.
    ENDIF.

  ENDMETHOD.

  METHOD add_parameter.

    " Insert parameter to internal table
    me->insert_entry( is_parameter = is_parameter ).

  ENDMETHOD.

  METHOD get_parameter.

    READ TABLE me->mt_parameters INTO rs_parameter WITH KEY name = iv_param_name.

    IF sy-subrc <> 0.
      "TODO -> Raise an Error message
    ENDIF.

  ENDMETHOD.

ENDCLASS.
