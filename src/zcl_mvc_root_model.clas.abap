CLASS zcl_mvc_root_model DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: zif_mvc_root_model
      FINAL METHODS define_view.

    ALIASES define_view
      FOR zif_mvc_root_model~define_view.


  PROTECTED SECTION.
    DATA: mo_view  TYPE REF TO zif_mvc_root_view.

  PRIVATE SECTION.



ENDCLASS.



CLASS zcl_mvc_root_model IMPLEMENTATION.

  METHOD define_view.
    " Add the View information
    me->mo_view = io_view.

  ENDMETHOD.

ENDCLASS.
