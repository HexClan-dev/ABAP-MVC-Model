INTERFACE zif_mvc_root_view
  PUBLIC .

  METHODS:
    set_parameters
      IMPORTING
        ir_data_param TYPE any.

  METHODS assign_parameters
    CHANGING
      cs_input_paramters TYPE any.

ENDINTERFACE.
