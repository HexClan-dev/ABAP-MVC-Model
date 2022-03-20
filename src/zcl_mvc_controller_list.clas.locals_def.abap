*"* use this source file for any type of declarations (class
*"* definitions, interfaces or type declarations) you need for
*"* components in the private section


TYPES: ty_uuid TYPE c LENGTH 32.

TYPES: BEGIN OF ty_s_list,
         id          TYPE ty_uuid,
         object_name TYPE string,
         prv_id      TYPE ty_uuid,
         next_id     TYPE ty_uuid,
         object      TYPE REF TO zif_mvc_controller_list,
       END OF ty_s_list.
