view: vw_global_rally_status_report {
  derived_table: {
    sql: with rewards as (
      select
        'Next Level' :: varchar as rewards_for,
        rewards."level" as "level",
        rewards.leveldisplayed as leveldisplayed,
        rewards.globalcc as globalcc,
        rewards.airfare as airfare,
        rewards.lodging as lodging,
        rewards.spendingcash  as allowance,
        rewards.cashbonus  as grbonus
        from stage_tbeaggregation.fact_globalrallyrewards rewards
      ),
      details as (
      select
        'Achieved Level' :: varchar as rewards_for,
        fgr.distributorid as fbo_id,
        coalesce(mem.memberfirstname,'')+' '+coalesce(mem.memberlastname,'') as name,
        fgr.homecountry as homeopco,
        mem.homecompanycode as homecountry,
        fgr.totalcc as totalcc,
        fgr."level" as "level",
        fgr."period" as "period",
        fgr.waivers as waivers,
        fgr."level" as achievedlevel,
        case when fgr."level"=0 then fgr."level"+2 else fgr."level"+1 end as nextlevel
        from stage_tbeaggregation.fact_grqualification fgr
        join stage_tbe.dim_member mem
        on mem.distributorid = fgr.distributorid
        and mem.isdelete <> 'D'
      )
      select
        d.fbo_id,
        d.name,
        d.homeopco,
        d.homecountry,
        d.totalcc,
        d."period",
        d.waivers,
        d.rewards_for,
        0 as "cc needed",
        d.achievedlevel,
        max(case when d.achievedlevel = 0 then 'Level 0'
                 when d.achievedlevel = r."level" then r.leveldisplayed end) as "Achieved Level",
        max(case when d.achievedlevel = 0 then 'Level 0'
                 when d.achievedlevel = r."level" then r.leveldisplayed end) as "Level",
        max(case when d.achievedlevel = 0 then '-'
                 when d.achievedlevel = r."level" then r.airfare end) as "Airfare",
        max(case when d.achievedlevel = 0 then '-'
                 when d.achievedlevel = r."level" then r.lodging end) as "Lodging",
        max(case when d.achievedlevel = 0 then 0
                 when d.achievedlevel = r."level" then r.allowance end) as "Allowance",
        max(case when d.achievedlevel = 0 then 0
                 when d.achievedlevel = r."level" then r.grbonus end) as "GR Bonus"
        from details d
        cross join rewards r
        group by 1,2,3,4,5,6,7,8,10
      union
      select
        d.fbo_id,
        d.name,
        d.homeopco,
        d.homecountry,
        d.totalcc,
        d."period",
        d.waivers,
        r.rewards_for,
        max(case when (d.achievedlevel = 10 or d.achievedlevel = 0) then 0
                 when d.nextlevel = r."level" then r.globalcc-d.totalcc end) as "cc needed",
        d.achievedlevel,
        max(case when d.achievedlevel = 0 then 'Level 0'
                 when d.achievedlevel = r."level" then r.leveldisplayed end) as "Achieved Level",
        max(case when d.achievedlevel = 10 then '-'
                 when d.nextlevel = r."level" then r.leveldisplayed end) as "Level",
        max(case when d.achievedlevel = 10 then '-'
                 when d.nextlevel = r."level" then r.airfare end) as "Airfare",
        max(case when d.achievedlevel = 10 then '-'
                 when d.nextlevel = r."level" then r.lodging end) as "Lodging",
        max(case when d.achievedlevel = 10 then 0
                 when d.nextlevel = r."level" then r.allowance end) as "Allowance",
        max(case when d.achievedlevel = 10 then 0
                 when d.nextlevel = r."level" then r.grbonus end) as "GR Bonus"
        from details d
        cross join rewards r
        group by 1,2,3,4,5,6,7,8,10
       ;;
  }

  measure: count {
    type: count_distinct
    sql: ${fbo_id} ;;
  }

  parameter: period_param {
    allowed_value: {label: "2022" value:"2022"}
    allowed_value: {label: "2021" value:"2021"}
    allowed_value: {label: "2020" value:"2020"}
    default_value: "2021"
  }

  filter: fbofilter {
    type: string
    sql: {% condition fbofilter %} ${fbo_id} {% endcondition %}
          or {% condition fbofilter %} ${fbo_id_format1} {% endcondition %}
          or {% condition fbofilter %} ${fbo_id_format2} {% endcondition %}
          or {% condition fbofilter %} ${fbo_id_format3} {% endcondition %};;
    suggest_explore: member_details
    suggest_dimension: dim_member.fbo_id
  }

  dimension: fbo_id {
    type: string
    label: "FBO ID"
    description: "FBO ID (000-000-000-000)"
    sql:SUBSTRING(${TABLE}."fbo_id" , 1,3) + '-' + SUBSTRING(${TABLE}."fbo_id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."fbo_id" , 7,3) + '-' + SUBSTRING(${TABLE}."fbo_id" , 10,3);;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{fbo_id._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a> ;;
  }

  dimension: fbo_id_format1 {
    type: string
    label: "FBO ID Format"
    description: "FBO ID (000000000000)"
    sql: ${TABLE}."fbo_id" ;;
  }

  dimension: fbo_id_format2 {
    type: string
    label: "FBO ID Format2"
    description: "FBO ID (000 000 000 000)"
    sql: SUBSTRING(${TABLE}."fbo_id" , 1,3) + ' ' + SUBSTRING(${TABLE}."fbo_id" , 4,3)
      + ' ' + SUBSTRING(${TABLE}."fbo_id" , 7,3) + ' ' + SUBSTRING(${TABLE}."fbo_id" , 10,3) ;;
  }

  dimension: fbo_id_format3 {
    type: string
    label: "FBO ID Format3"
    description: "FBO ID (000 000-000-000)"
    sql:SUBSTRING(${TABLE}."fbo_id", 1,3) + ' ' + SUBSTRING(${TABLE}."fbo_id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."fbo_id", 7,3) + '-' + SUBSTRING(${TABLE}."fbo_id" , 10,3) ;;
  }

  dimension: name {
    type: string
    label: "FBO Name"
    sql: ${TABLE}.name ;;
  }

  dimension: homeopco {
    type: string
    label: "Home Opco"
    sql: ${TABLE}.homeopco ;;
  }

  dimension: homecountry {
    type: string
    label: "Home Country"
    sql: ${TABLE}.homecountry ;;
  }

  dimension: totalcc {
    type: number
    label: "Global CC"
    sql: ${TABLE}.totalcc ;;
    value_format: "0.000"
  }

  dimension: period {
    type: number
    label: "Period"
    sql: ${TABLE}.period ;;
    value_format: "0"
  }

  dimension: waivers {
    type: string
    label: "Waivers"
    sql: ${TABLE}.waivers ;;
  }

  dimension: achievedlevel {
    type: string
    label: "AchievedLevel"
    sql: ${TABLE}.achievedlevel ;;
  }

  dimension: achieved_level {
    order_by_field: achievedlevel
    type: string
    label: "Achieved Level"
    sql: ${TABLE}."Achieved Level" ;;
  }

  dimension: rewards_for {
    type: string
    label: "Rewards for"
    sql: ${TABLE}.rewards_for ;;
  }

  measure: cc_needed {
    type: number
    label: "Next Level CC Needed"
    sql: max(${TABLE}."cc needed") ;;
    value_format: "0.000"
  }

  measure: level {
    type: string
    label: "Level"
    sql: max(${TABLE}.level) ;;
  }

  measure: airfare {
    type: string
    label: "Airfare"
    sql: max(${TABLE}.airfare) ;;
  }

  measure: lodging {
    type: string
    label: "Lodging"
    sql: max(${TABLE}.lodging) ;;
  }

  measure: allowance {
    type: number
    label: "Allowance"
    sql: max(${TABLE}.allowance) ;;
    value_format: "$#,###"
    html: <font style="white-space: nowrap;">
          {% if value == 0 %}
          0.0
          {% else %}
          {{ rendered_value }} USD
          {% endif %}
          </font> ;;
  }

  measure: gr_bonus {
    type: number
    label: "GR Bonus"
    sql: max(${TABLE}."gr bonus") ;;
    value_format: "$#,###"
    html: <font style="white-space: nowrap;">
          {% if value == 0 %}
          0.0
          {% else %}
          {{ rendered_value }} USD
          {% endif %}
          </font> ;;
  }

  set: detail {
    fields: [
      fbofilter,
      fbo_id,
      fbo_id_format1,
      fbo_id_format2,
      fbo_id_format3,
      name,
      homeopco,
      homecountry,
      totalcc,
      period,
      waivers,
      rewards_for,
      cc_needed,
      level,
      airfare,
      lodging,
      allowance,
      gr_bonus,
      achievedlevel,
      achieved_level
    ]
  }
}
