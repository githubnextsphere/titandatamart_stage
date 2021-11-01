view: vw_cc_summary_by_month {
  derived_table: {
    sql:with cc_summary_by_month as
      (
          select distinct
          concat(trim(to_char(mon.processingdate, 'Month')) + ' ',extract(year from mon.processingdate)) as "cc_month",
          to_char(mon.processingdate, 'mm') as "ccmonth",
          extract(year from mon.processingdate) as "ccyear",
          case
              when em.mgrfirstmonth < cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
              then mon.newccmonthtodate
              when em.mgrfirstmonth <= cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
              then mon.newccmonthtodate
              else 0
          end as "newccmonthtodate",
          case
              when em.mgrfirstmonth < cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
              then mon.totalccmtd
              when em.mgrfirstmonth = cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
              then em.mgrfirstmonthtotalcc
              else 0
          end as "totalccmtd",
          case when {% parameter parameter_year  %} = 'Current Period'
          then EXTRACT(YEAR FROM CURRENT_DATE)
          when {% parameter parameter_year  %} = 'Last Period'
          then EXTRACT(YEAR FROM CURRENT_DATE) -1
          end AS yearfilter
          from prod2.dim_monthlycc mon
          join prod2aggregation_tbe.fact_emqualification em
          on mon.distributorid = em.distributorid
          where
          em.distributorid = Replace(Replace({% parameter parameter_fboid %},'-',''),' ','')
          and processingdate between concat(yearfilter-1,'-05-01') and concat(yearfilter,'-04-30')
          and mon.operatingcompanycode = {% parameter parameter_OpCO %}
      )
      ,
      monthcte as
      (
          select ccmonth, ccyear, cc_month,newccmonthtodate,totalccmtd from cc_summary_by_month
          union
           select '05',yearfilter -1, 'May '+concat(yearfilter-1,'')  as "cc_month",0 as "newccmonthtodate",0 as "totalccmt" from cc_summary_by_month
          union
           select '06',yearfilter-1, 'June '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '07',yearfilter-1, 'July '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '08',yearfilter-1, 'August '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '09',yearfilter-1, 'September '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '10',yearfilter-1,'October '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '11',yearfilter-1,'November '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '12',yearfilter-1,'December '+concat(yearfilter-1,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '01',yearfilter,'January '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
          select '02',yearfilter,'February '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '03',yearfilter,'March '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '04',yearfilter,'April '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalccmtd" from cc_summary_by_month
          union
           select '05',yearfilter,'Total' as "cc_month",SUM(newccmonthtodate) as "newccmonthtodate",SUM(totalccmtd) as "totalccmtd" from cc_summary_by_month group by 1,2,3
      ),
      monthdata as (
      select ROW_NUMBER() OVER (PARTITION BY cc_month Order BY totalccmtd desc,newccmonthtodate desc) as rownum, * from monthcte
      order by  ccyear,ccmonth
      )
      select cc_month as "Month",newccmonthtodate as "New Non-Manager CC", totalccmtd as "Total CC",
      ROW_NUMBER() OVER (ORDER BY ccyear,ccmonth) as sortorder
      from monthdata
      where rownum = 1
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: parameter_year {
    type: string
    label: "Period"
    allowed_value: { value: "Current Period" label:"May-2020 to April-2021"}
    default_value: "Current Period"
  }

  parameter: parameter_fboid {
    type: string
    label: "FBO ID"
    suggest_explore:fact_emmgrsindownline
    suggest_dimension: fact_emmgrsindownline.mgr_id
  }

  parameter: parameter_OpCO {
    type: string
    suggest_explore:fact_emqualification
    suggest_dimension: fact_emqualification.homecountry
    label: "OpCO"
  }

  measure: new_nm_cc_msr {
    type: number
    label: "New Non-Manager CC"
    sql:  ${new_nonmanager_cc} ;;
  }

  measure: total_cc_msr {
    type: number
    label: "Total CC"
    sql: ${total_cc} ;;
  }

  dimension: month {
    type: string
    label: "Month"
    sql: ${TABLE}.month ;;
    html:
    {% if sortorder._value == 13 and value contains 'Total' %}
    <div style = "font-weight: bold;text-align: right;">
    {{rendered_value}}
    </div>
    {% else %}
    {{rendered_value}}
    {% endif %}  ;;
  }

  dimension: new_nonmanager_cc {
    type: number
    description: "New Non-Manager CC for the month"
    label: "New Non-Manager CC"
    sql: ${TABLE}."new non-manager cc" ;;
    value_format: "#,##0.000"
    html: {% if sortorder._value == 13 %}
          <div style = "font-weight: bold;">
          {{rendered_value}}
          </div>
          {% else %}
          {{rendered_value}}
          {% endif %}  ;;
  }

  dimension: total_cc {
    type: number
    description: "Total CC for the month"
    label: "Total CC"
    sql: ${TABLE}."total cc" ;;
    value_format: "#,##0.000"
    html: {% if sortorder._value == 13 %}
          <div style = "font-weight: bold;">
          {{rendered_value}}
          </div>
          {% else %}
          {{rendered_value}}
          {% endif %}  ;;
  }

  dimension: sortorder {
    type: number
    sql: ${TABLE}.sortorder ;;
  }

  set: detail {
    fields: [month, new_nonmanager_cc, total_cc]
  }
}
