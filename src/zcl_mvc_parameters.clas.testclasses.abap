*"* use this source file for your ABAP unit test classes




CLASS lcl_unit_testing DEFINITION
    FOR TESTING
    FINAL
    RISK LEVEL HARMLESS
    DURATION SHORT .

  PUBLIC SECTION.

    METHODS:
      settup FOR TESTING,
      handle_parameters FOR TESTING.


ENDCLASS.


CLASS lcl_unit_testing IMPLEMENTATION.


  METHOD settup.

  ENDMETHOD.

  METHOD handle_parameters.

    DATA(lo_mvc_params) = NEW zcl_mvc_parameters( ).

    TRY.

        TYPES: BEGIN OF ty_prm1,
                 val  TYPE string,
                 val2 TYPE string,
               END OF ty_prm1.

        DATA: ls_params_exp TYPE ty_prm1.

        DATA(ls_params) = VALUE ty_prm1( val = 'val1ee' val2 = 'valee' ).
        lo_mvc_params->set_parameters( ir_param_value = ls_params ).

        ls_params = VALUE ty_prm1( val = 'Nail' ).
        lo_mvc_params->update_parameters(  CHANGING cs_parameters = ls_params ).

        cl_abap_unit_assert=>assert_false(
                    act              = abap_false                             " Actual data object
                ).


        lo_mvc_params->get_parameters( IMPORTING es_input_paramters = ls_params_exp ).

        cl_abap_unit_assert=>assert_not_initial( act = ls_params ).
        cl_abap_unit_assert=>assert_equals( act = ls_params_exp-val exp = ls_params-val ).
        cl_abap_unit_assert=>assert_equals( act = ls_params_exp-val2 exp = ls_params-val2 ).

      CATCH cx_root.
        cl_abap_unit_assert=>assert_false(
            act              = abap_true                             " Actual data object
        ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
