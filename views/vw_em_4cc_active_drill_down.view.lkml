view:vw_em_4cc_active_drill_down {
derived_table: {
  sql: with cc_by_month as(
      select
        distinct concat(trim(to_char(dm.processingdate, 'Month')) + ' ',extract(year from dm.processingdate)) as "cc_month",
        dm.currentmonthactive,
        EXTRACT(Month FROM dm.processingdate) as monthsort,
        EXTRACT(Year FROM dm.processingdate) as  yearsort,
       {% parameter parameter_year  %}  AS yearfilter
        from prod2.dim_monthlycc dm
         where
      dm.distributorid = Replace(Replace({% parameter parameter_fboid %},'-',''),' ','')
      and dm.processingdate between concat(yearfilter-1,'-05-01') and concat
      (yearfilter,'-04-30')
      and dm.operatingcompanycode = {% parameter parameter_qualifyingcountry %}
      ),
      monthcte as(
          select cc_month,currentmonthactive,monthsort,yearsort from cc_by_month
          union
           select 'May '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,5 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'June '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,6 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'July '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,7 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'August '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,8 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'September '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,9 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'October '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,10 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'November '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,11 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'December '+concat(yearfilter-1,'') as cc_month,'false' as currentmonthactive,12 as monthsort,yearfilter-1 as yearsort from cc_by_month
          union
           select 'January '+concat(yearfilter,'') as cc_month,'false' as currentmonthactive,1 as monthsort,yearfilter as yearsort from cc_by_month
          union
          select 'February '+concat(yearfilter,'') as cc_month,'false' as currentmonthactive,2 as monthsort,yearfilter as yearsort from cc_by_month
          union
           select 'March '+concat(yearfilter,'') as cc_month,'false' as currentmonthactive,3 as monthsort,yearfilter as yearsort from cc_by_month
          union
           select 'April '+concat(yearfilter,'') as cc_month,'false' as currentmonthactive,4 as monthsort ,yearfilter as yearsort from cc_by_month
      ),
      monthdata as (
          select ROW_NUMBER() OVER(PARTITION BY cc_month order by yearsort,monthsort,currentmonthactive desc) as rownum, * from monthcte
      )
      select cc_month as "Month",
           currentmonthactive as "Current Month Active",
           ROW_NUMBER() OVER (ORDER BY yearsort,monthsort,currentmonthactive desc) as sortorder
          from monthdata
      where rownum = 1
 ;;
}

measure: count {
  type: count
  drill_fields: [detail*]
}

dimension: month {
  type: string
  label: "Month"
  sql: ${TABLE}.month ;;
}

dimension: current_month_active {
  type: string
  label: "4CC Active"
  sql: case when ${TABLE}."current month active" = 'true' then 'Yes'
          else 'No'
         end ;;
}

dimension: sortorder {
  type: number
  sql: ${TABLE}.sortorder ;;
}

parameter: parameter_fboid {
  type: string
  label: "FBO ID"
}

parameter: parameter_qualifyingcountry {
  type: string
  label: "Qualifying Country"
}

parameter: parameter_year {
  type: number
  label: "Period"
  allowed_value: { value: "2021" label:"May-2020 to April-2021"}
  allowed_value: { value: "2022" label:"May-2021 to April-2022"}
  default_value: "2022"
}

set: detail {
  fields: [month, current_month_active, sortorder]
}
}
