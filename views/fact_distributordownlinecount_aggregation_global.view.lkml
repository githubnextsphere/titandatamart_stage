view: fact_distributordownlinecount_aggregation_global {
  sql_table_name: stage_tbeaggregation.fact_distributordownlinecount_aggregation_global ;;

  dimension: assistantmanagercount {
    type: number
    sql: ${TABLE}.assistantmanagercount ;;
  }

  dimension: assistantsupervisorcount {
    type: number
    sql: ${TABLE}.assistantsupervisorcount ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: diamondcenturionmanagercount {
    type: number
    sql: ${TABLE}.diamondcenturionmanagercount ;;
  }

  dimension: diamondmangercount {
    type: number
    sql: ${TABLE}.diamondmangercount ;;
  }

  dimension: diamondsapphiremanagercount {
    type: number
    sql: ${TABLE}.diamondsapphiremanagercount ;;
  }

  dimension: distributorcount {
    type: number
    sql: ${TABLE}.distributorcount ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: doublediamondmanagercount {
    type: number
    sql: ${TABLE}.doublediamondmanagercount ;;
  }

  dimension: downlinecount {
    type: number
    sql: ${TABLE}.downlinecount ;;
  }

  dimension: factdistributordownlinecountkey {
    type: number
    sql: ${TABLE}.factdistributordownlinecountkey ;;
  }

  dimension: managercount {
    type: number
    sql: ${TABLE}.managercount ;;
  }

  dimension: recognizedmanagercount {
    type: number
    sql: ${TABLE}.recognizedmanagercount ;;
  }

  dimension: sapphiremanagercount {
    type: number
    sql: ${TABLE}.sapphiremanagercount ;;
  }

  dimension: seniormanagercount {
    type: number
    sql: ${TABLE}.seniormanagercount ;;
  }

  dimension: soaringmanagercount {
    type: number
    sql: ${TABLE}.soaringmanagercount ;;
  }

  dimension: supervisorscount {
    type: number
    sql: ${TABLE}.supervisorscount ;;
  }

  dimension: triplediamondmanagercount {
    type: number
    sql: ${TABLE}.triplediamondmanagercount ;;
  }

  dimension: unrecognizedmanagercount {
    type: number
    sql: ${TABLE}.unrecognizedmanagercount ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
