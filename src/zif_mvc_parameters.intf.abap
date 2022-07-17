INTERFACE zif_mvc_parameters
  PUBLIC .


*--------Types
  TYPES: BEGIN OF ty_parameter,
           name  TYPE char50,
           value TYPE string,
           type  TYPE REF TO cl_abap_datadescr,
         END OF ty_parameter.

  TYPES: tt_parameters TYPE HASHED TABLE OF ty_parameter WITH UNIQUE KEY name.
*---------END Types

  METHODS:
    set_parameter
      IMPORTING
        iv_param_name  TYPE ty_parameter-name
        ir_param_value TYPE any
        ir_param_type  TYPE ty_parameter-type OPTIONAL.

  METHODS:
    set_parameters
      IMPORTING
        ir_param_value TYPE any.

  METHODS:
    get_parameters
      EXPORTING
        es_input_paramters TYPE any.

  METHODS:
    get_parameter
      IMPORTING
                iv_param_name       TYPE ty_parameter-name
      RETURNING VALUE(rs_parameter) TYPE ty_parameter.

  METHODS:
    delete_parameter
      IMPORTING
                !iv_parameter     TYPE char50
      RETURNING VALUE(rv_deleted) TYPE abap_bool.

  METHODS:
    update_parameters
      CHANGING
        !cs_parameters TYPE any.



ENDINTERFACE.
