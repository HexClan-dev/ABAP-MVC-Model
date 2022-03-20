INTERFACE zif_mvc_root_controller
  PUBLIC .

  INTERFACES:
    zif_mvc_controller_list,
    zif_mvc_parameters.

  " Note the parameters are assigned before the controller is called

  METHODS:
    pai
      IMPORTING
        iv_ok_code LIKE sy-ucomm DEFAULT sy-ucomm,
*        ir_data_param TYPE any OPTIONAL,
    pbo.
*      CHANGING
*        cs_input_paramters TYPE any OPTIONAL.


ENDINTERFACE.
