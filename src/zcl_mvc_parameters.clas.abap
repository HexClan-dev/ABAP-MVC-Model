CLASS zcl_mvc_parameters DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES: zif_mvc_parameters.

    ALIASES get_parameters
      FOR zif_mvc_parameters~get_parameters.

    ALIASES get_parameter
      FOR zif_mvc_parameters~get_parameter.

    ALIASES set_parameter
      FOR zif_mvc_parameters~set_parameter.

    ALIASES set_parameters
      FOR zif_mvc_parameters~set_parameters.

    ALIASES delete_parameter
      FOR zif_mvc_parameters~delete_parameter.

    ALIASES update_parameters
      FOR zif_mvc_parameters~update_parameters.


  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS:

      insert_entry
        IMPORTING
          !is_parameter TYPE zif_mvc_parameters=>ty_parameter.

    DATA: mt_parameters TYPE zif_mvc_parameters=>tt_parameters.

ENDCLASS.



CLASS zcl_mvc_parameters IMPLEMENTATION.


  METHOD set_parameters.

    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr.
    DATA: ls_comp  TYPE zif_mvc_parameters=>ty_parameter.

    TRY.
        lo_str_descr ?= cl_abap_structdescr=>describe_by_data( ir_param_value ).
        DATA(lt_old_comp) = lo_str_descr->get_components( ).

        LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).
          ASSIGN COMPONENT <ls_s_line>-name OF STRUCTURE ir_param_value TO FIELD-SYMBOL(<lv_value>).
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
    DATA: ls_comp  TYPE zif_mvc_parameters=>ty_parameter.

    TRY.
        lo_str_descr ?= cl_abap_structdescr=>describe_by_data( cs_parameters ).
        DATA(lt_old_comp) = lo_str_descr->get_components( ).

        LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).
          ASSIGN COMPONENT <ls_s_line>-name OF STRUCTURE cs_parameters TO FIELD-SYMBOL(<lv_value>).
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

    TRY.
        lo_str_descr ?= cl_abap_structdescr=>describe_by_data( es_input_paramters ).
        DATA(lt_old_comp) = lo_str_descr->get_components( ).

        LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).

          READ TABLE me->mt_parameters INTO DATA(ls_parameter) WITH KEY name = <ls_s_line>-name.

          ASSIGN COMPONENT 'type' OF STRUCTURE <ls_s_line> TO FIELD-SYMBOL(<lv_type>).
          ASSIGN COMPONENT <ls_s_line>-name OF STRUCTURE es_input_paramters TO FIELD-SYMBOL(<lv_value>).

          <lv_type> = ls_parameter-type.
          <lv_value> = ls_parameter-value.

        ENDLOOP.

      CATCH cx_root INTO DATA(lx_exception).
        " TODO -> Raise a specific message
    ENDTRY.

  ENDMETHOD.

  METHOD delete_parameter.

    DELETE me->mt_parameters WHERE name = iv_parameter.

    IF sy-subrc <> 0.
      rv_deleted = abap_false.
    ELSE.
      rv_deleted = abap_true.
    ENDIF.

  ENDMETHOD.

  METHOD set_parameter.

    " Insert parameter to internal table
    me->insert_entry( is_parameter = VALUE #( name = iv_param_name type = ir_param_type value = ir_param_value ) ).

  ENDMETHOD.

  METHOD get_parameter.

    READ TABLE me->mt_parameters INTO rs_parameter WITH KEY name = iv_param_name.

    IF sy-subrc <> 0.
      "TODO -> Raise an Error message
    ENDIF.

  ENDMETHOD.

ENDCLASS.
