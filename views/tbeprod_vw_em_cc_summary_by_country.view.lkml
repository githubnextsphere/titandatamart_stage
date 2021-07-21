view: tbeprod_vw_em_cc_summary_by_country {
  derived_table: {
    sql:   with cc_summary_by_country as(
            select
              monthlycc.distributorid as "fbo_id",
              operatingcompanycode as "opco",
              case
                  when operatingcompanycode = emqualification.qualifyingcountry
                  then concat(country.countryname,'  ('+emqualification.qualifyingcountry+')')
                  else country.countryname end as "country_name",
              sum(case when emqualification.mgrfirstmonth <= cast(concat(extract(year from monthlycc.processingdate), (TO_CHAR(monthlycc.processingdate, 'MM')))as numeric)
                  then monthlycc.newccmonthtodate
                   else 0 end)as "new_non_manager_cc",
              case when operatingcompanycode=emqualification.qualifyingcountry then
                   case when emqualification.newcc_oqc>100 then 100
                   else emqualification.newcc_oqc end
              end as "new_non_manager_cc_outside_the_qualifying_country",
              sum(
                  case when emqualification.mgrfirstmonth < cast(concat(extract(year from monthlycc.processingdate), (TO_CHAR(monthlycc.processingdate, 'MM')))as numeric)
                      then monthlycc.totalccmtd
                      when emqualification.mgrfirstmonth = cast(concat(extract(year from monthlycc.processingdate), (TO_CHAR(monthlycc.processingdate, 'MM')))as numeric)
                      then emqualification.mgrfirstmonthtotalcc
                      else 0
                  end) as "total_cc",
                  case when {% parameter parameter_year  %} = 'Current Period'
                then EXTRACT(YEAR FROM CURRENT_DATE)
                when {% parameter parameter_year  %} = 'Last Period'
                then EXTRACT(YEAR FROM CURRENT_DATE) -1
                end AS yearfilter,
              emqualification.qualifyingcountry as "qualifying_country"
              from prod2.dim_monthlycc monthlycc
              join prod2aggregation.fact_emqualification emqualification
              on monthlycc.distributorid=emqualification.distributorid
              join prod2.dim_country country
              on monthlycc.operatingcompanycode=country.isocodethree
               where
               monthlycc.distributorid = Replace(Replace({{fboid_param._parameter_value}},'-',''),' ','')
              and processingdate between concat(yearfilter-1,'-05-01') and concat(yearfilter,'-04-30')
              and isdelete!='D'
              and emqualification.period = yearfilter
              group by
              monthlycc.distributorid,
              monthlycc.operatingcompanycode,
              emqualification.qualifyingcountry ,
              emqualification."period",
              country.countryname,
              emqualification.newcc_oqc,
              yearfilter,
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
          total_cc ::varchar,
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
              NULL as "total_cc",
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
          total_cc ::varchar,
          case when qualifying_country in('DEU','CHE','GBR','IRL')
                  then 'true'
                  else 'false'
          end as showCountryMessage,
          row_number() over (order by country_name asc) as "rn"
          from
          cc_summary_by_country
          where
          (opco != qualifying_country) and (new_non_manager_cc!=0 or total_cc!=0)
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
          NVL(new_non_manager_cc_outside_the_qualifying_country,'') as "New Non-Manager CC Outside the qualifying Country (Max 100 CC Allowed)",
          NVL(total_cc,'') as "Total CC (Including New CC)",
          rn as "row num"
          from finalResult
       ;;
  }

  parameter: parameter_year {
    label: "Period"
    type: string
    allowed_value: { value: "Current Period" label:"May-2020 to April-2021"}
    default_value: "Current Period"
  }

  parameter: fboid_param {
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
    label: "opco"
    type: string
    sql: ${TABLE}."opco" ;;
  }

  dimension: period {
    type: string
    sql:  {% parameter parameter_year %} ;;
  }

  dimension: new_nonmanager_cc {
    type: string
    label: "New Non-Manager CC"
    sql: ${TABLE}."new non-manager cc";;
    description: "Non-Manager CC accumulated during the incentive period for the specific country."
    html:
    <p style="text-align:center;">
      {% if value != '0.000' %}
      <a href="https://foreverliving.looker.com/dashboards-next/6237?Period={{period._value}}&FBO+ID={{fbo_id._value}}&OpCO={{opco._value}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
      {% else %}
      {{rendered_value}}
         {% endif %}
        </p>   ;;
  }

  dimension: new_nonmanager_cc_outside_the_qualifying_country_max_100_cc_allowed {
    type: string
    label: "New Non-Manager CC outside the qualifying country (Max 100 CC Allowed)"
    sql: ${TABLE}."new non-manager cc outside the qualifying country (max 100 cc allowed)" ;;
    description: "Sum of Non-Manager CC accumulated during the incentive period for all countries outside the qualifying country."
    html: <p style="text-align:center;">{{ rendered_value }}</p>  ;;
  }

  dimension: total_cc_including_new_cc {
    type: string
    label: "Total CC (Including New CC)"
    sql:${TABLE}."total cc (including new cc)";;
    description: "Total CC accumulated during the incentive period included up to 100 New CC from countries outside the qualifying country"
    html:   <p style="text-align:center;">
      {% if value != '0.000' %}
      <a href="https://foreverliving.looker.com/dashboards-next/6237?Period={{period._value}}&FBO+ID={{fbo_id._value}}&OpCO={{opco._value}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ rendered_value  }} </u> </font></a>
      {% else %}
      {{rendered_value}}
         {% endif %}
        </p>   ;;
  }

  dimension: row_num {
    type: number
    label: "row num"
    sql: ${TABLE}."row num" ;;
  }

  set: detail {
    fields: [
      country,
      new_nonmanager_cc,
      new_nonmanager_cc_outside_the_qualifying_country_max_100_cc_allowed,
      total_cc_including_new_cc,
      row_num]
  }
}
