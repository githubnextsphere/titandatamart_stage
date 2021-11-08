view: fact_cbmgrsindownline {
  sql_table_name: prod2aggregation_tbe.fact_cbmgrsindownline ;;

  dimension: cbmgrsindownlinekey {
    type: number
    sql: ${TABLE}.cbmgrsindownlinekey ;;
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

  dimension: mgr_id {
    type: string
    sql: ${TABLE}.mgr_id ;;
  }

  dimension: mgrfirstname {
    type: string
    sql: ${TABLE}.mgrfirstname ;;
  }

  dimension: isdelete {
    type: string
    sql: ${TABLE}.isdelete ;;
  }
  dimension: mgrlastname {
    type: string
    sql: ${TABLE}.mgrlastname ;;
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
    drill_fields: [mgrfirstname, mgrlastname]
  }
}
