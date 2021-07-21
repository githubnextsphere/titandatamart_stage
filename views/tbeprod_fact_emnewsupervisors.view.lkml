view: tbeprod_fact_emnewsupervisors {
  sql_table_name: prod2aggregation.fact_emnewsupervisors ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: emnewsupervisorskey {
    type: number
    sql: ${TABLE}.emnewsupervisorskey ;;
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

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: supervisorid {
    type: string
    sql: ${TABLE}.supervisorid ;;
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
