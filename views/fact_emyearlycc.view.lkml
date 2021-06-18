view: fact_emyearlycc {
  sql_table_name: stage_tbeaggregation.fact_emyearlycc ;;

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: downlineeaglemanagerqualifiers {
    type: number
    sql: ${TABLE}.downlineeaglemanagerqualifiers ;;
  }

  dimension: eaglemanagerglobalcc {
    type: number
    sql: ${TABLE}.eaglemanagerglobalcc ;;
  }

  dimension: eaglemanagerlevel {
    type: number
    sql: ${TABLE}.eaglemanagerlevel ;;
  }

  dimension: eaglemanagertotalcc {
    type: number
    sql: ${TABLE}.eaglemanagertotalcc ;;
  }

  dimension: emyearlycckey {
    type: number
    sql: ${TABLE}.emyearlycckey ;;
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

  dimension: homecountryeaglemanagercc {
    type: number
    sql: ${TABLE}.homecountryeaglemanagercc ;;
  }

  dimension: nonhomecountryeaglemanagercc {
    type: number
    sql: ${TABLE}.nonhomecountryeaglemanagercc ;;
  }

  dimension: numberofnewsupervisors {
    type: number
    sql: ${TABLE}.numberofnewsupervisors ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension_group: processingdate {
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
    sql: ${TABLE}.processingdate ;;
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
