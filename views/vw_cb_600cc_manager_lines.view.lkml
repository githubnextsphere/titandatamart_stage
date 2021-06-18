view: vw_cb_600cc_manager_lines {
  derived_table: {
    sql: select
      fcc.frontlineid as "Front Line ID",
      (coalesce(dm.memberfirstname ,'') + ' ' + COALESCE (dm.memberlastname ,'')) as "Front Line Name",
      fcc."600cc_id"  as "CB Mgr ID",
      (coalesce(cb.memberfirstname ,'') + ' ' + COALESCE (cb.memberlastname ,'')) as "CB Mgr Name",
      fcc.country as "Country",
      fcc.generation as "Generation",
      fcc."period",
      fc.totalcc_qc
      from prod2aggregation.fact_cb600cclines fcc
      Join prod2.dim_member dm on dm.distributorid =fcc.frontlineid
      Join prod2.dim_member cb  on cb.distributorid =fcc."600cc_id"
      and
        case  when {% parameter parameter_year  %} = 'Current Year'
                then  fcc.period =  EXTRACT(YEAR FROM CURRENT_DATE)
              when {% parameter parameter_year  %} = 'Last Year'
                then  fcc.period =  EXTRACT(YEAR FROM CURRENT_DATE) -1
        end
      JOIN prod2aggregation.fact_cbqualification fc on fc.distributorid =fcc."600cc_id"
      and
        case  when {% parameter parameter_year  %} = 'Current Year'
                then  fc.period =  EXTRACT(YEAR FROM CURRENT_DATE)
              when {% parameter parameter_year  %} = 'Last Year'
                then  fc.period =  EXTRACT(YEAR FROM CURRENT_DATE) -1
        end
      WHERE fcc.distributorid = Replace(Replace({{ fboid_param._parameter_value }},'-',''),' ','')
      and
        case  when {% parameter parameter_year  %} = 'Current Year'
                then  fcc.period =  EXTRACT(YEAR FROM CURRENT_DATE)
              when {% parameter parameter_year  %} = 'Last Year'
                then  fcc.period =  EXTRACT(YEAR FROM CURRENT_DATE) -1
        end
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  parameter: parameter_year {
    label: "Period"
    type: string
    allowed_value: { value: "Current Year" label:"Current Year"}
    allowed_value: { value: "Last Year" label:"Last Year" }
    default_value: "Current Year"
  }

  parameter: fboid_param {
    label:"FBO ID"
    type: string
  }

  dimension: front_line_id {
    type: string
    label: "Front Line ID"
    sql: SUBSTRING(${TABLE}."front line id", 1,3) + '-' + SUBSTRING(${TABLE}."front line id", 4,3) + '-' + SUBSTRING(${TABLE}."front line id", 7,3) + '-' + SUBSTRING(${TABLE}."front line id", 10,3)
      ;;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
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

  dimension: period {
    type: number
    label: "Period"
    value_format:"0"
    sql: ${TABLE}.period ;;
  }

  dimension: totalcc_qc {
    type: number
    label: "TotalCC QC"
    value_format:"#,##0.000"
    sql: ${TABLE}.totalcc_qc ;;
  }

  set: detail {
    fields: [
      front_line_id,
      front_line_name,
      cb_mgr_id,
      cb_mgr_name,
      country,
      generation,
      period,
      totalcc_qc
    ]
  }
}
