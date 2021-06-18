view: stage_memberstats_roguedata {
  sql_table_name: stage_tbeaggregation.stage_memberstats_roguedata ;;

  dimension: countrycode {
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: distributorid {
    type: number
    value_format_name: id
    sql: ${TABLE}.distributorid ;;
  }

  dimension: processedmonth {
    type: number
    sql: ${TABLE}.processedmonth ;;
  }

  dimension: processedyear {
    type: number
    sql: ${TABLE}.processedyear ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
