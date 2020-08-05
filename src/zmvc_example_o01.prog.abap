*----------------------------------------------------------------------*
***INCLUDE ZMVC_EXAMPLE_O01.
*----------------------------------------------------------------------*



*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  mo_mng->get_con_dynpro(  )->pbo( ).
  mo_mng->get_con_dynpro( '0100' )->zif_parameters~get_parameters( CHANGING cs_input_paramters = gs_scr100_param ).

ENDMODULE.



*&---------------------------------------------------------------------*
*& Module STATUS_0110 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0110 OUTPUT.

  mo_mng->get_con_dynpro( '0110' )->pbo( ).
  mo_mng->get_con_dynpro( )->zif_parameters~get_parameters( CHANGING cs_input_paramters = gs_scr_110_param ).

ENDMODULE.
