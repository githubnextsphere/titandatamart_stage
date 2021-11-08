view: fact_cb600ccindownline {
  sql_table_name: prod2aggregation_tbe.fact_cb600ccindownline ;;

  dimension: 600cc_id {
    type: string
    sql: ${TABLE}."600cc_id" ;;
  }

  dimension: cb600ccindownlinekey {
    type: number
    sql: ${TABLE}.cb600ccindownlinekey ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
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

  dimension: isdelete {
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: qualifyingcountry {
    type: string
    sql: ${TABLE}.qualifyingcountry ;;
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
