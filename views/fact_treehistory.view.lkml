view: fact_treehistory {
  sql_table_name: stage_tbeaggregation.fact_treehistory ;;

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension_group: effectivefrom {
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
    sql: ${TABLE}.effectivefrom ;;
  }

  dimension: effectivefrommonth {
    type: number
    sql: ${TABLE}.effectivefrommonth ;;
  }

  dimension: effectivefromyear {
    type: number
    sql: ${TABLE}.effectivefromyear ;;
  }

  dimension_group: effectiveto {
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
    sql: ${TABLE}.effectiveto ;;
  }

  dimension: effectivetomonth {
    type: number
    sql: ${TABLE}.effectivetomonth ;;
  }

  dimension: effectivetoyear {
    type: number
    sql: ${TABLE}.effectivetoyear ;;
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

  dimension: memberchangedate {
    type: number
    sql: ${TABLE}.memberchangedate ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: sponsordistributorid {
    type: string
    sql: ${TABLE}.sponsordistributorid ;;
  }

  dimension: treehistorykey {
    type: number
    sql: ${TABLE}.treehistorykey ;;
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
