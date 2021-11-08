view: fact_cb600cclines {
  sql_table_name: prod2aggregation_tbe.fact_cb600cclines ;;

  dimension: 600cc_id {
    type: string
    sql: ${TABLE}."600cc_id" ;;
  }

  dimension: cb600cclineskey {
    type: number
    sql: ${TABLE}.cb600cclineskey ;;
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

  dimension: isdelete {
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: downline60cccount {
    type: number
    sql: ${TABLE}.downline60cccount ;;
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
