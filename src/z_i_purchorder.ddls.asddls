@AbapCatalog.sqlViewName: 'ZIPURCHORDER'
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #BASIC
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Basic CDS View'

define view Z_I_PurchOrder as select from zdns_tree_item {
    key class as class_type,
    node_key as key_node
}
