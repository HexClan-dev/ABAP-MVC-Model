CLASS zcl_mvc_sub_sc110_controller DEFINITION INHERITING FROM zcl_mvc_root_sub_controller
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACEs: zif_subscreen_controller.

    METHODS: controller.

    METHODS:
      proces_after_input REDEFINITION,
      process_before_output REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_mvc_sub_sc110_controller IMPLEMENTATION.

  METHOD controller.
    " set the subscreen number for the sub scr controller
    me->set_sub_screen_nr( '0110' ) .
  ENDMETHOD.

  METHOD process_before_output.

  ENDMETHOD.

  METHOD proces_after_input.
    "PAI checking for Subscreen Controller
    CASE iv_ok_code.
      WHEN ''.

    ENDCASE.

  ENDMETHOD.

ENDCLASS.
