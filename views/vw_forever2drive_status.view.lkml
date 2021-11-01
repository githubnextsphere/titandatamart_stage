view: vw_forever2drive_status {
  derived_table: {
    sql: with monthycc as (
          select mon.distributorid,
            mon.operatingcompanycode as opco,
            mon.processingdate as processingdate,
            mon.numberofdownlinegem1stgenarm as "1stgenactivemgrs",
            mon.totalccmtd as totalcc
            from prod2.dim_monthlycc mon
          ),
        forever2drive as (
          select
            mem.distributorid as fboid,
            (coalesce(mem.memberfirstname , '') + ' ' + coalesce (mem.memberlastname ,'')) as fboname,
            mem.operatingcompanycode as homecountry,
            mon.operatingcompanycode as opco,
            mon.processingdate as processingdate,
            mon.earnedincentivelevel as qualificationlevel,
            mon.earnedincentivequalificationdate as qualificationstartperiod,
            mon.earnedincentiveexpirationdate as qualificationendperiod,
            mon.currentmonthactive as "4ccactive",
            case when {% parameter parameter_period %} = 'Current Period' then trunc(date_trunc('month',current_date))
            else to_date('01-' || {% parameter parameter_period %}, 'DD-MM-YYYY')
            end as datefilter,
            datefilter as currentperiod,
            trunc(dateadd(month,-1,datefilter)) as previousperiod,
            trunc(dateadd(month,-2,datefilter)) as priortopreviousperiod
            from prod2.dim_member mem
            join prod2.dim_monthlycc mon
            on mem.distributorid = mon.distributorid
            and mon.isdelete != 'D' and mem.isdelete != 'D'
            where
            mon.processingdate = ( case when {% parameter parameter_period %} = 'Current Period' then
            trunc(date_trunc('month',current_date))
            else to_date('01-' || {% parameter parameter_period %}, 'DD-MM-YYYY') end)
          )
        select
          fboid as "FBO ID",
          fboname as "FBO Name",
          homecountry as "Member Opco",
          fd.opco as "Qualifying Opco",
          fd.processingdate as "Period",
          qualificationlevel as "Qualification Level",
          qualificationstartperiod as "Qualification Start Period" ,
          qualificationendperiod as "Qualification End Period",
          "4ccactive" as "4CC Active",
          Max(case when(qualificationlevel = 0) then
              case when(("1stgenactivemgrs" >= 0 and "1stgenactivemgrs" < 5) or "1stgenactivemgrs" is null) then 150
                  when("1stgenactivemgrs" >= 5 and "1stgenactivemgrs" < 10) then 110
                  when("1stgenactivemgrs" >= 10 and "1stgenactivemgrs" < 15) then 70
                  when("1stgenactivemgrs" >= 15 and "1stgenactivemgrs" < 20) then 30
                  when("1stgenactivemgrs" >= 20) then 0
              end
              when(qualificationlevel = 1) then
                case when(("1stgenactivemgrs" >= 0 and "1stgenactivemgrs" < 5) or "1stgenactivemgrs" is null) then 225
                  when("1stgenactivemgrs" >= 5 and "1stgenactivemgrs" < 10) then 175
                  when("1stgenactivemgrs" >= 10 and "1stgenactivemgrs" < 15) then 125
                  when("1stgenactivemgrs" >= 15 and "1stgenactivemgrs" < 20) then 75
                  when("1stgenactivemgrs" >= 20 and "1stgenactivemgrs" < 25) then 25
                  when("1stgenactivemgrs" >= 25) then 0
                end
              when(qualificationlevel = 2 or qualificationlevel = 3) then
                case when(("1stgenactivemgrs" >= 0 and "1stgenactivemgrs" < 5) or "1stgenactivemgrs" is null) then 300
                  when("1stgenactivemgrs" >= 5 and "1stgenactivemgrs" < 10) then 240
                  when("1stgenactivemgrs" >= 10 and "1stgenactivemgrs" < 15) then 180
                  when("1stgenactivemgrs" >= 15 and "1stgenactivemgrs" < 20) then 120
                  when("1stgenactivemgrs" >= 20 and "1stgenactivemgrs" < 25) then 60
                  when("1stgenactivemgrs" >= 26) then 0
                end
            end) as "Req CC Full Earnings",
          max(case when (qualificationlevel = 1 or qualificationlevel = 2 or qualificationlevel = 3)
          then
            case when ("4ccactive" = 'true' and mcc.totalcc >= 50 and qualificationendperiod >= current_date and currentperiod = fd.processingdate)
            then ('Level ' + coalesce(qualificationlevel , '') + ' - Qualified' )
            else ('Level ' + coalesce(qualificationlevel , '') + ' - Not Qualified' ) end
          else 'Not Qualified' end) as "Status",
          max(case when currentperiod = mcc.processingdate then "1stgenactivemgrs" end) as "1st Gen Active Mgrs",
          max(case when currentperiod = mcc.processingdate then totalcc end) as "Total CC",
          max(case when previousperiod =mcc.processingdate then "1stgenactivemgrs" end) as "(Period-1) 1st Gen Active Mgrs",
          max(case when previousperiod =mcc.processingdate then totalcc end) as "(Period-1) Total CC",
          max(case when priortopreviousperiod =mcc.processingdate then "1stgenactivemgrs" end) as "(Period-2) 1st Gen Active Mgrs",
          max(case when priortopreviousperiod =mcc.processingdate then totalcc end) as "(Period-2) Total CC"
          from
          forever2drive fd
          join monthycc mcc on fd.fboid = mcc.distributorid
          and fd.opco = mcc.opco
          where
          to_date(extract(year from qualificationstartperiod) || '-' || lpad(extract(month from qualificationstartperiod),2,0) || '-01','YYYY-MM-DD')>=
          {% if vw_forever2drive_status.qualification_start_period_param._is_filtered %}
            {% if vw_forever2drive_status.qualification_start_period_param._parameter_value == "'current month - 35 months'" %}
            to_date(extract(year from(dateadd('month',-35,current_date))) || '-' || lpad(extract(month from(dateadd('month',-35,current_date))),2,0) || '-01', 'YYYY-MM-DD')
            {% else %}
            to_date(SUBSTRING({{vw_forever2drive_status.qualification_start_period_param._parameter_value}},4,4) +'-'+
            SUBSTRING({{vw_forever2drive_status.qualification_start_period_param._parameter_value}},1,2) +'-'+ '-01','YYYY-MM-DD')
            {% endif %}
          {% else %}
            to_date(extract(year from(dateadd('month',-35,current_date))) || '-' || lpad(extract(month from(dateadd('month',-35,current_date))),2,0) || '-01', 'YYYY-MM-DD')
          {% endif %}
          and
          {% if vw_forever2drive_status.qualification_end_period_param._is_filtered %}
          lpad(extract(month from qualificationendperiod),2,0) || '-' ||extract(year from qualificationendperiod) =
          {{vw_forever2drive_status.qualification_end_period_param._parameter_value}}
          {% else %}
          1=1
          {% endif %}
          group by 1,2,3,4,5,6,7,8,9 ;;
  }

  measure: count {
    type: count
  }

  parameter: parameter_period {
    type: string
    allowed_value: {label:"Current Period" value:"Current Period" }
    suggest_explore: forever2drive_suggestion
    suggest_dimension: dim_monthlycc.period
  }

  parameter: member_opco_param {
    type: string
    suggest_explore: member_details
    suggest_dimension: dim_member.opco
  }

  parameter: qualifying_opco_param {
    type: string
    suggest_explore: dim_monthlycc
    suggest_dimension: dim_monthlycc.opco
  }

  parameter: qualification_start_period_param {
    type: string
    suggest_explore: forever2drive_qualificationstartperiod_suggestion
    suggest_dimension: dim_monthlycc.qualification_start_period
  }

  parameter: qualification_end_period_param {
    type: string
    suggest_explore: forever2drive_qualificationendperiod_suggestion
    suggest_dimension: dim_monthlycc.qualification_end_period
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
    sql:SUBSTRING(${TABLE}."fbo id" , 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."fbo id" , 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3);;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{fbo_id._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a> ;;
  }

  dimension: fbo_id_format1 {
    type: string
    label: "FBO ID Format"
    description: "FBO ID (000000000000)"
    sql: ${TABLE}."fbo id" ;;
  }

  dimension: fbo_id_format2 {
    type: string
    label: "FBO ID Format2"
    description: "FBO ID (000 000 000 000)"
    sql: SUBSTRING(${TABLE}."fbo id" , 1,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 4,3)
      + ' ' + SUBSTRING(${TABLE}."fbo id" , 7,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
  }

  dimension: fbo_id_format3 {
    type: string
    label: "FBO ID Format3"
    description: "FBO ID (000 000-000-000)"
    sql:SUBSTRING(${TABLE}."fbo id", 1,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 4,3) + '-' + SUBSTRING(${TABLE}."fbo id", 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
  }

  dimension: fbo_name {
    type: string
    label: "FBO Name"
    sql: ${TABLE}."fbo name" ;;
  }

  dimension: member_opco {
    type: string
    label: "Member OpCo"
    sql: ${TABLE}."member opco" ;;
    case_sensitive: no
  }

  dimension: qualifying_opco {
    type: string
    label: "Qualifying OpCo"
    sql: ${TABLE}."qualifying opco" ;;
    case_sensitive: no
  }

  dimension: period {
    type: date
    label: "Period"
    sql: ${TABLE}.period ;;
    convert_tz: no
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%m-%Y" }}</font> ;;
  }

  dimension: qualification_level {
    type: string
    label: "Qualification Level"
    sql: ${TABLE}."qualification level" ;;
  }

  dimension: qualification_start_period {
    type: string
    label: "Qualification Start Period"
    sql: case when ${TABLE}."qualification start period" is null
      then cast('-' as varchar) else cast(${TABLE}."qualification start period" as varchar) end ;;
  }

  dimension: qualification_end_period {
    type: string
    label: "Qualification End Period"
    sql: case when ${TABLE}."qualification end period" is null
      then cast('-' as varchar) else cast(${TABLE}."qualification end period" as varchar) end ;;
  }

  dimension: req_cc_full_earnings {
    type: number
    label: "Req CC Full Earnings"
    sql: ${TABLE}."Req CC Full Earnings" ;;
  }

  dimension: status {
    type: string
    label: "Status"
    sql: ${TABLE}."Status";;
  }

  dimension: 4cc_active {
    type: string
    label: "4CC Active"
    sql: case when ${TABLE}."4cc active" = 'true' then 'Yes' else 'No' end ;;
  }

  dimension: 1st_gen_active_mgrs {
    type: number
    label: "1st Gen Active Mgrs"
    sql: case when ${TABLE}."1st gen active mgrs" is null then 0
      else ${TABLE}."1st gen active mgrs" end;;
  }

  dimension: total_cc {
    type: number
    label: "Total CC"
    sql: case when ${TABLE}."total cc" is null then 0
      else ${TABLE}."total cc" end;;
    value_format: "#,##0.000"
  }

  dimension: period1_1st_gen_active_mgrs {
    type: number
    label: "(Period-1) 1st Gen Active Mgrs"
    sql: case when ${TABLE}."(period-1) 1st gen active mgrs" is null then 0
      else ${TABLE}."(period-1) 1st gen active mgrs" end;;
  }

  dimension: period1_total_cc {
    type: number
    label: "(Period-1) Total CC"
    sql: case when ${TABLE}."(period-1) total cc" is null then 0
      else ${TABLE}."(period-1) total cc" end;;
    value_format: "#,##0.000"
  }

  dimension: period2_1st_gen_active_mgrs {
    type: number
    label: "(Period-2) 1st Gen Active Mgrs"
    sql: case when ${TABLE}."(period-2) 1st gen active mgrs" is null then 0
      else ${TABLE}."(period-2) 1st gen active mgrs" end;;
  }

  dimension: period2_total_cc {
    type: number
    label: "(Period-2) Total CC"
    sql: case when ${TABLE}."(period-2) total cc" is null then 0
      else ${TABLE}."(period-2) total cc" end;;
    value_format: "#,##0.000"
  }

  set: detail {
    fields: [
      fbo_id,
      fbo_name,
      member_opco,
      qualifying_opco,
      period,
      qualification_level,
      qualification_start_period,
      qualification_end_period,
      req_cc_full_earnings,
      status,
      4cc_active,
      1st_gen_active_mgrs,
      total_cc,
      period1_1st_gen_active_mgrs,
      period1_total_cc,
      period2_1st_gen_active_mgrs,
      period2_total_cc,
      fbofilter,
      fbo_id_format1,
      fbo_id_format2,
      fbo_id_format3,
      member_opco_param,
      qualifying_opco_param,
      qualification_start_period_param,
      qualification_end_period_param
    ]
  }
}
