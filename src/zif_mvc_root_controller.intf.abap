INTERFACE zif_mvc_root_controller
  PUBLIC .

  INTERFACES:
    zif_linked_list,
    zif_parameters.

  METHODS:
*    view RETURNING VALUE(ro_view) TYPE REF TO zif_mvc_root_view,
    pai IMPORTING iv_ok_code LIKE sy-ucomm DEFAULT sy-ucomm,
    pbo.

  METHODS:
    get_screen_nr
      RETURNING VALUE(rv_scr_nr) LIKE sy-dynnr.

ENDINTERFACE.
