view: vw_eagle_managers {
  derived_table: {
    sql: SELECT   fe.DistributorId as "FBO ID",
      (coalesce(dm.memberfirstname ,'') + ' ' + COALESCE (dm.memberlastname ,'')) as Name,
      fe.Period,
      fe.QualifyingCountry as "Qualifying Country",
      fe.HomeCountry,
      fe.TotalCC_QC as "Total CC QC",
      fe.NewCC_OQC as "New CC OQC",
      fe.NewCC_QC as "New CC QC",
      fe.TotalCCGlobalCap as "Global Total CC",
      fe.NewCCGlobalCap as "Global New CC",
      fe.EMLines as "EM Lines",
      fe.DownlineEMCount as "EM Count",
      nvl(fe.HomeCountryActive,0) as "Active All Mos",
      fe.NewSupervisorsCount as "New Sup. Count",
      nvl(fe.IsEMEligible,0) as "Is EMEligible",
      fe.StartLevel as "Start Level",
      fe.EndLevel as "End Level",
      nvl(fe.EMLevel,0) as "EM Level",
      fe.MgrFirstMonth as "Mgr 1st Mo",
      fe.MgrFirstMonthTotalCC as "Mgr 1st Mo Total CC",
      dm.homecompanycode
      FROM   prod2aggregation.fact_emqualification fe
      inner join prod2.dim_member dm
      on dm.DistributorId = fe.DistributorId
      and dm.isdelete <> 'D'
      and ({% condition  opcofilter %} dm.operatingcompanycode {% endcondition %})
      union
      SELECT   fe.DistributorId as "FBO ID",
      (coalesce(dm.memberfirstname ,'') + ' ' + COALESCE (dm.memberlastname ,'')) as Name,
      fe.Period,
      fe.QualifyingCountry as "Qualifying Country",
      fe.HomeCountry,
      fe.TotalCC_QC as "Total CC QC",
      fe.NewCC_OQC as "New CC OQC",
      fe.NewCC_QC as "New CC QC",
      fe.TotalCCGlobalCap as "Global Total CC",
      fe.NewCCGlobalCap as "Global New CC",
      fe.EMLines as "EM Lines",
      fe.DownlineEMCount as "EM Count",
      nvl(fe.HomeCountryActive,0) as "Active All Mos",
      fe.NewSupervisorsCount as "New Sup. Count",
      nvl(fe.IsEMEligible,0) as "Is EMEligible",
      fe.StartLevel as "Start Level",
      fe.EndLevel as "End Level",
      nvl(fe.EMLevel,0) as "EM Level",
      fe.MgrFirstMonth as "Mgr 1st Mo",
      fe.MgrFirstMonthTotalCC as "Mgr 1st Mo Total CC",
      dm.homecompanycode
      FROM   prod2aggregation.fact_emqualification fe
      inner join prod2.dim_sponsor ds
      on ds.distributorid = fe.DistributorId
      inner join prod2.dim_member dm
      on dm.DistributorId = fe.DistributorId
      and dm.isdelete <> 'D'
      and ({% condition  opcofilter %} fe.qualifyingcountry {% endcondition %})
      Order by "EM Level" desc, "Global Total CC" desc
       ;;
  }

  measure: count {
    type: count_distinct
    sql: ${fbo_id} ;;
  }

  filter: opcofilter {
    type: string
    suggest_explore: member_details
    suggest_dimension: dim_member.opco
    case_sensitive: no
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

    dimension: name {
      type: string
      sql: ${TABLE}.name ;;
      html: <font style="white-space: nowrap;">{{ value  }}</font>;;
    }

    dimension: period {
      type: number
      sql: ${TABLE}."period";;
      value_format: "0"
    }

    dimension: qualifying_country {
      type: string
      label: "Qualifying Country"
      sql: ${TABLE}."qualifying country";;
      case_sensitive: no
    }

    dimension: home_country {
      type: string
      label: "Home Country"
      suggest_explore: member_details
      suggest_dimension: dim_member.opco
      sql: ${TABLE}.HomeCountry ;;
      case_sensitive: no
    }

    dimension: homecompanycode {
      type: string
      label: "Home Country Code"
      sql: ${TABLE}.homecompanycode ;;
      case_sensitive: no
    }

    dimension: total_cc_qc {
      type: number
      label: "Total CC QC"
      sql: ${TABLE}."total cc qc" ;;
      value_format: "#,##0.000"
      html: {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6486?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6486?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6486?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6486?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6486?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
    }

  dimension: required_em_lines_to_match_sales_level{
    label: "Required EM Lines to Match Sales Level"
    sql:  case when ${start_level} = 8 then  '3'
            else
            case when ${start_level} = 9 then  '6'
            else
             case when ${start_level} = 10 then  '10'
            else
             case when ${start_level} = 11 then  '15'
            else
             case when ${start_level} = 12 then  '25'
            else
             case when ${start_level} = 13 then  '35'
            else
            case when ${start_level} = 14 then  '45'
            else
            '0'
            end
            end
            end
            end
            end
            end
            end
            ;;
  }

  dimension: min_required_em_lines_to_qualify {
    label: "Min Required EM Lines to Qualify"
    sql:  case when ${start_level} < 7 then  '0'
            else
            case when ${start_level} = 7 then  '1'
            else
            '3'
            end
            end
            ;;
  }

    dimension: em_lines {
      type: number
      label: "EM Lines"
      sql: ${TABLE}."em lines" ;;
      html:
      {% if value != 0 %}
        <a href="https://foreverliving.looker.com/dashboards-next/6488?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
          <a href="https://foreverliving.looker.com/dashboards-next/6492?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
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
      html:
          {% if value != 0 %}
          <a href="https://foreverliving.looker.com/dashboards-next/6487?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}&Qualifying+Country={{qualifying_country._value}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
          {% else %}
          {{rendered_value}}
          {% endif %} ;;
    }

    dimension: new_sup_count {
      type: number
      label: "New Sup. Count"
      sql: ${TABLE}."new sup. count" ;;
      html:
          <a href="https://foreverliving.looker.com/dashboards-next/6493?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_eagle_managers.parameter_year']}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a> ;;
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
        hidden: yes
        sql:  ${TABLE}."em level" ;;
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

      parameter: parameter_year {
        type: number
        allowed_value: { label: "May-2020 to April-2021" value:"2021" }
        allowed_value: { label: "May-2021 to April-2022" value:"2022" }
        default_value: "2022"
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
          new_sup_count,
          is_emeligible,
          start_level,
          end_level,
          em_level,
          mgr_1st_mo,
          mgr_1st_mo_total_cc,
          eaglemanagerlevel,
          count,
          fbofilter,
          fbo_id_format1,
          fbo_id_format2,
          fbo_id_format3,
          fbo_id_format4,
          fbo_id_format5,
          fbo_id_format6,
          fbo_id_format7,
          fbo_id_format8,
          parameter_year,
          homecompanycode,
          opcofilter
        ]
      }
    }
