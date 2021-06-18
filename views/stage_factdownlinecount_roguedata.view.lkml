view: stage_factdownlinecount_roguedata {
  sql_table_name: stage_tbeaggregation.stage_factdownlinecount_roguedata ;;

  dimension: countrycode {
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
