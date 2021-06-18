view: fact_emqualification {
  sql_table_name: prod2aggregation.fact_emqualification ;;

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: downlineemcount {
    type: number
    sql: ${TABLE}.downlineemcount ;;
  }

  dimension: emlevel {
    type: number
    sql: ${TABLE}.emlevel ;;
  }

  dimension: emlines {
    type: number
    sql: ${TABLE}.emlines ;;
  }

  dimension: emqualificationkey {
    type: number
    sql: ${TABLE}.emqualificationkey ;;
  }

  dimension: endlevel {
    type: number
    sql: ${TABLE}.endlevel ;;
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

  dimension: homecountryactive {
    type: number
    sql: ${TABLE}.homecountryactive ;;
  }

  dimension: isemeligible {
    type: number
    sql: ${TABLE}.isemeligible ;;
  }

  dimension: isnewsupervisor {
    type: number
    sql: ${TABLE}.isnewsupervisor ;;
  }

  dimension: mgrfirstmonth {
    type: number
    sql: ${TABLE}.mgrfirstmonth ;;
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

  dimension: newsupervisorscount {
    type: number
    sql: ${TABLE}.newsupervisorscount ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
  }

  dimension: qualifyingcountry {
    type: string
    sql: ${TABLE}.qualifyingcountry ;;
  }

  dimension: startlevel {
    type: number
    sql: ${TABLE}.startlevel ;;
  }

  dimension: totalcc_qc {
    type: number
    sql: ${TABLE}.totalcc_qc ;;
  }

  dimension: totalccglobalcap {
    type: number
    sql: ${TABLE}.totalccglobalcap ;;
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
