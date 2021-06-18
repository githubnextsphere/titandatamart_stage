view: generationdetails_global {
  sql_table_name: stage_tbeaggregation.generationdetails_global ;;

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: generation {
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
