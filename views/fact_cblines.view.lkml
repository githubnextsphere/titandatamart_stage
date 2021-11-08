view: fact_cblines {
  sql_table_name: prod2aggregation_tbe.fact_cblines ;;

  dimension: cb_id {
    type: string
    sql: ${TABLE}.cb_id ;;
  }

  dimension: isdelete {
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: cblevel {
    type: number
    sql: ${TABLE}.cblevel ;;
  }

  dimension: cblineskey {
    type: number
    sql: ${TABLE}.cblineskey ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: downlinecbcount {
    type: number
    sql: ${TABLE}.downlinecbcount ;;
  }

  dimension_group: entered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.entered ;;
  }

  dimension: frontlineid {
    type: string
    sql: ${TABLE}.frontlineid ;;
  }

  dimension: generation {
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension_group: validfrom {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.validfrom ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
