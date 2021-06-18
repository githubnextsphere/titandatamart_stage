view: fact_moveupsbygenerationandlevel {
  sql_table_name: stage_tbeaggregation.fact_moveupsbygenerationandlevel ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: distributor {
    type: string
    sql: ${TABLE}.distributor ;;
  }

  dimension: distributorid {
    type: number
    value_format_name: id
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

  dimension: generation {
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: level10 {
    type: number
    sql: ${TABLE}.level10 ;;
  }

  dimension: level11 {
    type: number
    sql: ${TABLE}.level11 ;;
  }

  dimension: level12 {
    type: number
    sql: ${TABLE}.level12 ;;
  }

  dimension: level13 {
    type: number
    sql: ${TABLE}.level13 ;;
  }

  dimension: level14 {
    type: number
    sql: ${TABLE}.level14 ;;
  }

  dimension: level2 {
    type: number
    sql: ${TABLE}.level2 ;;
  }

  dimension: level3 {
    type: number
    sql: ${TABLE}.level3 ;;
  }

  dimension: level4 {
    type: number
    sql: ${TABLE}.level4 ;;
  }

  dimension: level5 {
    type: number
    sql: ${TABLE}.level5 ;;
  }

  dimension: level6 {
    type: number
    sql: ${TABLE}.level6 ;;
  }

  dimension: level7 {
    type: number
    sql: ${TABLE}.level7 ;;
  }

  dimension: level8 {
    type: number
    sql: ${TABLE}.level8 ;;
  }

  dimension: level9 {
    type: number
    sql: ${TABLE}.level9 ;;
  }

  dimension: moveupsbygenerationandlevelkey {
    type: number
    sql: ${TABLE}.moveupsbygenerationandlevelkey ;;
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
