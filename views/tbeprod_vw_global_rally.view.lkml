view: tbeprod_vw_global_rally {
  derived_table: {
    sql: WITH yearlycc
           AS (SELECT cc.distributorid,
                 mem.operatingcompanycode as opco,
                 mem.homecompanycode as home_country,
                 mem.memberlevel as mem_level,
                 initcap(mem.memberlastname || ',' || mem.memberfirstname || ' ' || mem.membermiddlename) as name,
                 mem.alternatephone1 as phone,
                 mem.emailaddress as email,
                 initcap(mem.city) as city,
                 cc.processingyear,
                 cc.processingdate,
                 cc.globalcasecredits,
                 cc.globalrallylevelachieved,
                 CASE
                  WHEN cc.cblevelachieved = '0' THEN 'false'
                  ELSE 'true'
                 END AS cblevel,
                 Row_number()
                  OVER (
                    partition BY cc.distributorid,processingyear
                    ORDER BY globalcasecredits DESC) AS row
               FROM prod_as400.dim_member mem
               JOIN prod_as400.dim_monthlycc cc ON mem.distributorid = cc.distributorid
               WHERE cc.globalcasecredits <> 0 AND cc.isdelete <> 'D'
              and {% condition processingyear %} cc.processingyear {% endcondition %}
              and {% condition opco %} mem.operatingcompanycode {% endcondition %}
              and {% condition home_country %} mem.homecompanycode {% endcondition %}
              and {% condition total_cc %} cc.globalcasecredits {% endcondition %})
      SELECT cc.distributorid,
           cc.opco,
           cc.home_country,
           cc.mem_level,
           cc.name,
           cc.phone,
           cc.email,
           cc.city,
             cc.processingdate,
             cc.processingyear,
             cc.globalcasecredits as total_cc,
             CASE WHEN cc.globalcasecredits >= 20000 THEN 20000
               WHEN cc.globalcasecredits >= 15000 THEN 15000
               WHEN cc.globalcasecredits >= 12500 THEN 12500
               WHEN cc.globalcasecredits >= 10000 THEN 10000
               WHEN cc.globalcasecredits >= 7500 THEN 7500
               WHEN cc.globalcasecredits >= 5000 THEN 5000
               WHEN cc.globalcasecredits >= 2500 THEN 2500
               WHEN cc.globalcasecredits >= 1500 THEN 1500
               ELSE NULL
            END  as rewards_level_acheived,
            CASE WHEN cc.globalcasecredits < 1500 and cc.cblevel = 'false' THEN 0
               WHEN cc.globalcasecredits < 1500 THEN 1
               WHEN cc.globalcasecredits < 2500 THEN 2
               WHEN cc.globalcasecredits < 5000 THEN 3
               WHEN cc.globalcasecredits < 7500 THEN 4
               WHEN cc.globalcasecredits < 10000 THEN 5
               WHEN cc.globalcasecredits < 12500 THEN 6
               WHEN cc.globalcasecredits < 15000 THEN 7
               WHEN cc.globalcasecredits < 20000 THEN 8
               WHEN cc.globalcasecredits >= 20000 THEN 9
          END as global_rally_level
      FROM   yearlycc cc
      WHERE  row = 1
      order by 1,2
       ;;
  }

  measure: count {
    type: count_distinct
    sql: ${distributorid} ;;
  }

  parameter: year {
    type: number
  }

  filter: mem_opco {
    type: string
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: fbo_id {
    type: string
    label: "FBO ID"
    sql: SUBSTRING(${TABLE}.distributorid, 1,3) + '-' + SUBSTRING(${TABLE}.distributorid, 4,3)
          + '-' + SUBSTRING(${TABLE}.distributorid, 7,3) + '-' + SUBSTRING(${TABLE}.distributorid, 10,3)
          ;;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: opco {
    label: "OpCO"
    case_sensitive: no
    type: string
    sql: ${TABLE}.opco ;;
  }

  dimension: home_country {
    case_sensitive: no
    type: string
    sql: ${TABLE}.home_country ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: mem_level {
    label: "Level"
    sql: ${TABLE}.mem_level ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension_group: processingdate {
    type: time
    sql: ${TABLE}.processingdate ;;
  }

  dimension: processingyear {
    type: number
    sql: ${TABLE}.processingyear ;;
  }

  dimension: total_cc {
    value_format: "#,##0.000"
    label: "Total CC"
    type: number
    sql: ${TABLE}.total_cc ;;
  }

  dimension: rewards_level_acheived {
    value_format: "##,##0"
    type: number
    sql: ${TABLE}.rewards_level_acheived ;;
  }

  dimension: remaining_cc_to_next_level {
    value_format: "#,##0.000"
    label: "Remaining CC to Next Level"
    type: number
    sql: ${ccupperbound} -${total_cc} ;;
  }

  dimension: global_rally_level {
    type: string
    sql: ${TABLE}.global_rally_level ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: ccupperbound {
    value_format: "##,##0"
    label: "CC to Next Level"
    type: number
    sql: CASE WHEN ${global_rally_level} = 0 or ${global_rally_level} = 1 THEN 1500
               WHEN ${global_rally_level} = 2 THEN 2500
               WHEN ${global_rally_level} = 3 THEN 5000
               WHEN ${global_rally_level} = 4  THEN 7500
               WHEN ${global_rally_level} = 5 THEN 10000
               WHEN ${global_rally_level} = 6 THEN 12500
               WHEN ${global_rally_level} = 7 THEN 15000
               WHEN ${global_rally_level} = 8 THEN 20000
               WHEN ${global_rally_level} = 9 THEN NULL
          END ;;
  }

  dimension: lodging_and_meals {
    type: string
    sql: CASE  WHEN ${global_rally_level} = 0 THEN '-'
               WHEN ${global_rally_level} = 1 THEN '4 Nights'
               WHEN ${global_rally_level} = 2 THEN '4 Nights'
               WHEN ${global_rally_level} = 3 THEN '5 Nights'
               WHEN ${global_rally_level} = 4  THEN '6 Nights'
               WHEN ${global_rally_level} = 5 THEN '7 Nights'
               WHEN ${global_rally_level} = 6 THEN '7 Nights'
               WHEN ${global_rally_level} = 7 THEN '7 Nights'
               WHEN ${global_rally_level} = 8 THEN '7 Nights'
               WHEN ${global_rally_level} = 9 THEN '7 Nights'
          END ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: spending_cash {
    type: string
    sql: CASE  WHEN ${global_rally_level} = 0 THEN '$0 USD'
               WHEN ${global_rally_level} = 1 THEN '$250 USD'
               WHEN ${global_rally_level} = 2 THEN '$250 USD'
               WHEN ${global_rally_level} = 3 THEN '$500 USD'
               WHEN ${global_rally_level} = 4 THEN '$1200 USD'
               WHEN ${global_rally_level} = 5 THEN '$2200 USD'
               WHEN ${global_rally_level} = 6 THEN '$3200 USD'
               WHEN ${global_rally_level} = 7 THEN '$5200 USD'
               WHEN ${global_rally_level} = 8 THEN '$5200 USD'
               WHEN ${global_rally_level} = 9 THEN '$5200 USD'
          END ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: activity_allowance {
    type: string
    sql:  CASE WHEN ${global_rally_level} = 0 THEN 'No'
               ELSE 'Yes'
          END;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  set: detail {
    fields: [
      distributorid,
      opco,
      home_country,
      name,
      phone,
      email,
      city,
      processingdate_time,
      processingyear,
      total_cc,
      rewards_level_acheived,
      ccupperbound,
      lodging_and_meals,
      spending_cash,
      activity_allowance
    ]
  }
}
