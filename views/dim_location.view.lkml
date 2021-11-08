view: dim_location {
  sql_table_name: prod2.dim_location ;;

  dimension: active {
    type: string
    sql: ${TABLE}.active ;;
  }

  dimension: addressline1 {
    type: string
    sql: ${TABLE}.addressline1 ;;
  }

  dimension: addressline2 {
    type: string
    sql: ${TABLE}.addressline2 ;;
  }

  dimension: addressline3 {
    type: string
    sql: ${TABLE}.addressline3 ;;
  }

  dimension: addressname {
    type: string
    sql: ${TABLE}.addressname ;;
  }

  dimension: addresstype {
    type: string
    sql: ${TABLE}.addresstype ;;
  }

  dimension: areaname {
    type: string
    sql: ${TABLE}.areaname ;;
  }

  dimension: areanumber {
    type: number
    sql: ${TABLE}.areanumber ;;
  }

  dimension: countryisocode3 {
    type: string
    sql: ${TABLE}.countryisocode3 ;;
  }

  dimension_group: createddate {
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
    sql: ${TABLE}.createddate ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: datasource {
    type: string
    sql: ${TABLE}.datasource ;;
  }

  dimension: externallocationid {
    type: number
    value_format_name: id
    sql: ${TABLE}.externallocationid ;;
  }

  dimension: externalsequencenumber {
    type: number
    sql: ${TABLE}.externalsequencenumber ;;
  }

  dimension: homecompanycode {
    type: string
    sql: ${TABLE}.homecompanycode ;;
  }

  dimension: homecompanyname {
    type: string
    sql: ${TABLE}.homecompanyname ;;
  }

  dimension: isdelete {
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: locationid {
    type: number
    value_format_name: id
    sql: ${TABLE}.locationid ;;
  }

  dimension: locationkey {
    type: number
    sql: ${TABLE}.locationkey ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: operatingcompanyname {
    type: string
    sql: ${TABLE}.operatingcompanyname ;;
  }

  dimension: ownername {
    type: string
    sql: ${TABLE}.ownername ;;
  }

  dimension: phonenumber {
    type: string
    sql: ${TABLE}.phonenumber ;;
  }

  dimension: primaryemailid {
    type: string
    sql: ${TABLE}.primaryemailid ;;
  }

  dimension: regionname {
    type: string
    sql: ${TABLE}.regionname ;;
  }

  dimension: secondaryemailid {
    type: string
    sql: ${TABLE}.secondaryemailid ;;
  }

  dimension: statecode {
    type: string
    sql: ${TABLE}.statecode ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: storename {
    type: string
    sql: ${TABLE}.storename ;;
  }

  dimension_group: updateddate {
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
    sql: ${TABLE}.updateddate ;;
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

  dimension_group: validto {
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
    sql: ${TABLE}.validto ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}.zipcode ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      addressname,
      regionname,
      ownername,
      operatingcompanyname,
      homecompanyname,
      storename,
      areaname
    ]
  }
}
