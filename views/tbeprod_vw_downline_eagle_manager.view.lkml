view: tbeprod_vw_downline_eagle_manager {
  derived_table: {
    sql: select
      feq.DistributorId as "FBO ID",
      (coalesce(mem.memberfirstname ,'') + ' ' + COALESCE (mem.memberlastname ,'')) as Name,
      feq.Period,
      feq.QualifyingCountry as "Qualifying Country",
      feq.HomeCountry as "Home Country",
      feq.TotalCC_QC as "Total CC QC",
      feq.NewCC_OQC as "New CC OQC",
      feq.NewCC_QC as "New CC QC",
      feq.TotalCCGlobalCap as "Global Total CC",
      feq.NewCCGlobalCap as "Global New CC",
      feq.EMLines as "EM Lines",
      feq.DownlineEMCount as "EM Count",
      feq.HomeCountryActive as "Active All Mos",
      feq.NewSupervisorsCount as "New Sup. Count",
      nvl(feq.IsEMEligible,0) as "Is EMEligible",
      feq.StartLevel as "Start Level",
      feq.EndLevel as "End Level",
      feq.EMLevel as "EM Level",
      feq.MgrFirstMonth as "Mgr 1st Mo",
      feq.MgrFirstMonthTotalCC as "Mgr 1st Mo Total CC"
      FROM
        prod2aggregation.fact_emindownline fe
      JOIN prod2.dim_member mem on
        mem.distributorid = fe.em_id
      JOIN prod2aggregation.fact_emqualification feq on
        feq.distributorid = fe.em_id
         and
        case  when {% parameter parameter_year  %} = 'Current Period'
                then  feq.period =  EXTRACT(YEAR FROM CURRENT_DATE)
              when {% parameter parameter_year  %} = 'Last Period'
                  then  feq.period =  EXTRACT(YEAR FROM CURRENT_DATE) -1
        end
      WHERE
       fe.distributorid = Replace(Replace({{ fboid_param._parameter_value }},'-',''),' ','')
         and
        case  when {% parameter parameter_year  %} = 'Current Period'
                then  fe.period =  EXTRACT(YEAR FROM CURRENT_DATE)
              when {% parameter parameter_year  %} = 'Last Period'
                  then  fe.period =  EXTRACT(YEAR FROM CURRENT_DATE) -1
        end
       ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fbo_id {
    type: string
    label: "FBO ID"
    sql: SUBSTRING(${TABLE}."fbo id" , 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."fbo id" , 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;

  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: qualifying_country {
    type: string
    label: "Qualifying Country"
    sql: ${TABLE}."qualifying country" ;;
  }

  dimension: home_country {
    type: string
    label:"Home Country"
    sql: ${TABLE}."home country" ;;
  }

  dimension: total_cc_qc {
    type: number
    label:"Total CC QC"
    sql: ${TABLE}."total cc qc" ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: new_cc_oqc {
    type: number
    label: "New CC OQC"
    sql: ${TABLE}."new cc oqc" ;;
    value_format:"#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: new_cc_qc {
    type: number
    label:"New CC QC"
    sql: ${TABLE}."new cc qc" ;;
    value_format:"#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: global_total_cc {
    type: number
    label: "Global Total CC"
    sql: ${TABLE}."global total cc" ;;
    value_format:"#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: global_new_cc {
    type: number
    label: "Global New CC"
    sql: ${TABLE}."global new cc" ;;
    value_format:"#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: em_lines {
    type: number
    label:"EM Lines"
    sql: ${TABLE}."em lines" ;;
    html:
    {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6224?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: em_count {
    type: number
    label: "EM Count"
    sql: ${TABLE}."em count" ;;
    html:
    {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6245?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: active_all_mos {
    type: string
    label: "Active All Mos"
    sql: case when ${TABLE}."active all mos" = 1 then 'Yes'
        else 'No'
        end;;
  }

  dimension: new_sup__count {
    type: number
    label: "New Sup. Count"
    sql: ${TABLE}."new sup. count" ;;
    html:
    <a href="https://foreverliving.looker.com/dashboards-next/6244?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_downline_eagle_manager.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>;;
  }

  dimension: is_emeligible {
    type: string
    label: "Basic Reqs Met"
    sql: case when ${TABLE}."is emeligible" = 1 then 'Yes'
        else 'No'
        end;;

    }

    dimension: start_level {
      type: number
      label: "Start Level"
      sql: ${TABLE}."start level" ;;
    }

    dimension: end_level {
      type: number
      label: "End Level"
      sql: ${TABLE}."end level" ;;
    }

    dimension: em_level {
      type: number
      label: "EM Level"
      sql: ${TABLE}."em level" ;;
    }

    dimension: mgr_1st_mo {
      type: number
      label: "MGR 1st Mo"
      sql: ${TABLE}."mgr 1st mo" ;;
      value_format:"####-##"
    }

    dimension: mgr_1st_mo_total_cc {
      type: number
      label: "Mgr 1st Mo Total CC"
      sql: ${TABLE}."mgr 1st mo total cc" ;;
      value_format:"#,##0.000"
    }
    dimension: eaglemanagerlevel {
      label: "EM Level"
      case: {
        when: {
          sql: ${em_level} = '0' ;;
          label: "Not Qualified"
        }
        when: {
          sql: ${em_level} = '1' ;;
          label: "Eagle Manager"
        }
        when: {
          sql: ${em_level} = '2' ;;
          label: "Senior Eagle Manager"
        }
        when: {
          sql: ${em_level} = '3' ;;
          label: "Soaring Eagle Manager"
        }
        when: {
          sql: ${em_level} = '4' ;;
          label: "Sapphire Eagle Manager"
        }
        when: {
          sql: ${em_level} = '5' ;;
          label: "Diamond Sapphire Eagle Manager"
        }
        when: {
          sql: ${em_level} = '6' ;;
          label: "Diamond Eagle Manager"
        }
        when: {
          sql: ${em_level} = '7' ;;
          label: "Double Diamond Eagle Manager"
        }
        when: {
          sql: ${em_level} = '8' ;;
          label: "Triple Diamond Eagle Manager"
        }
        when: {
          sql: ${em_level} = '9' ;;
          label: "Diamond Centurion Eagle Manager"
        }
      }
    }
    dimension: period {
      type: number
      sql: ${TABLE}.period ;;
      value_format: "0"
    }

    parameter: parameter_year {
      label: "Period"
      type: string
      allowed_value: { value: "Current Period" label: "May-2020 to April-2021"}
      # allowed_value: { value: "Last Period" }
      default_value: "Current Period"
    }

    parameter: fboid_param {
      label:"FBO_ID"
      type: string
    }

    set: detail {
      fields: [
        fbo_id,
        name,
        period,
        qualifying_country,
        home_country,
        total_cc_qc,
        new_cc_oqc,
        new_cc_qc,
        global_total_cc,
        global_new_cc,
        em_lines,
        em_count,
        active_all_mos,
        new_sup__count,
        is_emeligible,
        start_level,
        end_level,
        em_level,
        mgr_1st_mo,
        mgr_1st_mo_total_cc
      ]
    }
  }
