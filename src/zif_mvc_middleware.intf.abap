INTERFACE zif_mvc_middleware
  PUBLIC .

  METHODS:
    get_params
      EXPORTING es_parameter         TYPE any
      RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

  METHODS:
    set_params
      IMPORTING is_parameter         TYPE any OPTIONAL
      RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

  METHODS:
    update_params
      CHANGING cs_parameter         TYPE any
      RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.


  METHODS:
    delete_params
      IMPORTING iv_param_name        TYPE char50
      RETURNING VALUE(ro_controller) TYPE REF TO zif_mvc_controller.

ENDINTERFACE.
