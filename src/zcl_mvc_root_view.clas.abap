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
    <lfs_str> = <lfs_inp_>.

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
    <lfs_inp_> = <lfs_str>.

  ENDMETHOD.

ENDCLASS.
