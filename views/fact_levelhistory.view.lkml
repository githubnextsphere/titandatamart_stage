view: fact_levelhistory {
  sql_table_name: stage_tbeaggregation.fact_levelhistory ;;

  dimension_group: changedate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.changedate ;;
  }

  dimension: changetype {
    type: string
    sql: ${TABLE}.changetype ;;
  }

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

  dimension: homecountry {
    type: string
    sql: ${TABLE}.homecountry ;;
  }

  dimension: lastrecbyper {
    type: number
    sql: ${TABLE}.lastrecbyper ;;
  }

  dimension: levelhistorykey {
    type: number
    sql: ${TABLE}.levelhistorykey ;;
  }

  dimension_group: qualdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.qualdate ;;
  }

  dimension: qualperiod {
    type: number
    sql: ${TABLE}.qualperiod ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: recordid {
    type: number
    value_format_name: id
    sql: ${TABLE}.recordid ;;
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
