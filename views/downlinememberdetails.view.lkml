view: downlinememberdetails {
  sql_table_name: stage_tbeaggregation.downlinememberdetails ;;

  dimension: assistantsupervisorinsamemonth {
    type: number
    sql: ${TABLE}.assistantsupervisorinsamemonth ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: distributorstatus {
    type: string
    sql: ${TABLE}.distributorstatus ;;
  }

  dimension: downlinedistributorid {
    type: string
    sql: ${TABLE}.downlinedistributorid ;;
  }

  dimension: downlinememberdetailskey {
    type: number
    sql: ${TABLE}.downlinememberdetailskey ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: generation {
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: homecountry {
    type: string
    sql: ${TABLE}.homecountry ;;
  }

  dimension: isnonmgrdownline {
    type: string
    sql: ${TABLE}.isnonmgrdownline ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: purchaseinsamemonth {
    type: string
    sql: ${TABLE}.purchaseinsamemonth ;;
  }

  dimension: recursiveuplinedistributorids {
    type: string
    sql: ${TABLE}.recursiveuplinedistributorids ;;
  }

  dimension_group: sponsordate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.sponsordate ;;
  }

  dimension: sponsordistributorid {
    type: string
    sql: ${TABLE}.sponsordistributorid ;;
  }

  dimension: sponsorfirstname {
    type: string
    sql: ${TABLE}.sponsorfirstname ;;
  }

  dimension: sponsorlastname {
    type: string
    sql: ${TABLE}.sponsorlastname ;;
  }

  dimension: sponsorstatus {
    type: string
    sql: ${TABLE}.sponsorstatus ;;
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
    drill_fields: [firstname, lastname, sponsorfirstname, sponsorlastname]
  }
}
