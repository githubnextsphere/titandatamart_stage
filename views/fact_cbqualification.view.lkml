view: fact_cbqualification {
  sql_table_name: stage_tbeaggregation.fact_cbqualification ;;

  dimension: 600ccmgrlines {
    type: number
    sql: ${TABLE}."600ccmgrlines" ;;
  }

  dimension: activeallmonths {
    type: number
    sql: ${TABLE}.activeallmonths ;;
  }

  dimension: cblines {
    type: number
    sql: ${TABLE}.cblines ;;
  }

  dimension: cbqualificationkey {
    type: number
    sql: ${TABLE}.cbqualificationkey ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: downline600ccmgrcount {
    type: number
    sql: ${TABLE}.downline600ccmgrcount ;;
  }

  dimension: downlinecbcount {
    type: number
    sql: ${TABLE}.downlinecbcount ;;
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

  dimension: f2dearner {
    type: number
    sql: ${TABLE}.f2dearner ;;
  }

  dimension: homecountry {
    type: string
    sql: ${TABLE}.homecountry ;;
  }

  dimension: level {
    type: number
    sql: ${TABLE}.level ;;
  }

  dimension: mgrfirstmonth {
    type: number
    sql: ${TABLE}.mgrfirstmonth ;;
  }

  dimension: mgrfirstmonthopengroupcc {
    type: number
    sql: ${TABLE}.mgrfirstmonthopengroupcc ;;
  }

  dimension: mgrfirstmonthtotalcc {
    type: number
    sql: ${TABLE}.mgrfirstmonthtotalcc ;;
  }

  dimension: newcc_oqc {
    type: number
    sql: ${TABLE}.newcc_oqc ;;
  }

  dimension: newcc_qc {
    type: number
    sql: ${TABLE}.newcc_qc ;;
  }

  dimension: newccglobalcap {
    type: number
    sql: ${TABLE}.newccglobalcap ;;
  }

  dimension: opengroupcc_qc {
    type: number
    sql: ${TABLE}.opengroupcc_qc ;;
  }

  dimension: opengroupccglobalcap {
    type: number
    sql: ${TABLE}.opengroupccglobalcap ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: qualifyingcountry {
    type: string
    sql: ${TABLE}.qualifyingcountry ;;
  }

  dimension: totalcc_qc {
    type: number
    sql: ${TABLE}.totalcc_qc ;;
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
