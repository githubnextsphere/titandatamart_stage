view: fact_memberstats_aggregation_global {
  sql_table_name: stage_tbeaggregation.fact_memberstats_aggregation_global ;;

  dimension: 4ccactivecount {
    type: number
    sql: ${TABLE}."4ccactivecount" ;;
  }

  dimension: activeexistingorderingdistributorscount {
    type: number
    sql: ${TABLE}.activeexistingorderingdistributorscount ;;
  }

  dimension: averageccvalue {
    type: number
    sql: ${TABLE}.averageccvalue ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: distributorid {
    type: number
    value_format_name: id
    sql: ${TABLE}.distributorid ;;
  }

  dimension: dowlinerecruitslevel1count {
    type: number
    sql: ${TABLE}.dowlinerecruitslevel1count ;;
  }

  dimension: dowlinerecruitslevel2count {
    type: number
    sql: ${TABLE}.dowlinerecruitslevel2count ;;
  }

  dimension: dowlinerecruitslevel3count {
    type: number
    sql: ${TABLE}.dowlinerecruitslevel3count ;;
  }

  dimension: existingorderingdistributorscount {
    type: number
    sql: ${TABLE}.existingorderingdistributorscount ;;
  }

  dimension: factaggregatedstatskey {
    type: number
    sql: ${TABLE}.factaggregatedstatskey ;;
  }

  dimension: monthlymoveupcount {
    type: number
    sql: ${TABLE}.monthlymoveupcount ;;
  }

  dimension: monthlynotordereddistributorcount {
    type: number
    sql: ${TABLE}.monthlynotordereddistributorcount ;;
  }

  dimension: monthlyordereddistributorcount {
    type: number
    sql: ${TABLE}.monthlyordereddistributorcount ;;
  }

  dimension: monthlytotalnewenrollmentscount {
    type: number
    sql: ${TABLE}.monthlytotalnewenrollmentscount ;;
  }

  dimension: monthtodateenrollments {
    type: number
    sql: ${TABLE}.monthtodateenrollments ;;
  }

  dimension: moveupassistantmanagercount {
    type: number
    sql: ${TABLE}.moveupassistantmanagercount ;;
  }

  dimension: moveupassistantsupervisorcount {
    type: number
    sql: ${TABLE}.moveupassistantsupervisorcount ;;
  }

  dimension: moveupdiamondmanagercount {
    type: number
    sql: ${TABLE}.moveupdiamondmanagercount ;;
  }

  dimension: moveupdiamondsapphiremanagercount {
    type: number
    sql: ${TABLE}.moveupdiamondsapphiremanagercount ;;
  }

  dimension: moveupdoublediamondmanagercount {
    type: number
    sql: ${TABLE}.moveupdoublediamondmanagercount ;;
  }

  dimension: moveupmanagercount {
    type: number
    sql: ${TABLE}.moveupmanagercount ;;
  }

  dimension: moveupsapphiremanagercount {
    type: number
    sql: ${TABLE}.moveupsapphiremanagercount ;;
  }

  dimension: moveupseniormanagercount {
    type: number
    sql: ${TABLE}.moveupseniormanagercount ;;
  }

  dimension: moveupsoaringmanagercount {
    type: number
    sql: ${TABLE}.moveupsoaringmanagercount ;;
  }

  dimension: moveupsupervisorcount {
    type: number
    sql: ${TABLE}.moveupsupervisorcount ;;
  }

  dimension: moveupunrecognizedmanagercount {
    type: number
    sql: ${TABLE}.moveupunrecognizedmanagercount ;;
  }

  dimension: orderingdistributorcount {
    type: number
    sql: ${TABLE}.orderingdistributorcount ;;
  }

  dimension: personalenrolmentcount {
    type: number
    sql: ${TABLE}.personalenrolmentcount ;;
  }

  dimension: processedmonth {
    type: number
    sql: ${TABLE}.processedmonth ;;
  }

  dimension: processedyear {
    type: number
    sql: ${TABLE}.processedyear ;;
  }

  dimension: recentorderingfbo {
    type: number
    sql: ${TABLE}.recentorderingfbo ;;
  }

  dimension: salesdividedbytotalvalue {
    type: number
    sql: ${TABLE}.salesdividedbytotalvalue ;;
  }

  dimension: totalmonthlycc {
    type: number
    sql: ${TABLE}.totalmonthlycc ;;
  }

  dimension: totalmonthlyturnover {
    type: number
    sql: ${TABLE}.totalmonthlyturnover ;;
  }

  dimension: totalorderingfbo {
    type: number
    sql: ${TABLE}.totalorderingfbo ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
