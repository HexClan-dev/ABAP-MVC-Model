CLASS zcl_mvc_root_view DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: zif_mvc_root_view.


  PROTECTED SECTION.


  PRIVATE SECTION.
    DATA: ms_parameters TYPE REF TO data.

ENDCLASS.



CLASS zcl_mvc_root_view IMPLEMENTATION.


  METHOD zif_mvc_root_view~set_parameters.
    " Generic input structure
    DATA: lo_inp TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS: <lfs_inp_> TYPE any.

    lo_inp ?= cl_abap_structdescr=>describe_by_data( p_data = ir_data_param ).
    ASSIGN ir_data_param TO <lfs_inp_> CASTING TYPE HANDLE  lo_inp.

    "-------------------------------------
    " View Parameter
    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS: <lfs_str> TYPE any.

    IF me->ms_parameters IS NOT BOUND.
      CREATE DATA me->ms_parameters LIKE ir_data_param.
    ENDIF.

    ASSIGN  me->ms_parameters->* TO <lfs_str>.
    "-------------------------------------
*    <lfs_str> = <lfs_inp_>.
    MOVE-CORRESPONDING  <lfs_inp_> TO <lfs_str>.


  ENDMETHOD.

  METHOD zif_mvc_root_view~add_parameter.

    "-------------------------------------
    " View Parameter
    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr,
          lo_new_ref   TYPE REF TO data.

    FIELD-SYMBOLS: <lfs_inp_> TYPE any.
    FIELD-SYMBOLS: <lfs_param> TYPE any.

    DATA: ls_new_components  TYPE STANDARD TABLE OF abap_componentdescr
                       WITH KEY name.

    DATA: ls_comp  TYPE abap_componentdescr.

    IF me->ms_parameters IS BOUND.
      ASSIGN  me->ms_parameters->* TO <lfs_param>.

      lo_str_descr ?= cl_abap_structdescr=>describe_by_data( me->ms_parameters ).
      DATA(lt_old_comp) = lo_str_descr->get_components( ).

      LOOP AT lt_old_comp ASSIGNING FIELD-SYMBOL(<ls_s_line>).
        CLEAR: ls_comp.
        ls_comp-name = <ls_s_line>-name.
        ls_comp-type = <ls_s_line>-type.
        APPEND ls_comp TO ls_new_components.
      ENDLOOP.

    ENDIF.

    "-------------------------------------

    CLEAR: ls_comp.
    ls_comp-name = iv_param_name.
    ls_comp-type ?= cl_abap_datadescr=>describe_by_data( ir_param_value ).
    APPEND ls_comp TO ls_new_components.

    DATA(lr_struct_result) = cl_abap_structdescr=>create( p_components = ls_new_components ).
    CREATE DATA lo_new_ref TYPE HANDLE lr_struct_result.

    FIELD-SYMBOLS: <lv_val> TYPE any.
    ASSIGN lo_new_ref->* TO <lv_val>.
    <lv_val> = ir_param_value.

    me->ms_parameters = lo_new_ref.

  ENDMETHOD.

  METHOD zif_mvc_root_view~assign_parameters.
    " Generic input structure
    DATA: lo_inp TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS: <lfs_inp_> TYPE any.

    lo_inp ?= cl_abap_structdescr=>describe_by_data( p_data = cs_input_paramters ).
    ASSIGN cs_input_paramters TO <lfs_inp_> CASTING TYPE HANDLE  lo_inp.

    "-------------------------------------
    " View Parameter
*    DATA: lo_str_descr TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS: <lfs_str> TYPE any.

*    lo_str_descr ?= cl_abap_structdescr=>describe_by_data( p_data = me->ms_parameters ).
*    ASSIGN me->ms_parameters TO <lfs_str> CASTING TYPE HANDLE  lo_str_descr.

    IF me->ms_parameters IS NOT BOUND.
      CREATE DATA me->ms_parameters LIKE cs_input_paramters.
    ENDIF.

    ASSIGN  me->ms_parameters->* TO <lfs_str>.
    "-------------------------------------
    MOVE-CORRESPONDING  <lfs_str> TO <lfs_inp_>.

  ENDMETHOD.

ENDCLASS.
