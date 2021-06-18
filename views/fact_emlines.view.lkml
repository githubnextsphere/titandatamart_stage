view: fact_emlines {
  sql_table_name: stage_tbeaggregation.fact_emlines ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: downlineemcount {
    type: number
    sql: ${TABLE}.downlineemcount ;;
  }

  dimension: em_id {
    type: string
    sql: ${TABLE}.em_id ;;
  }

  dimension: emlevel {
    type: number
    sql: ${TABLE}.emlevel ;;
  }

  dimension: emlineskey {
    type: number
    sql: ${TABLE}.emlineskey ;;
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
