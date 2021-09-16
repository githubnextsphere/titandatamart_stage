view: tbeprod_vw_chairman_bonus_qualifiers {
  derived_table: {
    sql: select
        cbq.distributorid as fbo_id,
        mem.memberfirstname || ' ' || mem.memberlastname as fbo_name,
        mem.memberlevel as level,
        case
          when mem.homephone != '' then mem.homephone
          when mem.mobilenumber != '' then mem.mobilenumber
          when mem.alternatephone1 != '' then mem.alternatephone1
          else mem.alternatephone2
        end as phone,
        mem.emailaddress as email,
        cbq.period,
        mem.city,
        mem.operatingcompanycode as opco,
        mem.homecompanycode as home_country,
        cbq.qualifyingcountry as qualifying_country,
        cbq.totalcc_qc as total_cc,
        cbq.opengroupcc_qc as open_group_cc,
        cbq.opengroupccglobalcap as open_group_cc_global,
        cbq.newccglobalcap as new_cc_global_capped,
        cbq.newcc_qc as new_cc_qc,
        cbq.newcc_oqc as new_cc_oqc,
        cbq.level as level_achieved,
        cbq."600ccmgrlines" as "600CC_mgr_lines",
        cbq.downline600ccmgrcount as "600CC_mgr_count",
        cbq.cblines as cb_mgr_lines,
        cbq.downlinecbcount as cb_mgr_count,
        cbq. mgrfirstmonth mgr_first_month,
        cbq. mgrfirstmonthopengroupcc mgr_1st_month_open_group_cc,
        cbq. mgrfirstmonthtotalcc as mgr_1st_month_total_cc
      from prodaggregation_sql.fact_cbindownline fc
join prod_as400.dim_member mem on
  mem.distributorid = fc.cb_id
JOIN prodaggregation_sql.fact_cbqualification cbq on
  cbq.distributorid = fc.cb_id
   and cbq.period =  {% parameter parameter_year  %}
      WHERE
          fc.distributorid = Replace(Replace({{ fboid_param._parameter_value }},'-',''),' ','')
          and fc.period = {% parameter parameter_year  %}
          ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fbo_id {
    type: string
    label: "FBO ID"
    sql:SUBSTRING(${TABLE}.fbo_id, 1,3) + '-' + SUBSTRING(${TABLE}.fbo_id , 4,3) + '-' + SUBSTRING(${TABLE}.fbo_id, 7,3) + '-' + SUBSTRING(${TABLE}.fbo_id , 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: fbo_name {
    type: string
    label: "FBO Name"
    sql: ${TABLE}.fbo_name ;;
  }

  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
  }

  dimension: chairmanbonuslevel {
    label: "Level Achieved"
    case: {
      when: {
        sql: ${level_achieved} = '0' ;;
        label: "Level-0"
      }
      when: {
        sql: ${level_achieved} = '1' ;;
        label: "Level-1"
      }
      when: {
        sql: ${level_achieved} = '2' ;;
        label: "Level-2"
      }
      when: {
        sql: ${level_achieved} = '3' ;;
        label: "Level-3"
      }
    }
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
    value_format: "0"
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: opco {
    type: string
    label: "OpCO"
    sql: ${TABLE}.opco ;;
  }

  dimension: home_country {
    type: string
    label: "Home Country Code"
    sql: ${TABLE}.home_country ;;
  }

  dimension: qualifying_country {
    type: string
    sql: ${TABLE}.qualifying_country ;;
  }

  dimension: total_cc {
    type: number
    label: "Total CC"
    sql: ${TABLE}.total_cc ;;
    value_format: "#,##0.000"
  }

  dimension: open_group_cc {
    type: number
    label: "Open Group CC"
    sql: ${TABLE}.open_group_cc ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6304?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;

  }

  dimension: open_group_cc_global {
    type: number
    label: "Open Group CC Global"
    sql: ${TABLE}.open_group_cc_global ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6304?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: new_cc_global_capped {
    type: number
    label: "New CC Global Capped"
    sql: ${TABLE}.new_cc_global_capped ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6304?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: new_cc_qc {
    type: number
    label: "New CC QC"
    sql: ${TABLE}.new_cc_qc ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6304?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: new_cc_oqc {
    type: number
    label: "New CC OQC"
    sql: ${TABLE}.new_cc_oqc ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6304?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: level_achieved {
    type: number
    sql: ${TABLE}.level_achieved ;;
  }

  dimension: 600cc_mgr_lines {
    type: number
    label: "600CC Mgr Lines"
    sql: ${TABLE}."600cc_mgr_lines" ;;
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6325?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: 600cc_mgr_count {
    type: number
    label: "600CC Mgr Count"
    sql: ${TABLE}."600cc_mgr_count" ;;
  }

  dimension: cb_mgr_lines {
    type: number
    label: "CB Mgr lines"
    sql: ${TABLE}.cb_mgr_lines ;;
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6303?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: cb_mgr_count {
    type: number
    label: "CB Mgr Count"
    sql: ${TABLE}.cb_mgr_count ;;
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6321?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairman_bonus_qualifiers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: mgr_first_month {
    type: number
    sql: ${TABLE}.mgr_first_month ;;
    value_format: "####-##"
  }

  dimension: mgr_1st_month_open_group_cc {
    type: number
    label: "Mgr 1st Month Open Group CC"
    sql: ${TABLE}.mgr_1st_month_open_group_cc ;;
    value_format: "#,##0.000"
  }

  dimension: mgr_1st_month_total_cc {
    type: number
    label: "Mgr 1st Month Total CC"
    sql: ${TABLE}.mgr_1st_month_total_cc ;;
    value_format: "#,##0.000"
  }

  parameter: fboid_param {
    label:"FBO_ID"
    type: string
  }

  parameter: parameter_year {
    label: "Period"
    type: number
    allowed_value: { value: "2022"}
    allowed_value: { value: "2021" }
    allowed_value: {value:"2020"}
    default_value: "2022"
  }

  set: detail {
    fields: [
      fbo_id,
      fbo_name,
      level,
      phone,
      email,
      period,
      city,
      opco,
      home_country,
      qualifying_country,
      total_cc,
      open_group_cc,
      open_group_cc_global,
      new_cc_global_capped,
      new_cc_qc,
      new_cc_oqc,
      level_achieved,
      600cc_mgr_lines,
      600cc_mgr_count,
      cb_mgr_lines,
      cb_mgr_count,
      mgr_first_month,
      mgr_1st_month_open_group_cc,
      mgr_1st_month_total_cc
    ]
  }
}
