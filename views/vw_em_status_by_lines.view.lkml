view: vw_em_status_by_lines {
 derived_table: {
  sql: SELECT
          LPAD(d.DistributorId,12,0) as "FBO ID",
          (coalesce(m3.memberfirstname,'') + ' ' + COALESCE (m3.memberlastname,'')) as "FBO Name",
          LPAD(d.frontlineid,12,0) as "Frontline ID",
          (coalesce(m2.memberfirstname,'') + ' ' + COALESCE (m2.memberlastname,'')) as "Front Line Name",
          LPAD(d.Mgr_Id,12,0) as "Manager ID",
          (coalesce(m.memberfirstname,'') + ' ' + COALESCE (m.memberlastname,'')) as "Manager Name",
          d.Generation,
          e.Period,
          e.EMLevel as "EM Level",
          e.QualifyingCountry as "Qualifying OpCo",
          m.operatingcompanycode as "Home OpCO",
          m.homecompanycode as "Home Country Code",
          e.HomeCountry as "Home Country",
          e.TotalCC_QC as "Total CC QC",
          e.NewCC_OQC as "New CC OQC",
          e.NewCC_QC as "New CC QC",
          e.TotalCCGlobalCap as "Global Total CC",
          e.NewCCGlobalCap as "Global New CC",
          e.EMLines as "EM Lines",
          e.DownlineEMCount as "EM Count",
          e.HomeCountryActive as "Active All months",
          e.NewSupervisorsCount as "New Sup. Count",
          e.IsEMEligible as "Basic Req Met",
          e.StartLevel as "Start Level",
          e.EndLevel as "End Level",
          e.MgrFirstMonth as "MGR 1st Mo",
          e.MgrFirstMonthTotalCC as "MGR 1st Mo Total CC",
          m3.operatingcompanycode as "Upline FBO OpCO"
      FROM prod2aggregation_tbe.fact_emmgrsindownline d
      inner join prod2aggregation_tbe.fact_emqualification e
      on LPAD(d.Mgr_Id,12,0) = e.DistributorId
      and ISNULL(d.isdelete,'') != 'D' and ISNULL(e.isdelete,'') != 'D'
      case when {% parameter parameter_year  %} = 'Current Period'
                then  e.Period = EXTRACT(YEAR FROM CURRENT_DATE)
            when {% parameter parameter_year  %} = 'Last Period'
                then  e.Period = EXTRACT(YEAR FROM CURRENT_DATE) -1
      end
      inner join prod2.dim_member m
      on m.DistributorId = e.DistributorId
      and ISNULL(m.isdelete,'') != 'D'
      inner join prod2.dim_member m2
      on LPAD(d.FrontLineID,12,0) = m2.DistributorId
      and ISNULL(m2.isdelete,'') != 'D'
      inner join prod2.dim_member m3
      on LPAD(d.DistributorId,12,0) = m3.DistributorId
      and ISNULL(m3.isdelete,'') != 'D'
      left join prod2aggregation_tbe.fact_emlines e2
      on e2.FrontLineID = LPAD(d.FrontLineID,12,0)
      and e2.Country = e.QualifyingCountry
      and ISNULL(e2.isdelete,'') != 'D'
      and case when {% parameter parameter_year  %} = 'Current Period'
                then  e2.Period = EXTRACT(YEAR FROM CURRENT_DATE)
              when {% parameter parameter_year  %} = 'Last Period'
                then  e2.Period = EXTRACT(YEAR FROM CURRENT_DATE) -1
      end
      where
      case when {% parameter exclude_emlines_param  %} = 'Yes' then
           e2.DistributorId is null
          else 1=1
      end
      and
      case when {% parameter parameter_year  %} = 'Current Period'
                then  d.Period = EXTRACT(YEAR FROM CURRENT_DATE)
            when {% parameter parameter_year  %} = 'Last Period'
                then  d.Period = EXTRACT(YEAR FROM CURRENT_DATE) -1
      end
      order by d.FrontLineID, e.TotalCCGlobalCap, e.NewCCGlobalCap
       ;;
}

  measure: count {
    type: count
    label: "Count"
  }

  filter: fbofilter {
    type: string
    sql: {% condition fbofilter %} ${fbo_id} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format1} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format2} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format3} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format4} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format5} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format6} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format7} {% endcondition %}
            or {% condition fbofilter %} ${fbo_id_format8} {% endcondition %};;
    suggest_dimension: fbo_id
  }

   dimension: fbo_id {
      type: string
      label: "FBO ID"
      description: "FBO ID (000-000-000-000)"
      sql: SUBSTRING(${TABLE}."fbo id" , 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3)
          + '-' + SUBSTRING(${TABLE}."fbo id" , 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3);;
      html: {% if value != 0 %}
            <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{fbo_id._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
            {% else %}
            {{rendered_value}}
            {% endif %} ;;

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

    dimension: fbo_id_format4 {
      type: string
      label: "FBO ID Format4"
      description: "FBO ID (000 000 000-000)"
      sql:SUBSTRING(${TABLE}."fbo id", 1,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 4,3) + ' ' + SUBSTRING(${TABLE}."fbo id", 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
    }

    dimension: fbo_id_format5 {
      type: string
      label: "FBO ID Format5"
      description: "FBO ID (000-000 000 000)"
      sql:SUBSTRING(${TABLE}."fbo id", 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3) + ' ' + SUBSTRING(${TABLE}."fbo id", 7,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
    }

    dimension: fbo_id_format6 {
      type: string
      label: "FBO ID Format6"
      description: "FBO ID (000-000-000 000)"
      sql:SUBSTRING(${TABLE}."fbo id", 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3) + '-' + SUBSTRING(${TABLE}."fbo id", 7,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
    }

    dimension: fbo_id_format7 {
      type: string
      label: "FBO ID Format7"
      description: "FBO ID (000 000-000 000)"
      sql:SUBSTRING(${TABLE}."fbo id", 1,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 4,3) + '-' + SUBSTRING(${TABLE}."fbo id", 7,3) + ' ' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
    }

    dimension: fbo_id_format8 {
      type: string
      label: "FBO ID Format8"
      description: "FBO ID (000-000 000-000)"
      sql:SUBSTRING(${TABLE}."fbo id", 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3) + ' ' + SUBSTRING(${TABLE}."fbo id", 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3) ;;
    }

  dimension: fbo_name {
    type: string
    label: "Name"
    sql: ${TABLE}."fbo name" ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  filter: frontlineidfilter {
  type: string
  sql: {% condition frontlineidfilter %} ${frontline_id} {% endcondition %}         or {% condition frontlineidfilter %} ${frontline_id_format1} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format2} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format3} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format4} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format5} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format6} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format7} {% endcondition %}
    or {% condition frontlineidfilter %} ${frontline_id_format8} {% endcondition %};;
    suggest_dimension: frontline_id
  }

  dimension: frontline_id {
    type: string
    label: "Front Line ID"
    description: "Front Line ID (000-000-000-000)"
    sql: SUBSTRING(${TABLE}."frontline id" , 1,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."frontline id" , 7,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 10,3);;
    html: {% if value != 0 %}
        <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{frontline_id._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
        {% else %}
        {{rendered_value}}
        {% endif %} ;;

    }

    dimension: frontline_id_format1 {
      type: string
      label: "Front Line ID Format"
      description: "Front Line ID (000000000000)"
      sql: ${TABLE}."frontline id" ;;
    }

    dimension: frontline_id_format2 {
      type: string
      label: "Front Line ID Format2"
      description: "Front Line ID (000 000 000 000)"
      sql: SUBSTRING(${TABLE}."frontline id" , 1,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 4,3)
        + ' ' + SUBSTRING(${TABLE}."frontline id" , 7,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

    dimension: frontline_id_format3 {
      type: string
      label: "Front Line ID Format3"
      description: "Front Line ID (000 000-000-000)"
      sql:SUBSTRING(${TABLE}."frontline id", 1,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 4,3) + '-' + SUBSTRING(${TABLE}."frontline id", 7,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

    dimension: frontline_id_format4 {
      type: string
      label: "Front Line ID Format4"
      description: "Front Line ID (000 000 000-000)"
      sql:SUBSTRING(${TABLE}."frontline id", 1,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 4,3) + ' ' + SUBSTRING(${TABLE}."frontline id", 7,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

    dimension: frontline_id_format5 {
      type: string
      label: "Front Line ID Format5"
      description: "Front Line ID (000-000 000 000)"
      sql:SUBSTRING(${TABLE}."frontline id", 1,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 4,3) + ' ' + SUBSTRING(${TABLE}."frontline id", 7,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

    dimension: frontline_id_format6 {
      type: string
      label: "Front Line ID Format6"
      description: "Front Line ID (000-000-000 000)"
      sql:SUBSTRING(${TABLE}."frontline id", 1,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 4,3) + '-' + SUBSTRING(${TABLE}."frontline id", 7,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

    dimension: frontline_id_format7 {
      type: string
      label: "Front Line ID Format7"
      description: "Front Line ID (000 000-000 000)"
      sql:SUBSTRING(${TABLE}."frontline id", 1,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 4,3) + '-' + SUBSTRING(${TABLE}."frontline id", 7,3) + ' ' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

    dimension: frontline_id_format8 {
      type: string
      label: "Front Line ID Format8"
      description: "Front Line ID (000-000 000-000)"
      sql:SUBSTRING(${TABLE}."frontline id", 1,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 4,3) + ' ' + SUBSTRING(${TABLE}."frontline id", 7,3) + '-' + SUBSTRING(${TABLE}."frontline id" , 10,3) ;;
    }

  dimension: front_line_name {
    type: string
    label: "Front Line Name"
    sql: ${TABLE}."front line name" ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  filter: manageridfilter {
  type: string
  sql: {% condition manageridfilter %} ${manager_id} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format1} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format2} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format3} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format4} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format5} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format6} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format7} {% endcondition %}
        or {% condition manageridfilter %} ${manager_id_format8} {% endcondition %};;
    suggest_dimension: manager_id
  }

 dimension: manager_id {
    type: string
    label: "Manager ID"
    description: "Manager ID (000-000-000-000)"
    sql: SUBSTRING(${TABLE}."manager id" , 1,3) + '-' + SUBSTRING(${TABLE}."manager id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."manager id" , 7,3) + '-' + SUBSTRING(${TABLE}."manager id" , 10,3);;
    html: {% if value != 0 %}
        <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id={{manager_id._value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
        {% else %}
        {{rendered_value}}
        {% endif %} ;;

    }

    dimension: manager_id_format1 {
      type: string
      label: "Manager ID Format"
      description: "Manager ID (000000000000)"
      sql: ${TABLE}."manager id" ;;
    }

    dimension: manager_id_format2 {
      type: string
      label: "Manager ID Format2"
      description: "Manager ID (000 000 000 000)"
      sql: SUBSTRING(${TABLE}."manager id" , 1,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 4,3)
        + ' ' + SUBSTRING(${TABLE}."manager id" , 7,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

    dimension: manager_id_format3 {
      type: string
      label: "Manager ID Format3"
      description: "Manager ID (000 000-000-000)"
      sql:SUBSTRING(${TABLE}."manager id", 1,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 4,3) + '-' + SUBSTRING(${TABLE}."manager id", 7,3) + '-' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

    dimension: manager_id_format4 {
      type: string
      label: "Manager ID Format4"
      description: "Manager ID (000 000 000-000)"
      sql:SUBSTRING(${TABLE}."manager id", 1,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 4,3) + ' ' + SUBSTRING(${TABLE}."manager id", 7,3) + '-' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

    dimension: manager_id_format5 {
      type: string
      label: "Manager ID Format5"
      description: "Manager ID (000-000 000 000)"
      sql:SUBSTRING(${TABLE}."manager id", 1,3) + '-' + SUBSTRING(${TABLE}."manager id" , 4,3) + ' ' + SUBSTRING(${TABLE}."manager id", 7,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

    dimension: manager_id_format6 {
      type: string
      label: "Manager ID Format6"
      description: "Manager ID (000-000-000 000)"
      sql:SUBSTRING(${TABLE}."manager id", 1,3) + '-' + SUBSTRING(${TABLE}."manager id" , 4,3) + '-' + SUBSTRING(${TABLE}."manager id", 7,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

    dimension: manager_id_format7 {
      type: string
      label: "Manager ID Format7"
      description: "Manager ID (000 000-000 000)"
      sql:SUBSTRING(${TABLE}."manager id", 1,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 4,3) + '-' + SUBSTRING(${TABLE}."manager id", 7,3) + ' ' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

    dimension: manager_id_format8 {
      type: string
      label: "Manager ID Format8"
      description: "Manager ID (000-000 000-000)"
      sql:SUBSTRING(${TABLE}."manager id", 1,3) + '-' + SUBSTRING(${TABLE}."manager id" , 4,3) + ' ' + SUBSTRING(${TABLE}."manager id", 7,3) + '-' + SUBSTRING(${TABLE}."manager id" , 10,3) ;;
    }

  dimension: manager_name {
    type: string
    label: "Manager Name"
    sql: ${TABLE}."manager name" ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: generation {
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
    value_format: "0"
  }

  dimension: em_level {
    type: number
    hidden: yes
    label: "EM Level"
    sql: ${TABLE}."em level" ;;
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

  dimension: qualifying_opco {
    type: string
    label: "Qualifying OpCO"
    sql: ${TABLE}."qualifying opco" ;;
    case_sensitive: no
  }

  dimension: home_opco {
    type: string
    label: "Home OpCO"
    sql: ${TABLE}."home opco" ;;
    case_sensitive: no
  }

  dimension: home_country_code {
    type: string
    label: "Home Country Code"
    sql: ${TABLE}."home country code" ;;
    case_sensitive: no
  }


  dimension: home_country {
    type: string
    label: "Home Country"
    sql: ${TABLE}."home country" ;;
    case_sensitive: no
  }

  dimension: total_cc_qc {
    type: number
    label: "Total CC QC"
    sql: ${TABLE}."total cc qc" ;;
    value_format: "#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: new_cc_qc {
    type: number
     label: "New CC QC"
    sql: ${TABLE}."new cc qc" ;;
    value_format:"#,##0.000"
    html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6218?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
  }

  dimension: em_lines {
    type: number
    label: "EM Lines"
    sql: ${TABLE}."em lines" ;;
    html:
    {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6224?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
    <a href="https://foreverliving.looker.com/dashboards-next/6245?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: active_all_months {
    type: string
    label: "Active All Months"
    sql: case when ${TABLE}."active all months" = 1 then 'Yes'
               else 'No'
         end;;
    html:
    {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6341?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}&Qualifying+Country={{qualifying_opco._value}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  dimension: new_sup_count {
    type: number
    label: "New Sup. Count"
    sql: ${TABLE}."new sup. count" ;;
    html:
    <a href="https://foreverliving.looker.com/dashboards-next/6244?FBO+ID={{manager_id._value}}&Period={{_filters['vw_em_status_by_lines.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a> ;;
  }

  dimension: basic_req_met {
    type: string
    label: "Basic Reqs Met"
    sql: case when ${TABLE}."basic req met" = 1 then 'Yes'
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

  dimension: mgr_1st_mo {
    type: number
    label: "MGR 1st Mo"
    sql: ${TABLE}."mgr 1st mo" ;;
    value_format:"####-##"
  }

  dimension: mgr_1st_mo_total_cc {
    type: number
    label: "MGR 1st Mo Total CC"
    sql: ${TABLE}."mgr 1st mo total cc" ;;
    value_format:"#,##0.000"
  }

  dimension: upline_fbo_opco {
    type: string
    label: "Upline FBO OpCO"
    sql: ${TABLE}."upline fbo opco" ;;
    case_sensitive: no
  }

  parameter: parameter_year {
    type: string
    allowed_value: { label: "May-2020 to April-2021" value:"Current Period" }
    default_value: "Current Period"
  }

  parameter: exclude_emlines_param {
    type: string
    label: "Exclude qualified EM Lines"
    allowed_value: {
      label: "Yes"
      value:"Yes"
    }
    allowed_value: {
      label: "No"
      value:"No"}
    default_value: "No"
  }


set: detail {
  fields: [
    fbo_id,
    fbo_name,
    frontline_id,
    front_line_name,
    manager_id,
    manager_name,
    generation,
    period,
    em_level,
    qualifying_opco,
    home_country,
    total_cc_qc,
    new_cc_oqc,
    new_cc_qc,
    global_total_cc,
    global_new_cc,
    em_lines,
    em_count,
    active_all_months,
    new_sup_count,
    basic_req_met,
    start_level,
    end_level,
    mgr_1st_mo,
    mgr_1st_mo_total_cc
  ]
}
}
