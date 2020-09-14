INTERFACE zif_subscreen_controller
  PUBLIC .

  INTERFACES: zif_mvc_root_controller.

  METHODS:
*    view RETURNING VALUE(ro_view) TYPE REF TO zif_mvc_root_view,
    pai
      IMPORTING
        iv_ok_code    LIKE sy-ucomm DEFAULT sy-ucomm
        ir_data_param TYPE any OPTIONAL,
    pbo
      CHANGING
        cs_input_paramters TYPE any OPTIONAL.

ENDINTERFACE.
