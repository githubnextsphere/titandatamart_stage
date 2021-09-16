connection: "titanbonusenginestage"

# include all the views
include: "/views/**/*.view"

datagroup: titandatamart_tbe_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: titandatamart_tbe_default_datagroup

explore: downlinememberdetails {}

explore: fact_cb600ccindownline {}

explore: fact_cb600cclines {}

explore: fact_cbindownline {}

explore: fact_cblines {}

explore: fact_cbmgrsindownline {}

explore: fact_cbqualification {}

explore: fact_distributordownlinecount_aggregation {}

explore: fact_distributordownlinecount_aggregation_global {}

explore: fact_downlinetreebydistributors {}

explore: fact_emindownline {}

explore: fact_emlines {}

explore: fact_emmgrsindownline {}

explore: fact_emnewsupervisors {}

explore: fact_emqualification {}

explore: fact_emyearlycc {}

explore: fact_globalrallyrewards {}

explore: fact_grqualification {}

explore: fact_levelhistory {}

explore: fact_memberstats_aggregation {}

explore: fact_memberstats_aggregation_global {}

explore: fact_moveupsbygenerationandlevel {}

explore: fact_treehistory {}

explore: generationdetails {}

explore: generationdetails_global {}

explore: stage_factdownlinecount_roguedata {}

explore: stage_memberstats_roguedata {}

explore: eagle_managers {
  view_name: vw_eagle_managers
  label: "Eagle Manager's"
  join: fact_emmgrsindownline {
    type: inner
    relationship: one_to_one
    sql_on: ${vw_eagle_managers.fbo_id_format1} = ${fact_emmgrsindownline.mgr_id}  ;;
  }
  fields: [vw_eagle_managers.detail*,fact_emmgrsindownline.detail*,vw_eagle_managers.min_required_em_lines_to_qualify,
    vw_eagle_managers.required_em_lines_to_match_sales_level,vw_eagle_managers.parameter_year]

  sql_always_where: ${vw_eagle_managers.period}=  {{ vw_eagle_managers.parameter_year._parameter_value }};;

  access_filter: {
    field: vw_eagle_managers.opcofilter
    user_attribute: operatingcountry
  }
}

explore: new_chairmans_bonus {
  view_name: chairmans_bonus
  label: "New Chairman's Bonus"
  access_filter: {
    field: chairmans_bonus.operating_company
    user_attribute: operatingcountry
  }
}

explore: global_rally_status_report {
  view_name: vw_global_rally_status_report
  access_filter: {
    field: vw_global_rally_status_report.homecountry
    user_attribute: operatingcountry
  }
}

explore: tbeprod_new_chairmans_bonus {
  view_name: tbeprod_chairmans_bonus
  label: "New Chairman's Bonus TBE Prod"
  access_filter: {
    field: tbeprod_chairmans_bonus.operating_company
    user_attribute: operatingcountry
  }
}

explore: tbeprod_vw_eagle_managers {
  view_name: tbeprod_vw_eagle_managers
  label: "Eagle Manager's TBE Prod"
  join: tbeprod_fact_emmgrsindownline {
    type: inner
    relationship: one_to_one
    sql_on: ${tbeprod_vw_eagle_managers.fbo_id_format1} = ${tbeprod_fact_emmgrsindownline.mgr_id}  ;;
  }
  fields: [tbeprod_vw_eagle_managers.detail*,tbeprod_fact_emmgrsindownline.detail*,tbeprod_vw_eagle_managers.min_required_em_lines_to_qualify,
    tbeprod_vw_eagle_managers.required_em_lines_to_match_sales_level,tbeprod_vw_eagle_managers.parameter_year]

  sql_always_where: ${tbeprod_vw_eagle_managers.period}=  {{ tbeprod_vw_eagle_managers.parameter_year._parameter_value }};;

  access_filter: {
    field: tbeprod_vw_eagle_managers.opcofilter
    user_attribute: operatingcountry
  }
}

explore: cb_cc_summary_by_country {
  view_name: vw_chairmanbonus_cc_summary_by_country
  label: "Chairman Bonus CC Summary By Country"
}

explore: em_cc_summary_by_country {
  view_name: vw_em_cc_summary_by_country
  label: "Eagle Manager CC Summary By Country"
}

explore: em_4cc_active_drill_down {
  label: "Eagle Manager 4CC Active"
  view_name: vw_em_4cc_active_drill_down
}

explore: eagle_manager_lines {
  view_label: "Eagle Manager Lines"
  view_name: vw_eagle_manager_lines
}

explore: chairman_bonus_600cc_manager_lines {
  label: "Chairman Bonus 600 Manager Lines"
  view_name: vw_cb_600cc_manager_lines
}

explore: chairman_bonus_qualifiers {
  label: "Chairman Bonus Qualifiers"
  view_name: vw_chairman_bonus_qualifiers
}

