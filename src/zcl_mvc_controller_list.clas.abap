CLASS zcl_mvc_controller_list DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      offer_first
        IMPORTING
                  iv_item_name   TYPE string
                  io_object      TYPE REF TO zif_mvc_controller_list
        RETURNING VALUE(ro_item) TYPE REF TO zif_mvc_controller_list,

      offer_last
        IMPORTING
                  iv_item_name   TYPE string
                  io_object      TYPE REF TO zif_mvc_controller_list
        RETURNING VALUE(ro_item) TYPE REF TO zif_mvc_controller_list,

      get_item
        IMPORTING
                  iv_item_name   TYPE string
        RETURNING VALUE(ro_item) TYPE REF TO zif_mvc_controller_list,

      get_first
        RETURNING VALUE(ro_item) TYPE REF TO zif_mvc_controller_list,

      get_last
        RETURNING VALUE(ro_item) TYPE REF TO zif_mvc_controller_list,

      poll_first
        RETURNING VALUE(ro_del_itm) TYPE REF TO zif_mvc_controller_list,

      poll_last
        RETURNING VALUE(ro_del_itm) TYPE REF TO zif_mvc_controller_list,

      poll_item
        IMPORTING iv_item_name      TYPE string
        RETURNING VALUE(ro_del_itm) TYPE REF TO zif_mvc_controller_list,

      get_size
        RETURNING VALUE(rv_size) TYPE i,

      exists
        IMPORTING
                  iv_item_name    TYPE string
        RETURNING VALUE(rv_exist) TYPE abap_bool,

      clear_all.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: mt_linked_list TYPE HASHED TABLE OF ty_s_list WITH UNIQUE KEY id object_name.

    DATA: mv_first_item_id TYPE ty_uuid,
          mv_last_item_id  TYPE ty_uuid,
          mv_size          TYPE i.



    METHODS:
      generate_uuid
        RETURNING VALUE(rv_uuid) TYPE ty_uuid,

*      get_object_name
*        IMPORTING io_item            TYPE REF TO zif_linked_list
*        RETURNING VALUE(rv_obj_name) TYPE obj_name,

      read_item
        IMPORTING
                  iv_item_uuid   TYPE ty_uuid OPTIONAL
                  iv_item_name   TYPE string OPTIONAL
                    PREFERRED PARAMETER iv_item_uuid
        RETURNING VALUE(rs_item) TYPE ty_s_list,

      update_item
        IMPORTING
                  is_item           TYPE ty_s_list
        RETURNING VALUE(rv_updated) TYPE abap_bool,

      delete_item
        IMPORTING
                  iv_item_uuid          TYPE ty_uuid OPTIONAL
                  iv_item_name          TYPE string OPTIONAL
                    PREFERRED PARAMETER iv_item_uuid
        RETURNING VALUE(rs_deleted_itm) TYPE ty_s_list.

ENDCLASS.



