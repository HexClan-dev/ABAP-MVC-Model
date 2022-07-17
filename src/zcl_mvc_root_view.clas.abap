CLASS zcl_mvc_root_view DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: zif_mvc_root_view FINAL METHODS
      zif_mvc_parameters~set_parameter
      zif_mvc_parameters~set_parameters
      zif_mvc_parameters~get_parameters
      zif_mvc_parameters~get_parameter
      zif_mvc_parameters~delete_parameter
      zif_mvc_parameters~update_parameters.


    ALIASES update_parameters
      FOR zif_mvc_parameters~update_parameters.
    ALIASES get_parameter
      FOR zif_mvc_parameters~get_parameter.
    ALIASES get_parameters
      FOR zif_mvc_parameters~get_parameters.
    ALIASES set_parameter
      FOR zif_mvc_parameters~set_parameter.
    ALIASES set_parameters
      FOR zif_mvc_parameters~set_parameters.
    ALIASES delete_parameter
      FOR zif_mvc_parameters~delete_parameter.


    METHODS: constructor.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: mo_parameters TYPE REF TO zcl_mvc_parameters.

ENDCLASS.



CLASS zcl_mvc_root_view IMPLEMENTATION.



  METHOD constructor.
    " Initialize the parameters handler
    me->mo_parameters = NEW zcl_mvc_parameters(  ).

  ENDMETHOD.


  METHOD update_parameters.
    " Generic input structure
    me->mo_parameters->update_parameters( CHANGING cs_parameters = cs_parameters ).

  ENDMETHOD.

  METHOD set_parameter.
    " Add Parameter
    DATA: ls_parameter_structure TYPE zif_mvc_parameters=>ty_parameter.

*    ls_parameter_structure =  VALUE #( name = iv_param_name value = ir_param_value ).
    me->mo_parameters->set_parameter( iv_param_name = iv_param_name ir_param_value = ir_param_value ).

  ENDMETHOD.

  METHOD get_parameters.
    " Get the Assigned Parameters
    me->mo_parameters->get_parameters(
      IMPORTING
        es_input_paramters = es_input_paramters
    ).

  ENDMETHOD.

  METHOD set_parameters.
    " Add Multiple Parameters
    me->mo_parameters->set_parameters( ir_param_value = ir_param_value ).
  ENDMETHOD.


  METHOD delete_parameter.
    " Add Multiple Parameters
    me->mo_parameters->delete_parameter( iv_parameter = iv_parameter ).
  ENDMETHOD.

ENDCLASS.
