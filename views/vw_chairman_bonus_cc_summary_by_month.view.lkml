view: vw_chairman_bonus_cc_summary_by_month {
  derived_table: {
    sql: with cc_summary_by_month as
      (
      select distinct
                concat(trim(to_char(mon.processingdate, 'Month')) + ' ',extract(year from mon.processingdate)) as "cc_month",
                to_char(mon.processingdate, 'mm') as "ccmonth",
                extract(year from mon.processingdate) as "ccyear",
                case
                    when cb.mgrfirstmonth <= cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
                    then mon.newccmonthtodate
                    else 0
                end as "newccmonthtodate",
                case
                    when cb.mgrfirstmonth < cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
                    then (mon.personalccmtd + mon.nonmanagerccmtd)
                    when cb.mgrfirstmonth = cast(concat(extract(year from mon.processingdate), (TO_CHAR(mon.processingdate, 'MM')))as numeric)
                    then cb.mgrfirstmonthopengroupcc
                    else 0
                end as "totalcc",
                case when {% parameter parameter_year  %} = 'Current Year'
                then EXTRACT(YEAR FROM CURRENT_DATE)
                when {% parameter parameter_year  %} = 'Last Year'
                then EXTRACT(YEAR FROM CURRENT_DATE) -1
                end AS yearfilter
                from prod2.dim_monthlycc mon
                join prod2aggregation.fact_cbqualification cb
                on mon.distributorid = cb.distributorid
                where
                cb.distributorid = Replace(Replace({{parameter_fboid._parameter_value}},'-',''),' ','')
                and processingdate between concat(yearfilter,'-01-01') and concat(yearfilter,'-12-31')
                and mon.operatingcompanycode = {% parameter parameter_OpCO %}
            )
            ,
            monthcte as
            (
                select ccmonth, ccyear, cc_month,newccmonthtodate,totalcc from cc_summary_by_month
                UNION
                select '01',yearfilter,'January '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                select '02',yearfilter,'February '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '03',yearfilter,'March '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '04',yearfilter,'April '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '05',yearfilter, 'May '+concat(yearfilter,'')  as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '06',yearfilter, 'June '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '07',yearfilter, 'July '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '08',yearfilter, 'August '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '09',yearfilter, 'September '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '10',yearfilter,'October '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '11',yearfilter,'November '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '12',yearfilter,'December '+concat(yearfilter,'') as "cc_month",0 as "newccmonthtodate",0 as "totalcc" from cc_summary_by_month
                union
                 select '13',yearfilter,'Total' as "cc_month",SUM(newccmonthtodate) as "newccmonthtodate",SUM(totalcc) as "totalcc" from cc_summary_by_month group by 1,2,3
            ),
            monthdata as (
            select ROW_NUMBER() OVER (PARTITION BY cc_month Order BY totalcc desc,newccmonthtodate desc) as rownum, * from monthcte
            order by  ccyear,ccmonth
            )
            select cc_month as "Month",newccmonthtodate as "New Non-Manager CC", totalcc as "Total CC",
            ROW_NUMBER() OVER (ORDER BY ccyear,ccmonth) as sortorder
            from monthdata
            where rownum = 1
             ;;
  }

  parameter: parameter_year {
    label: "Period"
    type: string
    allowed_value: { value: "Current Year"}
    allowed_value: { value: "Last Year"}
    default_value: "Current Year"
  }

  parameter: parameter_fboid {
    type: string
    label: "FBO ID"
  }

  parameter: parameter_OpCO {
    type: string
    label: "OpCO"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
    html: {% if sortorder._value == 13 and value contains 'Total'%}
          <div style = "font-weight: bold; text-align: right;">
          {{rendered_value}}
          </div>
          {% else %}
          {{rendered_value}}
          {% endif %}  ;;
  }

  dimension: new_nonmanager_cc {
    type: number
    label: "New Non-Manager CC"
    description: "New Non-Manager CC for the month"
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
    label: "Total CC"
    description: "Total CC for the month"
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
    fields: [month, new_nonmanager_cc, total_cc, sortorder]
  }
}