explore: chairman_bonus_manager_lines {
  label: "Chairman Bonus Manager Lines"
  view_name: vw_chairman_bonus_manager_lines
}

explore: downline_eagle_managers {
  view_name:vw_downline_eagle_manager
  label: "Downline Eagle Manager's"
}

explore: new_supervisor {
  view_name: vw_new_supervisor
  label: "New Supervisor"
  join: dim_levels {
    type: inner
    sql_on: ${vw_new_supervisor.saleslevel} = ${dim_levels.value}
      and ${dim_levels.key} !=0;;
    relationship: one_to_one
  }
  fields: [dim_levels.key,vw_new_supervisor.detail*]
}

explore: forever2drive_status {
  view_name: vw_forever2drive_status
  label: "Forever2Drive Status"
  sql_always_where:
    {% assign arr_value = _user_attributes['operatingcountry'] | split: "," %}
    {% assign mem_opco =  _user_attributes['operatingcountry'] | downcase %}
    {% assign qua_opco =  vw_forever2drive_status.qualifying_opco_param._parameter_value | remove: "'" | downcase %}
    {% if vw_forever2drive_status.member_opco_param._parameter_value == "''"
    and vw_forever2drive_status.qualifying_opco_param._parameter_value == "''" %}
      {% if _user_attributes['operatingcountry'] == '%,NULL' %}
        ${vw_forever2drive_status.member_opco}=${vw_forever2drive_status.member_opco}
        or ${vw_forever2drive_status.qualifying_opco} = ${vw_forever2drive_status.qualifying_opco}
      {% else %}
        lower('{{_user_attributes['operatingcountry']}}') like lower('%' || ${vw_forever2drive_status.member_opco} || '%')
        or lower('{{_user_attributes['operatingcountry']}}') like lower('%' || ${vw_forever2drive_status.qualifying_opco} || '%')
      {% endif %}
    {% else %}
    {% if vw_forever2drive_status.member_opco_param._parameter_value == "''"
    and vw_forever2drive_status.qualifying_opco_param._parameter_value != '' %}
      {% if _user_attributes['operatingcountry'] == '%,NULL' %}
        ${vw_forever2drive_status.member_opco}=${vw_forever2drive_status.member_opco}
        and
        ${vw_forever2drive_status.qualifying_opco}={{vw_forever2drive_status.qualifying_opco_param._parameter_value}}
      {% else %}
        {% if mem_opco contains qua_opco %}
          ${vw_forever2drive_status.qualifying_opco} = {{vw_forever2drive_status.qualifying_opco_param._parameter_value}}
          {% else %}
          ${vw_forever2drive_status.qualifying_opco} = {{vw_forever2drive_status.qualifying_opco_param._parameter_value}}
          and
          ${vw_forever2drive_status.member_opco} IN
            {% for opco in arr_value %}
              {% if forloop.first == true %}
              ('{{opco | strip}}' ,
              {% elsif forloop.last == true %}
                  '{{opco | strip}}')
              {% else %}
                  '{{opco | strip}}',
              {% endif %}
            {% endfor %}
        {% endif %}
      {% endif %}
    {% else %}
    {% if vw_forever2drive_status.member_opco_param._parameter_value != ''
    and vw_forever2drive_status.qualifying_opco_param._parameter_value == "''" %}
    ${vw_forever2drive_status.member_opco} = {{vw_forever2drive_status.member_opco_param._parameter_value}}
    {% else %}
    {% if vw_forever2drive_status.member_opco_param._parameter_value != ''
    and vw_forever2drive_status.qualifying_opco_param._parameter_value != '' %}
      ${vw_forever2drive_status.member_opco} = {{vw_forever2drive_status.member_opco_param._parameter_value}}
      and ${vw_forever2drive_status.qualifying_opco} = {{vw_forever2drive_status.qualifying_opco_param._parameter_value}}
    {% endif %}
    {% endif %}
    {% endif %}
    {% endif %}
  ;;
}

explore: forever2drive_suggestion {
  view_name: dim_monthlycc
  sql_always_where: ${dim_monthlycc.processingdate_date} >= dateadd('month',-12,current_date)  ;;
}

explore: forever2drive_qualificationstartperiod_suggestion {
  view_name: dim_monthlycc
  sql_always_where: ${dim_monthlycc.earned_incentive_qualification_date} >= dateadd('month',-35,current_date)  ;;
}

explore: forever2drive_qualificationendperiod_suggestion {
  view_name: dim_monthlycc
  sql_always_where: ${dim_monthlycc.earned_incentive_expiration_date} > CURRENT_DATE and
    ${dim_monthlycc.earned_incentive_expiration_date} <= dateadd('month',+35,current_date)   ;;
}
