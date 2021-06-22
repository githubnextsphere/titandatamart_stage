view: tbeprod_fact_emmgrsindownline {
  sql_table_name: prod2aggregation.fact_emmgrsindownline ;;

  dimension: distributorid {
    type: string
    sql: lpad(${TABLE}.distributorid ,12,0) ;;
  }

  filter: fboidfilter {
    type: string
    sql: {% condition fboidfilter %} ${fbo_id_f1} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f2} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f3} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f4} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f5} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f6} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f7} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f8} {% endcondition %}
    or {% condition fboidfilter %} ${fbo_id_f9} {% endcondition %};;
    suggest_dimension: fbo_id_f1
  }

  dimension: fbo_id_f1 {
    type: string
    description: "FBO ID (000-000-000-000)"
    sql: SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 1,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3)
      + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 7,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3);;
  }

  dimension: fbo_id_f2 {
    type: string
    description: "FBO ID (000000000000)"
    sql: lpad(${TABLE}.distributorid ,12,0) ;;
  }

  dimension: fbo_id_f3 {
    type: string
    description: "FBO ID (000 000 000 000)"
    sql: SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 1,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3)
      + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 7,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }

  dimension: fbo_id_f4 {
    type: string
    label: "FBO ID F4"
    description: "FBO ID (000 000-000-000)"
    sql:SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 1,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 7,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }

  dimension: fbo_id_f5 {
    type: string
    label: "FBO ID F5"
    description: "FBO ID (000 000 000-000)"
    sql:SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 1,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 7,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }

  dimension: fbo_id_f6 {
    type: string
    label: "FBO ID F6"
    description: "FBO ID (000-000 000 000)"
    sql:SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 1,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 7,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }

  dimension: fbo_id_f7 {
    type: string
    label: "FBO ID F7"
    description: "FBO ID (000-000-000 000)"
    sql:SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 1,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 7,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }

  dimension: fbo_id_f8 {
    type: string
    label: "FBO ID F8"
    description: "FBO ID (000 000-000 000)"
    sql:SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 1,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 7,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }

  dimension: fbo_id_f9 {
    type: string
    label: "FBO ID F9"
    description: "FBO ID (000-000 000-000)"
    sql:SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 1,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 4,3) + ' ' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0), 7,3) + '-' + SUBSTRING(lpad(${TABLE}.distributorid ,12,0) , 10,3) ;;
  }


  dimension: emmgrsindownlinekey {
    type: number
    sql: ${TABLE}.emmgrsindownlinekey ;;
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
    sql:  lpad(${TABLE}.mgr_id,12,0) ;;
  }

  dimension: mgrfirstname {
    type: string
    sql: ${TABLE}.mgrfirstname ;;
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
    drill_fields: [mgrlastname, mgrfirstname]
  }

  set: detail {
    fields: [fboidfilter,
      fbo_id_f1,
      fbo_id_f2,
      fbo_id_f3,
      fbo_id_f4,
      fbo_id_f5,
      fbo_id_f6,
      fbo_id_f7,
      fbo_id_f8,
      fbo_id_f9,
      mgr_id
    ]
  }

}
