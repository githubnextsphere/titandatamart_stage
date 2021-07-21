view: fact_emindownline {
  sql_table_name: prod2aggregation.fact_emindownline ;;

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: em_id {
    type: string
    sql: ${TABLE}.em_id ;;
  }

  dimension: emindownlinekey {
    type: number
    sql: ${TABLE}.emindownlinekey ;;
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
