view: tbeprod_dim_levels {
  sql_table_name: prod_as400.dim_levels ;;

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: ismanager {
    type: number
    sql: ${TABLE}.ismanager ;;
  }

  dimension: key {
    type: number
    sql: ${TABLE}.key ;;
  }

  dimension: leveldetailskey {
    type: number
    sql: ${TABLE}.leveldetailskey ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
