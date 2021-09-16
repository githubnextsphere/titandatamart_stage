view: dim_monthlycc {
  sql_table_name: uat_tbe.dim_monthlycc ;;

  dimension: 4cc_active {
    description: "This field shows 4cc active(yes/no)."
    label: "4CC Active"
    type: yesno
    sql: ${TABLE}.currentmonthactive = 'true' ;;
  }

  dimension: pc_2mo_cc {
    description: "This field shows PC 2 month CCs."
    label: "PC 2MO CC"
    type: number
    sql: ${TABLE}.distributorcc2mtd ;;
  }

  dimension: novusfpc_ccs {
    type: number
    label: "Novus(FPC) CCs"
    value_format: "#,##0.000"
    sql: ${TABLE}.distributorccmtd ;;
  }

  dimension: allowance_amount {
    type: number
    sql: ${TABLE}.allowanceamount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: bonus_correction_amount {
    type: number
    sql: ${TABLE}.bonuscorrectionamount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: bonus_correction_amount_currency {
    type: string
    sql:${currencycode} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: chairmans_amount {
    type: number
    sql: ${TABLE}.chairmansamount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: active {
    label: "Active"
    type: string
    sql: ${TABLE}.active ;;
  }

  dimension: parameter_period_with_date{
    sql:
      concat(concat(concat(concat(substring({% parameter parameter_period %},4,7),'-'),substring({% parameter parameter_period %},1,2)),'-'),'01') :: timestamp;;
    html: {{rendered_value |date: "%d-%m-%Y" }};;
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

  dimension: distributorccmtd {
    type: number
    label: "PC CC"
    sql: ${TABLE}.distributorccmtd ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: currentmonthactive {
    label: "Active"
    type: string
    case_sensitive: no
    sql: ${TABLE}.currentmonthactive ;;
  }

  dimension: current_month_active_yes_or_no {
    label: "Current Month Active(Yes/No)"
    sql: CASE WHEN ${TABLE}.currentmonthactive = 'true' THEN 'Yes'
          ELSE 'No'
          END ;;
  }

  dimension: opco {
    label: "OpCO"
    case_sensitive: no
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: totalactiveccmtd {
    type: number
    label: "Total Active CC"
    value_format: "#,##0.000"
    sql: ${TABLE}.totalactiveccmtd ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: period_sorting {
    type: number
    sql: concat(concat(extract(year from ${current_date}) - ${processingyear},'-'),lpad(12 - lpad(${processingmonth},2,0),2,0)) ;;
  }

  dimension: qualification_start_period_sorting {
    type: number
    sql: concat(concat(extract(year from ${current_date}) - ${qualification_start_year},'-'),lpad(12 - lpad(${qualification_start_month},2,0),2,0)) ;;
  }

  dimension: qualification_end_period_sorting {
    type: number
    sql: concat(extract(year from ${current_date})-${qualification_end_year},lpad(${qualification_end_year},2,0)) :: numeric;;
  }

  dimension: current_date {
    type: date
    sql: current_date ;;
  }

  dimension: processingmonth {
    label: "Processing Month"
    type: number
    sql: ${TABLE}.processingmonth ;;
  }

  dimension: processingyear {
    label: "Processing Year"
    value_format: "###0"
    type: number
    sql: ${TABLE}.processingyear ;;
    #drill_fields: [processingmonth, processingdate_date]
  }

  dimension: period {
    type: string
    order_by_field: period_sorting
    label: "Processing Period"
    sql: lpad(${processingmonth},2,0) || '-' ||${processingyear};;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: period_suggest {
    type: string
    order_by_field: period_sorting
    label: "Processing Period Suggest"
    sql: ${processingyear} || '-' || lpad(${processingmonth},2,0);;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
    suggest_persist_for: "5 hours"
  }

  dimension: period_suggestion {
    type: string
    order_by_field: period_sorting
    label: "Processing Period Suggestion"
    sql: ${processingyear} || '-' || lpad(${processingmonth},2,0);;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
    suggest_persist_for: "5 hours"
  }

  dimension: qualification_start_month {
    type: string
    label: "Qualification Start Month"
    sql: Extract(MONTH from ${earned_incentive_qualification_date}) ;;
  }

  dimension: qualification_start_year {
    type: string
    label: "Qualification Start Year"
    sql: Extract(YEAR from ${earned_incentive_qualification_date}) ;;
  }

  dimension: qualification_end_month {
    type: string
    label: "Qualification End Month"
    sql: Extract(MONTH from ${earned_incentive_expiration_date}) ;;
  }

  dimension: qualification_end_year {
    type: string
    label: "Qualification End Year"
    sql: Extract(YEAR from ${earned_incentive_expiration_date}) ;;
  }

  dimension: qualification_start_period {
    type: string
    order_by_field: qualification_start_period_sorting
    label: "Qualification Start Period"
    sql: lpad(${qualification_start_month},2,0) || '-' ||${qualification_start_year};;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: qualification_end_period {
    type: string
    order_by_field: qualification_end_period_sorting
    label: "Qualification End Period"
    sql: lpad(${qualification_end_month},2,0) || '-' ||${qualification_end_year};;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  parameter: parameter_period {
    type: string
    suggest_explore: vw_monthlycc
    suggest_dimension: vw_monthlycc.period
  }

  parameter: parameter_end_period {
    type: string
    suggest_explore: vw_monthlycc
    suggest_dimension: vw_monthlycc.period
  }


  dimension: from_processing_period {
    type: string
    sql: {{ dim_monthlycc.parameter_period._parameter_value }} ;;
  }

  dimension: to_processing_period {
    type: string
    sql: {{ dim_monthlycc.parameter_end_period._parameter_value }} ;;
  }

  dimension_group: processingdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.processingdate ;;
  }

  dimension_group : currentdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: CURRENT_DATE;;
  }

  dimension: current_period {
    type: string
    sql: concat(concat(lpad(extract(month from current_date),2,0),'-'),${currentdate_year}) ;;
  }

  parameter: parameter_year {
    type: string
    allowed_value: { value: "Current Year"}
    allowed_value: { value: "2025" }
    allowed_value: { value: "2024" }
    allowed_value: { value: "2023" }
    allowed_value: { value: "2022" }
    allowed_value: { value: "2021" }
    allowed_value: { value: "2020" }
    allowed_value: { value: "2019" }
    allowed_value: { value: "2018" }
    allowed_value: { value: "2017" }
    allowed_value: { value: "2016" }
    default_value: "Current Year"
  }

  parameter: parameter_month {
    type: string
    allowed_value: { label:"Current Month" value: "Current Month" }
    allowed_value: { label:"January" value: "1" }
    allowed_value: { label: "February" value: "2" }
    allowed_value: { label: "March" value: "3" }
    allowed_value: { label: "April" value: "4" }
    allowed_value: { label: "May" value: "5" }
    allowed_value: { label: "June" value: "6" }
    allowed_value: { label: "July" value: "7" }
    allowed_value: { label: "August" value: "8" }
    allowed_value: { label: "September" value: "9" }
    allowed_value: { label: "October" value: "10" }
    allowed_value: { label: "November" value: "11" }
    allowed_value: { label: "December" value: "12" }
    default_value: "Current Month"
  }

  measure: currentmonthactive_count {
    label: "Active Count"
    type: sum
    sql: CASE WHEN ${currentmonthactive}='true' then 1
              ELSE 0
          END;;
  }

  dimension: beginninglevel {
    type: number
    sql: ${TABLE}.beginninglevel ;;
  }

  measure: totalccmtd_count {
    type: sum
    sql: CASE WHEN ${total_cc}>0 then 1
              ELSE 0
          END;;
  }

  dimension: total_cc {
    label: "Total CC"
    value_format: "#,##0.000"
    type: number
    sql: ${TABLE}.totalccmtd ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: totalbonus {
    label: "Total Bonus"
    type: number
    sql: ${TABLE}.totalbonus ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: currencycode {
    type: string
    sql: ${TABLE}.currencycode ;;
  }

  dimension: totalbonus_currency {
    label: "Total Bonus Currency"
    type: string
    sql: ${currencycode} ;;
    html: <div><font style="white-space: nowrap;"> {{rendered_value}} </font></div>;;
  }

  dimension: global_chairmans_bonus {
    type: number
    value_format: "#,##0.000"
    sql: ${TABLE}.globalchairmansbonus ;;
  }

  dimension: global_cc {
    label: "Global CC"
    value_format: "#,##0.000"
    type: number
    sql: ${TABLE}.globalcasecredits ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: disclosure_personal_bonus {
    type: number
    sql: ${TABLE}.disclosurepersonalbonus ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: disclosure_personal_discount {
    type: number
    sql: ${TABLE}.disclosurepersonaldiscount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: personal_discount_currency {
    type: string
    sql:${currencycode} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: disclosure_total_income {
    type: number
    sql: ${TABLE}.disclosuretotalincome ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: gem_amount {
    type: number
    sql: ${TABLE}.gemamount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: net_monthly_bonus {
    type: number
    sql: ${TABLE}.netmonthlybonus ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: leadership_bonus {
    type: string
    sql: ${TABLE}.leadershipbonus ;;
    #value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: ndp_amount {
    label: "NDP Amount"
    type: number
    sql: ${TABLE}.ndpamount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: ndp_amount_currency {
    label: "NDP Amount Currency"
    type: string
    sql: ${currencycode} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: other_amounts {
    type: number
    sql: ${TABLE}.otheramounts ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: other_amounts_currency {
    type: string
    sql: ${currencycode} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: retail_amount {
    type: number
    sql: ${TABLE}.retailamount ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: personalbonus {
    label: "Personal Bonus"
    type: number
    sql: ${TABLE}.personalbonus ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: personalbonus_currency {
    label: "Personal Bonus Currency"
    type: string
    sql:  ${currencycode}  ;;
    html: <div><font style="white-space: nowrap;"> {{rendered_value}} </font></div>;;
  }

  dimension: totalcc2mtd {
    label: "Total CC 2MTD"
    value_format: "#,##0.000"
    type: number
    sql: ${TABLE}.totalcc2mtd ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: numberofleadershipmanagers {
    type: number
    sql: ${TABLE}.numberofleadershipmanagers ;;
  }

  dimension: leadership_bonus_required {
    type: number
    value_format: "#,##0.000"
    label: "Leadership Bonus Required CCs"
    sql: CASE WHEN ${numberofleadershipmanagers} >= 3 THEN 4
              WHEN ${numberofleadershipmanagers} = 2 THEN 8
              ELSE 12
         END ;;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: groupbonus {
    type: number
    label: "Group Bonus"
    sql: ${TABLE}.groupbonus ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }
  dimension: pc_cc {
    description: "This field shows PC CCs."
    label: "PC CC"
    type: number
    sql: ${TABLE}.distributorccmtd ;;
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
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: group_bonus {
    description: "This field shows group bonus."
    type: number
    value_format: "#,##0.000"
    sql: ${TABLE}.groupbonus ;;
  }

  dimension: isdelete {
    hidden: yes
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: ishomecountryrecord {
    hidden: yes
    type: string
    sql: ${TABLE}.ishomecountryrecord ;;
  }

  dimension: leadership_qual_cc {
    description: "This field shows leadership qualification CCs."
    label: "Leadership Qual CC"
    type: number
    sql: ${TABLE}.leadershipcasecreditsmonthtodate ;;
  }

  dimension: leadership_flag {
    description: "This field shows leadership qualification flag."
    label: "Leadership Flag"
    type: string
    sql: ${TABLE}.leadershipqualifiedflag ;;
  }

  dimension: leadership_qualified {
    description: "This field indicates leadership qualification."
    label: "Leadership Qualified"
    type: string
    sql: ${TABLE}.leadershipqualifiedindicator ;;
  }

  dimension: leadership_qualified_flag {
    description: "This field was supposed to indicate leadership qualification, but may be inaccurate."
    label: "Leadership Qualified Flag"
    type: string
    sql: CASE WHEN ${TABLE}.leadershipqualifiedflag = 'true' THEN 'Yes'
              ELSE 'No'
         END ;;
  }

  dimension: memberkey {
    hidden: yes
    type: number
    sql: ${TABLE}.memberkey ;;
  }

  dimension: monthlycckey {
    hidden: yes
    type: number
    sql: ${TABLE}.monthlycckey ;;
  }

  dimension: monthly_cc_name {
    description: "This field shows monthly cc name."
    label: "Monthly Name"
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: non_manager_2mo_cc {
    description: "This field shows non manager 2 month CCs."
    label: "Non Manager 2MO CC"
    type: number
    sql: ${TABLE}.nonmanagercc2mtd ;;
  }

  dimension: non_manager_cc{
    description: "This field shows non manager CCs."
    label: "Non Manager CC"
    value_format: "#,##0.000"
    type: number
    sql: ${TABLE}.nonmanagerccmtd ;;
  }

  dimension: location_opco {
    description: "This field shows monthly cc operating company code."
    label: "OpCO"
    suggest_explore: member_details
    suggest_dimension: dim_member.opco
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: personal_bonus {
    description: "This field shows personal bonus."
    type: number
    value_format: "#,##0.000"
    sql: ${TABLE}.personalbonus ;;
  }

  dimension: personal_2mo_cc {
    description: "This field shows personal 2 month CCs."
    label: "Personal 2MO CC"
    type: number
    sql: ${TABLE}.personalcc2mtd ;;
  }

  dimension: personal_cc {
    description: "This field shows personal CCs."
    label: "Personal CC"
    value_format: "#,##0.000"
    type: number
    sql: ${TABLE}.personalccmtd ;;
  }

  dimension: processing_month {
    type: number
    sql: ${TABLE}.processingmonth ;;
  }

  dimension: processing_year {
    type: number
    sql: ${TABLE}.processingyear ;;
  }

  dimension: processing_period {
    label: "processing_period"
    description: "This field shows processing period of monthly cc."
    type: string
    sql: lpad(${processing_month},2,0) || '-' || ${processing_year};;
    html: <font style="white-space: nowrap;">{{ rendered_value }}</font> ;;
  }

  dimension: total_active_2mo_cc {
    description: "This field shows total active 2 month CCs."
    label: "Total Active 2MO CC"
    type: number
    sql: ${TABLE}.totalactivecc2mtd ;;
  }

  dimension: total_active_cc {
    description: "This field shows total active CCs."
    label: "Total Active CC"
    type: number
    sql: ${TABLE}.totalactiveccmtd ;;
  }

  dimension: total_2mo_cc {
    description: "This field shows total 2 month CCs."
    label: "Total 2MO CC"
    type: number
    sql: ${TABLE}.totalcc2mtd ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: country_code {
    label: "Country Code"
    type: string
    sql: ${TABLE}.countrycode ;;
  }

  dimension: numberofcbmanagers {
    label: "Number of Chairman Managers"
    type: number
    sql: ${TABLE}.numberofcbmanagers ;;
  }

  dimension: globalchairmansbonus {
    label: "CB Global New CCs"
    type: number
    sql: ${TABLE}.globalchairmansbonus ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: chairmansbonuspersonalnonmanagercc {
    label: "CB Personal/Non Manager CC"
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercc ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: downlinechairmansbonusqualifiers {
    type: string
    sql: ${TABLE}.downlinechairmansbonusqualifiers ;;
  }

  dimension: numberofdownlinemanagerswith600cc {
    label: "Downline Manage with 600 CC"
    type: number
    sql: ${TABLE}.numberofdownlinemanagerswith600cc ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension:downlinechairmansbonusqualifiers_count  {
    label: "CB Downline Managers"
    type: number
    sql:LEN(replace(${downlinechairmansbonusqualifiers},'|',''))/12 ;;
  }

  dimension: earned_incentive {
    type: string
    sql: ${TABLE}.earnedincentiveactive ;;
  }

  dimension: earned_incentive_amount {
    type: number
    value_format: "#,##0.000"
    sql: ${TABLE}.earnedincentiveamount ;;
  }

  dimension_group: earned_incentive_expiration {
    type: time
    timeframes: [
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.earnedincentiveexpirationdate ;;
  }

  dimension: earned_incentive_level {
    type: string
    sql: ${TABLE}.earnedincentivelevel ;;
  }

  dimension_group: earned_incentive_qualification {
    type: time
    timeframes: [
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.earnedincentivequalificationdate ;;
  }

  dimension_group: earned_requalification_start {
    label: "Earned Re-Qualificcation Start"
    type: time
    timeframes: [
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.earnedrequalificationstartdate ;;
  }

  dimension: eaglemanagerlevel {
    label: "Eagle Manager Level"
    type: string
    sql: ${TABLE}.eaglemanagerlevel ;;
  }

  dimension: eaglemanagertotalcc {
    label: "Eagle Manager Total CC"
    type: number
    sql: ${TABLE}.eaglemanagertotalcc ;;
  }

  dimension: globaleaglemanager {
    label: "Eagle Manager Global New CC"
    type: number
    sql: ${TABLE}.globaleaglemanager ;;
  }

  dimension: homecountryeaglemanagercc {
    label: "Eagle Manager Home Country New CC"
    type: number
    sql: ${TABLE}.homecountryeaglemanagercc ;;
  }

  dimension: downlineeaglemanagerqualifiers {
    label: "Downline Eagle Manager Qualiers"
    type: string
    sql: ${TABLE}.downlineeaglemanagerqualifiers ;;
  }

  dimension: downlineeaglemanagerqualifiers_count {
    label: "Downline Eagle Manager Qualiers"
    type: number
    sql: LEN(replace(${downlineeaglemanagerqualifiers},'|',''))/12   ;;
  }


  dimension: downlineeaglemanagersupervisors {
    label: "Downline Eagle Manager Supervisors"
    type: string
    sql: ${TABLE}.downlineeaglemanagersupervisors ;;
  }

  dimension: personal_plus_nonmanagercc {
    label: "Combined CC"
    type: number
    sql: ${personal_cc}+${non_manager_cc} ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: externalsequencenumber {
    type: number
    sql: ${TABLE}.externalsequencenumber ;;
  }

  measure: count {
    description: "This field shows the Count of Monthly CC."
    label: "Monthly CC Count"
    type: count
    drill_fields: [distributorid]
#     html: <div style="background-color: #636362;padding-top:40 px;padding-bottom:10 px">
#
#     <div style="white-space: nowrap;font-size:70%;color:#ffcc00" ><b> {{value}}</b></div>
#     <div style="white-space: nowrap;font-size:60%;color:white" ><b> {{ "Count" }}</b></div>
#     </div>;;
  }

  measure: 4cc_active_count  {
    label: "Month 4CC Active Count"
    description: "This field shows month 4CC active count."
    type: count_distinct
    sql: ${distributorid} ;;
    filters: {
      field: 4cc_active
      value: "Yes"
    }
  }

  measure: monthlycc_record_count{
    label: "MonthlyCC Records Count"
    type: count_distinct
    sql: ${externalsequencenumber} ;;
  }

  parameter: parameter_period_upto_last_month {
    type: string
    suggest_explore: period_suggestion_upto_lastmont
    suggest_dimension: dim_monthlycc.period
  }

  set: detail {
    fields: [

    ]
  }
}
