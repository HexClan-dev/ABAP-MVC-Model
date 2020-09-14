INTERFACE zif_mvc_root_view
  PUBLIC .

  METHODS:
    set_parameters
      IMPORTING
        ir_data_param TYPE any.

  METHODS assign_parameters
    CHANGING
      cs_input_paramters TYPE any.

  METHODS add_parameter
    IMPORTING
      ir_param_value TYPE any
      iv_param_name  TYPE string.


ENDINTERFACE.
