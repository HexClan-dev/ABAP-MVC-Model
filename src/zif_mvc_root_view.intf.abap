INTERFACE zif_mvc_root_view
  PUBLIC .

  METHODS:
    update_parameters
      IMPORTING
        ir_data_param TYPE any.

  METHODS get_parameters
    CHANGING
      cs_input_paramters TYPE any.

  METHODS delete_parameter
    IMPORTING
      !iv_parameter TYPE char50.

  METHODS add_parameter
    IMPORTING
      ir_param_value TYPE any
      iv_param_name  TYPE string.

  METHODS add_parameters
    IMPORTING
      ir_params TYPE any.



ENDINTERFACE.
