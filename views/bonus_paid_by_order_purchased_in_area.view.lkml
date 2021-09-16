view: bonus_paid_by_order_purchased_in_area {
  derived_table: {
    sql: WITH OrderCTE AS (
            SELECT
              DISTINCT  ord.ordernumber,
              ord.distributorid,
              ISNULL(mem.memberlastname,'') + ', ' + ISNULL(mem.memberfirstname,'') AS Name,
              loc.operatingcompanycode ,
              loc.areaname,
              ord.processedyear,
              ord.processedmonth ,
              ord.orderplaceddate,
              ord.purchasearea,
              ord.totalcasecredits,
              ord.productstandardretailprice
              FROM prod_as400.fact_orderdetails ord
              JOIN prod_as400.dim_location loc ON ord.operatingandhomecompanylocationkey = loc.locationkey
              JOIN prod_as400.dim_member mem ON mem.distributorid = ord.distributorid
              and ord.isdelete <> 'D' and mem.isdelete <> 'D'
              WHERE ord.adjustedorderdate >= '2020-01-01'
              AND ord.productstandardretailprice > 0
              AND ord.totalcasecredits > 0
              and {% if parameter_period._parameter_value == "'Current Period'" %}
                  lpad(ord.processedmonth,2,0) || '-' || ord.processedyear = lpad(extract(month from current_date),2,0) || '-' || extract(year from current_date)
                  {% else %}
                  lpad(ord.processedmonth,2,0) || '-' || ord.processedyear = {{parameter_period._parameter_value}}
                  {% endif %}
        )
     select
      recap.sponsorid,
      cte.orderplaceddate,
      cte.distributorid,
      cte.name,
      cte.operatingcompanycode,
      cte.areaname,
      cte.ordernumber,
      cte.purchasearea,
      ROUND(((recap.levelcc/cte.totalcasecredits) * cte.productstandardretailprice),3) as retailvalue,
      recap.bonuspercentage,
      recap.bonusamount,
      recap.processingyear,
      recap.processingmonth
      from OrderCTE cte
      join prod_as400.dim_recap_monthlybonusdetail recap
      on cte.ordernumber = recap.ordernumber
      and cte.operatingcompanycode = recap.operatingcompanycode
      and cte.processedyear = recap.processingyear
      and cte.processedmonth = recap.processingmonth
      and recap.isdelete <> 'D'
      where
      recap.sponsorid <> recap.distributorid
      and 1 =
          CASE
              WHEN recap.levelcc <> 0 AND recap.ccfactor <> 0 THEN 1
              WHEN recap.levelcc <> 0 AND recap.ccfactor = 0 AND recap.accumulatedpercentagepaid < 0.18 THEN 1
              ELSE 0
          end
      and {% parameter recap_param %} = 'Full'
    union
    select
      recap.sponsorid,
      cte.orderplaceddate,
      cte.distributorid,
      cte.name,
      cte.operatingcompanycode,
      cte.areaname,
      cte.ordernumber,
      cte.purchasearea,
      ROUND(((recap.levelcc/cte.totalcasecredits) * cte.productstandardretailprice),3) as retailvalue,
      recap.bonuspercentage,
      recap.bonusamount,
      recap.processingyear,
      recap.processingmonth
      from OrderCTE cte
      join prod_as400.dim_recap_monthlybonusdetail recap
      on cte.ordernumber = recap.ordernumber
      and cte.operatingcompanycode = recap.operatingcompanycode
      and cte.processedyear = recap.processingyear
      and cte.processedmonth = recap.processingmonth
      and recap.isdelete <> 'D'
      where
      recap.sponsorid = recap.distributorid
      and ({% parameter recap_param %} = 'Full' or {% parameter recap_param %} = 'Personal Purchase')
       ;;
    datagroup_trigger: datagroup_9pm_arizona

  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: parameter_period {
    type: string
  }

  parameter: recap_param {
    label: "Recap"
    allowed_value: {label:"Full" value:"Full"}
    allowed_value: {label:"Personal Purchase" value:"Personal Purchase"}
  }

  filter: sponsorfilter {
    type: string
    sql: {% condition sponsorfilter %} ${sponsorid} {% endcondition %}
          or {% condition sponsorfilter %} ${sponsorid_format1} {% endcondition %}
          or {% condition sponsorfilter %} ${sponsorid_format2} {% endcondition %}
          or {% condition sponsorfilter %} ${sponsorid_format3} {% endcondition %};;
    suggest_explore: member_details
    suggest_dimension: dim_member.fbo_id
  }

  dimension: sponsorid {
    label: "Sponsor ID"
    type: string
    sql: SUBSTRING(${TABLE}.sponsorid , 1,3) + '-' + SUBSTRING(${TABLE}.sponsorid , 4,3)
      + '-' + SUBSTRING(${TABLE}.sponsorid , 7,3) + '-' + SUBSTRING(${TABLE}.sponsorid , 10,3);;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{sponsorid._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a> ;;
  }

  dimension: sponsorid_format1 {
    type: string
    label: "Sponsor ID Format"
    description: "Sponsor ID (000000000000)"
    sql: ${TABLE}.sponsorid ;;
  }

  dimension: sponsorid_format2 {
    type: string
    label: "Sponsor ID Format2"
    description: "Sponsor ID (000 000 000 000)"
    sql: SUBSTRING(${TABLE}.sponsorid , 1,3) + ' ' + SUBSTRING(${TABLE}.sponsorid , 4,3)
      + ' ' + SUBSTRING(${TABLE}.sponsorid , 7,3) + ' ' + SUBSTRING(${TABLE}.sponsorid , 10,3) ;;
  }

  dimension: sponsorid_format3 {
    type: string
    label: "Sponsor ID Format3"
    description: "Sponsor ID (000 000-000-000)"
    sql:SUBSTRING(${TABLE}.sponsorid, 1,3) + ' ' + SUBSTRING(${TABLE}.sponsorid , 4,3)
      + '-' + SUBSTRING(${TABLE}.sponsorid, 7,3) + '-' + SUBSTRING(${TABLE}."distributorid" , 10,3) ;;
  }

  dimension: orderplaceddate {
    label: "Order Date"
    type: date
    sql: ${TABLE}.orderplaceddate ;;
    convert_tz: no
  }

  dimension: distributorid {
    label: "FBO ID"
    type: string
    sql:SUBSTRING(${TABLE}.distributorid , 1,3) + '-' + SUBSTRING(${TABLE}.distributorid , 4,3)
      + '-' + SUBSTRING(${TABLE}.distributorid , 7,3) + '-' + SUBSTRING(${TABLE}.distributorid , 10,3);;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{distributorid._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a> ;;
  }

  dimension: name {
    label: "Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: operatingcompanycode {
    label: "OpCO"
    type: string
    case_sensitive: no
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: areaname {
    type: string
    sql: ${TABLE}.areaname ;;
  }

  dimension: ordernumber {
    label: "Order Number"
    type: string
    sql: ${TABLE}.ordernumber ;;
  }

  dimension: purchasearea {
    label: "Purchase Area"
    type: number
    sql: ${TABLE}.purchasearea ;;
  }

  dimension: retailvalue {
    label: "Retail Value"
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.retailvalue ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: bonuspercentage {
    label: "Percentage (%)"
    type: number
    sql: ${TABLE}.bonuspercentage ;;
  }

  dimension: level_cc {
    label: "Level CC"
    type: number
    sql: ${TABLE}.level_cc ;;
  }

  dimension: bonusamount {
    label: "Total Bonus"
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.bonusamount ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: processingmonth {
    label: "Processing month"
    type: number
    sql: ${TABLE}.processingmonth ;;
  }

  dimension: processingyear {
    label: "Processing year"
    type: number
    value_format: "0"
    sql: ${TABLE}.processingyear ;;
  }

  dimension: processing_period {
    type: string
    sql: lpad(${processingmonth},2,0)||'-'||${processingyear} ;;
  }

  measure: bonus {
    type: sum
    sql: ${bonusamount} ;;
    drill_fields: [sponsorid,orderplaceddate,distributorid,name,ordernumber,purchasearea,retailvalue,
      bonuspercentage,bonusamount,operatingcompanycode,processingmonth,processingyear,bonus]
  }

  set: detail {
    fields: [
      sponsorfilter,
      sponsorid_format1,
      sponsorid_format2,
      sponsorid_format3,
      sponsorid,
      orderplaceddate,
      distributorid,
      name,
      operatingcompanycode,
      areaname,
      ordernumber,
      purchasearea,
      retailvalue,
      bonuspercentage,
      level_cc,
      bonusamount,
      processingmonth,
      processingyear
    ]
  }

}
