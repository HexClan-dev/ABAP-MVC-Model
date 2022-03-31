*----------------------------------------------------------------------*
***INCLUDE ZMVC_EXAMPLE_O01.
*----------------------------------------------------------------------*



*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0111'.

  mo_mng->get_dynpro( )->get_params(
        CHANGING cs_parameter = gs_main_param
    )->pbo( ).

ENDMODULE.



*&---------------------------------------------------------------------*
*& Module STATUS_0110 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0110 OUTPUT.

*  mo_mng->get_dynpro( '0110' )->get_params(
*        CHANGING cs_parameter = gs_main_param
*    )->pbo(  ).

ENDMODULE.


*&---------------------------------------------------------------------*
*& Module STATUS_0111 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0111 OUTPUT.

  " This is called to call the PBO only
  mo_mng->get_dynpro( )->pbo( ).

ENDMODULE.
