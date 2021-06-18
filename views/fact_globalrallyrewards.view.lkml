view: fact_globalrallyrewards {
  sql_table_name: stage_tbeaggregation.fact_globalrallyrewards ;;

  dimension: activity {
    type: string
    sql: ${TABLE}.activity ;;
  }

  dimension: airfare {
    type: string
    sql: ${TABLE}.airfare ;;
  }

  dimension: cashbonus {
    type: number
    sql: ${TABLE}.cashbonus ;;
  }

  dimension: datasource {
    type: string
    sql: ${TABLE}.datasource ;;
  }

  dimension: globalcc {
    type: number
    sql: ${TABLE}.globalcc ;;
  }

  dimension: grrewardskey {
    type: number
    sql: ${TABLE}.grrewardskey ;;
  }

  dimension: level {
    type: number
    sql: ${TABLE}.level ;;
  }

  dimension: leveldisplayed {
    type: string
    sql: ${TABLE}.leveldisplayed ;;
  }

  dimension: lodging {
    type: string
    sql: ${TABLE}.lodging ;;
  }

  dimension: spendingcash {
    type: number
    sql: ${TABLE}.spendingcash ;;
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

  dimension: vipcheckout {
    type: string
    sql: ${TABLE}.vipcheckout ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
