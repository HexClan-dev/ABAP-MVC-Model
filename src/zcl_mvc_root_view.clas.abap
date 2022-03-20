CLASS zcl_mvc_root_view DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: zif_mvc_root_view FINAL METHODS
        add_parameter
        add_parameters
        get_parameters
        update_parameters.


    ALIASES update_parameters
      FOR zif_mvc_root_view~update_parameters.

    ALIASES get_parameters
      FOR zif_mvc_root_view~get_parameters.


    ALIASES add_parameter
      FOR zif_mvc_root_view~add_parameter.

    ALIASES add_parameters
      FOR zif_mvc_root_view~add_parameters.

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
    me->mo_parameters->update_parameters( is_parameters = ir_data_param ).

  ENDMETHOD.

  METHOD add_parameter.
    " Add Parameter
    DATA: ls_parameter_structure TYPE zcl_mvc_parameters=>ty_parameter.

    ls_parameter_structure =  VALUE #( name = iv_param_name value = ir_param_value ).
    me->mo_parameters->add_parameter( is_parameter = ls_parameter_structure ).

  ENDMETHOD.

  METHOD get_parameters.
    " Get the Assigned Parameters
    me->mo_parameters->get_parameters(
      CHANGING
        cs_parameters = cs_input_paramters
    ).

  ENDMETHOD.


  METHOD add_parameters.
    " Add Multiple Parameters
    me->mo_parameters->add_parameters( is_parameters = ir_params ).
  ENDMETHOD.

ENDCLASS.
