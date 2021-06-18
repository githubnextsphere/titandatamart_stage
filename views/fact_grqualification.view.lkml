view: fact_grqualification {
  sql_table_name: stage_tbeaggregation.fact_grqualification ;;

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

  dimension: grqualificationkey {
    type: number
    sql: ${TABLE}.grqualificationkey ;;
  }

  dimension: homecountry {
    type: string
    sql: ${TABLE}.homecountry ;;
  }

  dimension: level {
    type: number
    sql: ${TABLE}.level ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: totalcc {
    type: number
    sql: ${TABLE}.totalcc ;;
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

  dimension: waivers {
    type: string
    sql: ${TABLE}.waivers ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
