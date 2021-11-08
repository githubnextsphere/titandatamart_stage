view: vw_chairman_bonus_manager_lines {
  derived_table: {
    sql: select
      fc.frontlineid as "Front Line ID",
      (coalesce(dm.memberfirstname ,'') + ' ' + COALESCE (dm.memberlastname ,'')) as "Front Line Name",
      fc.cb_id as "CB Mgr ID",
      (coalesce(cb.memberfirstname ,'') + ' ' + COALESCE (cb.memberlastname ,'')) as "CB Mgr Name",
      fc.country as "Country",
      fc.generation as "Generation",
      fc.cblevel as "CB Level",
      fc.downlinecbcount as "Downline CB Managers",
      fc."period"
      from prod2aggregation_tbe.fact_cblines fc
      Join prod2.dim_member dm on dm.distributorid =fc.frontlineid
      and ISNULL(fc.isdelete,'') != 'D' and ISNULL(dm.isdelete,'') != 'D'
      Join prod2.dim_member cb  on cb.distributorid =fc.cb_id
      and ISNULL(cb.isdelete,'') != 'D'
      WHERE
        fc.distributorid = Replace(Replace({{ fboid_param._parameter_value }},'-',''),' ','')
        and fc.period = {% parameter parameter_year  %}
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: parameter_year {
    label: "Period"
    type: number
    allowed_value: { value: "2020"}
    allowed_value: { value: "2021" }
    allowed_value: {value:"2022"}
    default_value: "2022"
  }

  parameter: fboid_param {
    label:"FBO ID"
    type: string
  }
  dimension: front_line_id {
    type: string
    label: "Front Line ID"
    sql:SUBSTRING(${TABLE}."front line id" , 1,3) + '-' + SUBSTRING(${TABLE}."front line id" , 4,3) + '-' + SUBSTRING(${TABLE}."front line id" , 7,3) + '-' + SUBSTRING(${TABLE}."front line id" , 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: front_line_name {
    type: string
    label: "Front Line Name"
    sql: ${TABLE}."front line name" ;;
  }

  dimension: cb_mgr_id {
    type: string
    label: "CB Mgr ID"
    sql:SUBSTRING(${TABLE}."cb mgr id" , 1,3) + '-' + SUBSTRING(${TABLE}."cb mgr id" , 4,3) + '-' + SUBSTRING(${TABLE}."cb mgr id", 7,3) + '-' + SUBSTRING(${TABLE}."cb mgr id", 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: cb_mgr_name {
    type: string
    label: "CB Mgr Name"
    sql: ${TABLE}."cb mgr name" ;;
  }

  dimension: country {
    type: string
    label: "Country"
    sql: ${TABLE}.country ;;
  }

  dimension: generation {
    type: number
    label: "Generation"
    sql: ${TABLE}.generation ;;
  }

  dimension: cb_level {
    type: number
    label: "CB Level"
    sql: ${TABLE}."cb level" ;;
  }

  dimension: chairmanbonuslevel {
    label: "Level Achieved"
    case: {
      when: {
        sql: ${cb_level} = '0' ;;
        label: "Level-0"
      }
      when: {
        sql: ${cb_level} = '1' ;;
        label: "Level-1"
      }
      when: {
        sql: ${cb_level} = '2' ;;
        label: "Level-2"
      }
      when: {
        sql: ${cb_level} = '3' ;;
        label: "Level-3"
      }
    }
  }
  dimension: downline_cb_managers {
    type: number
    label: "Downline CB Managers"
    sql: ${TABLE}."downline cb managers" ;;
    html:{% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6321?FBO+ID={{cb_mgr_id._value}}&Period={{_filters['vw_chairman_bonus_manager_lines.parameter_year']}}" target="_blank">
    <font color="blue" style="white-space: nowrap;">
    <u> {{ rendered_value  }} </u>
    </font>
    </a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: period {
    type: number
    label: "Period"
    sql: ${TABLE}.period ;;
    value_format: "0"
  }

  set: detail {
    fields: [
      front_line_id,
      front_line_name,
      cb_mgr_id,
      cb_mgr_name,
      country,
      generation,
      cb_level,
      downline_cb_managers,
      period
    ]
  }
 }
