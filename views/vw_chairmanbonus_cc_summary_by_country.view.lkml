view: vw_chairmanbonus_cc_summary_by_country {
  derived_table: {
    sql: with cc_summary_by_country as(
            select
              monthlycc.distributorid as "fbo_id",
              operatingcompanycode as "opco",
              case
                  when operatingcompanycode = cbqualification.qualifyingcountry
                  then concat(country.countryname,'  ('+cbqualification.qualifyingcountry+')')
                  else country.countryname end as "country_name",
              sum(
                  case
                  when cbqualification.mgrfirstmonth <= cast(concat(extract(year from monthlycc.processingdate), (TO_CHAR(monthlycc.processingdate, 'MM')))as numeric)
                  then monthlycc.newccmonthtodate
                  else 0 end)as "new_non_manager_cc",
                case when operatingcompanycode=cbqualification.qualifyingcountry
                    then cbqualification.newcc_oqc end as "new_non_manager_cc_outside_the_qualifying_country",
                  case
                  when operatingcompanycode=cbqualification.qualifyingcountry
                  then MAX(cbqualification.opengroupccglobalcap)
                  else
                  SUM(case
                    when cbqualification.mgrfirstmonth < cast(concat(extract(year from monthlycc.processingdate),
                     (TO_CHAR(monthlycc.processingdate, 'MM')))as numeric)
                    then (monthlycc.personalccmtd + monthlycc.nonmanagerccmtd)
                    when cbqualification.mgrfirstmonth = cast(concat(extract(year
                    from monthlycc.processingdate),
                       (TO_CHAR(monthlycc.processingdate, 'MM')))as numeric)
                    then cbqualification.opengroupcc_qc
                    else 0
                    end)
                  end
                   as "open_group_cc",
              cbqualification.qualifyingcountry as "qualifying_country",
              {% parameter parameter_year  %}  AS yearfilter
              from prod2.dim_monthlycc monthlycc
              join prod2aggregation_tbe.fact_cbqualification cbqualification
              on monthlycc.distributorid=cbqualification.distributorid
              and isnull(cbqualification.isdelete,'') != 'D'
              and isnull(monthlycc.isdelete,'') != 'D'
              join prod2.dim_country country
              on monthlycc.operatingcompanycode=country.isocodethree
              where
              monthlycc.distributorid = Replace(Replace({{fboid_param._parameter_value}},'-',''),' ','')
              and processingdate between concat(yearfilter,'-01-01') and concat(yearfilter,'-12-31')
              and cbqualification.period = yearfilter
              group by
              monthlycc.distributorid,
              monthlycc.operatingcompanycode,
              cbqualification.qualifyingcountry ,
              cbqualification."period",
              country.countryname,
              yearfilter,
              cbqualification.newcc_oqc,
              country.displayname
              order by
              monthlycc.operatingcompanycode
      ),
      qualyfingCountry as (
          select
          country_name,
          opco,
          new_non_manager_cc ::varchar,
          new_non_manager_cc_outside_the_qualifying_country ::varchar,
          open_group_cc ::varchar,
          case when qualifying_country in('DEU','CHE','GBR','IRL')
                  then 'true'
                  else 'false'
          end as showCountryMessage,
          -1 as rn
          from
          cc_summary_by_country
          where
          opco = qualifying_country
      ),
     message as (
          select
              case when qualifying_country = 'DEU' then 'For your global Total CC, you need to combine the CC from Switzwerland.'
                   when qualifying_country = 'CHE' then 'For your global Total CC, you need to combine the CC from Germany.'
                   when qualifying_country = 'GBR' then 'For your global Total CC, you need to combine the CC from Ireland.'
                   when qualifying_country = 'IRL' then 'For your global Total CC, you need to combine the CC from United Kingdom.'
                   else '' end as "country_name",
              NULL as "opco",
              NULL as "new_non_manager_cc",
              NULL as "new_non_manager_cc_outside_the_qualifying_country",
              NULL as "open_group_cc",
              case when qualifying_country in('DEU','CHE','GBR','IRL')
                  then 'true'
                  else 'false'
              end as showCountryMessage,
              0 as rn
              from
              cc_summary_by_country
      ),
      otherCountries as(
          select
          country_name,
          opco,
          new_non_manager_cc ::varchar,
          new_non_manager_cc_outside_the_qualifying_country ::varchar,
          open_group_cc ::varchar,
          case when qualifying_country in('DEU','CHE','GBR','IRL')
                  then 'true'
                  else 'false'
          end as showCountryMessage,
          row_number() over (order by country_name asc) as "rn"
          from
          cc_summary_by_country
          where
          (opco != qualifying_country) and (new_non_manager_cc!=0 or open_group_cc!=0)
      ),
      finalResult as(
          select * from qualyfingCountry
          union
          select * from message
          where showCountryMessage= 'true'
          union
          select * from otherCountries
          order by rn
      )
      select
          country_name as "Country",
          opco as "opco",
          NVL(new_non_manager_cc,'') as "New Non-Manager CC",
          NVL(new_non_manager_cc_outside_the_qualifying_country,'') as "New Non-Manager CC Outside the qualifying Country",
          NVL(open_group_cc,'') as "Open Group CC",
          rn as "row num"
          from finalResult
 ;;
  }

  parameter: parameter_year {
    label: "Period"
    type: number
    allowed_value: { value: "2021"}
    allowed_value: { value: "2020"}
    allowed_value: { value: "2022"}
    default_value: "2022"
  }

  parameter: fboid_param {
    label: "FBO ID"
    type: string
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fbo_id {
    type: string
    sql: {% parameter fboid_param %} ;;
  }

  dimension: country {
    label: "Country"
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: opco {
    type: string
    sql: ${TABLE}.opco ;;
  }

  dimension: new_nonmanager_cc {
    type: string
    label: "New Non-Manager CC"
    sql: ${TABLE}."new non-manager cc" ;;
    html: <p style="text-align:center;">
      {% if value != '0.000' %}
      <a href="https://foreverliving.looker.com/dashboards-next/6903?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairmanbonus_cc_summary_by_country.parameter_year']}}&OpCO={{opco._value}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
      {% else %}
      {{rendered_value}}
      {% endif %}
      </p>;;
  }

  dimension: new_non_manager_cc_outside_the_qualifying_country {
    type: string
    label: "New Non-Manager CC outside the qualifying country"
    sql: ${TABLE}."new non-manager cc outside the qualifying country" ;;
  }

  dimension: open_group_cc {
    type: string
    label: "Open Group CC (Personal + Non-Manager CC, including New CC)"
    sql: ${TABLE}."open group cc" ;;
    html: <p style="text-align:center;">
      {% if value != '0.000' %}
      <a href="https://foreverliving.looker.com/dashboards-next/6903?FBO+ID={{fbo_id._value}}&Period={{_filters['vw_chairmanbonus_cc_summary_by_country.parameter_year']}}&OpCO={{opco._value}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
      {% else %}
      {{rendered_value}}
      {% endif %}
      </p>;;
  }

  dimension: row_num {
    type: number
    label: "row num"
    sql: ${TABLE}."row num" ;;
  }

  set: detail {
    fields: [
      country,
      opco,
      new_nonmanager_cc,
      new_non_manager_cc_outside_the_qualifying_country,
      open_group_cc,
      row_num
    ]
  }
}