CLASS zcl_mvc_controller_list IMPLEMENTATION.

  METHOD clear_all.
    CLEAR: mt_linked_list, mt_linked_list[], mv_first_item_id, mv_last_item_id.
  ENDMETHOD.

  METHOD generate_uuid.
    TRY.
        rv_uuid =  cl_system_uuid=>create_uuid_c32_static( ).
      CATCH cx_uuid_error INTO DATA(lo_err).
        " handle the error
    ENDTRY.
  ENDMETHOD.

  METHOD exists.
    " Check if the item exist in the linked-list
    READ TABLE mt_linked_list INTO DATA(ls_st) WITH KEY object_name = iv_item_name.

    IF sy-subrc = 0.
      rv_exist = abap_true.
    ELSE.
      rv_exist = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD get_first.
    ro_item = me->read_item( iv_item_uuid = mv_first_item_id )-object.
  ENDMETHOD.

  METHOD get_item.
    ro_item = me->read_item( iv_item_name = iv_item_name )-object.
  ENDMETHOD.

  METHOD get_size.
    rv_size = me->mv_size.
  ENDMETHOD.

  METHOD get_last.
    ro_item = me->read_item( iv_item_uuid = mv_last_item_id )-object.
  ENDMETHOD.

  METHOD offer_first.

    DATA: ls_item TYPE ty_s_list.

    ls_item-id = me->generate_uuid( ).
    ls_item-object = io_object.
    ls_item-object_name = iv_item_name."me->get_object_name( io_item ).

    IF mv_first_item_id IS INITIAL AND mv_last_item_id IS INITIAL.
      INSERT ls_item INTO TABLE mt_linked_list.
      mv_last_item_id  = mv_first_item_id = ls_item-id.
    ELSE.

      DATA(ls_1st_itm) = me->read_item( iv_item_uuid = me->mv_first_item_id ).
      ls_item-next_id = ls_1st_itm-id.
      INSERT ls_item INTO TABLE mt_linked_list.

      IF sy-subrc = 0.
        ls_1st_itm-prv_id = ls_item-id.
        me->update_item( ls_1st_itm ).

        " change the cl parameter with the first item
        me->mv_first_item_id = ls_item-id.
      ENDIF.

    ENDIF.

    ADD 1 TO me->mv_size.

    ro_item = ls_item-object.

  ENDMETHOD.

  METHOD offer_last.
    "Assign the item
    DATA: ls_item TYPE ty_s_list.

    ls_item-id = me->generate_uuid( ).
    ls_item-object = io_object.
    ls_item-object_name = iv_item_name."me->get_object_name( io_item ).

    IF mv_first_item_id IS INITIAL AND mv_last_item_id IS INITIAL.
      INSERT ls_item INTO TABLE mt_linked_list.
      mv_last_item_id  = mv_first_item_id = ls_item-id.
    ELSE.

      DATA(ls_lasst_itm) = me->read_item( iv_item_uuid = me->mv_last_item_id ).
      ls_item-prv_id = ls_lasst_itm-id.
      INSERT ls_item INTO TABLE mt_linked_list.

      IF sy-subrc = 0.
        ls_lasst_itm-next_id = ls_item-id.
        me->update_item( ls_lasst_itm ).

        " change the cl parameter with the first item
        me->mv_last_item_id = ls_item-id.
      ENDIF.
    ENDIF.

    ADD 1 TO me->mv_size.

    ro_item = ls_item-object.

  ENDMETHOD.

  METHOD poll_first.
    " Delete the firts item
    DATA(ls_del_item) = me->delete_item( iv_item_uuid = me->mv_first_item_id ).

    me->mv_first_item_id = ls_del_item-next_id.
    DATA(ls_itm) = me->read_item( ls_del_item-next_id ).
    CLEAR ls_itm-prv_id.

    me->update_item( ls_itm ).

    SUBTRACT 1 FROM me->mv_size.
  ENDMETHOD.

  METHOD poll_last.
    " Delete the firts item
    DATA(ls_del_item) = me->delete_item( iv_item_uuid = me->mv_last_item_id ).

    me->mv_last_item_id = ls_del_item-prv_id.
    DATA(ls_itm) = me->read_item( ls_del_item-prv_id ).
    CLEAR ls_itm-next_id.

    me->update_item( ls_itm ).

    SUBTRACT 1 FROM me->mv_size.
  ENDMETHOD.

  METHOD poll_item.
    DATA(ls_itm) = me->read_item( iv_item_name = iv_item_name ).

    IF ls_itm-id = me->mv_first_item_id.
      ro_del_itm = me->poll_first( ).
    ELSEIF ls_itm-id = me->mv_last_item_id.
      ro_del_itm = me->poll_last( ).
    ELSE.
      " Read the items
      DATA(ls_prv_itm) = me->read_item( iv_item_uuid = ls_itm-prv_id ).
      DATA(ls_nxt_itm) = me->read_item( iv_item_uuid = ls_itm-next_id ).

      ls_prv_itm-next_id = ls_nxt_itm-id.
      ls_nxt_itm-prv_id = ls_prv_itm-id.

      me->update_item( ls_prv_itm ).
      me->update_item( ls_nxt_itm ).

      ro_del_itm = ls_itm-object.
    ENDIF.

    SUBTRACT 1 FROM me->mv_size.

  ENDMETHOD.

  METHOD update_item.
    " update the structure of the linked list
    MODIFY TABLE me->mt_linked_list FROM is_item.

    IF sy-subrc = 0.
      rv_updated = abap_true.
    ELSE.
      rv_updated = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD read_item.
    " read item by using item_uuid or bu providing the name of the object name
    IF iv_item_uuid IS SUPPLIED.
      READ TABLE me->mt_linked_list WITH KEY id = iv_item_uuid INTO DATA(ls_item).
    ELSEIF iv_item_name IS SUPPLIED.
      READ TABLE me->mt_linked_list WITH KEY object_name = iv_item_name INTO ls_item.
    ENDIF.

    IF sy-subrc = 0.
      rs_item = ls_item.
    ENDIF.
  ENDMETHOD.

  METHOD delete_item.
    " delete and return the deleted item
    " read the item by providing the uuid or the item name
    DATA(ls_itm) = me->read_item( iv_item_uuid = iv_item_uuid iv_item_name = iv_item_name ).

    " delete the item by providing the item uuid
    me->delete_item( iv_item_uuid = ls_itm-id ).
    rs_deleted_itm = ls_itm.
  ENDMETHOD.

ENDCLASS.
