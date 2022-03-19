INTERFACE zif_mvc_root_controller
  PUBLIC .

  INTERFACES:
    zif_linked_list,
    zif_parameters.

  METHODS:
    pai
      IMPORTING
        iv_ok_code    LIKE sy-ucomm DEFAULT sy-ucomm
        ir_data_param TYPE any OPTIONAL,
    pbo
      CHANGING
        cs_input_paramters TYPE any OPTIONAL.

*  METHODS:
*
*    get_screen_nr
*      RETURNING VALUE(rv_scr_nr) LIKE sy-dynnr.

ENDINTERFACE.
