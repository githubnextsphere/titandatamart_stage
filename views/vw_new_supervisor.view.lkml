view: vw_new_supervisor {
  derived_table: {
    sql: with superviordetails as(
      select
        fem.distributorid as "FBO ID",
        (coalesce(mem1.memberfirstname, '')+ ' ' + coalesce(mem1.memberlastname, '')) as "FBO Name",
        fem."period",
        supervisor.supervisorid as "New Supervisor ID",
        (coalesce(mem2.memberfirstname, '')+ ' ' + coalesce(mem2.memberlastname, '')) as "New Supervisor Name",
        mem2.enrolmentdate,
        mem2.memberlevel as saleslevel,
        mem2.lastmoveupdate as moveupdate,
        supervisor.country,
        fem.mgrfirstmonth,
        {% parameter parameter_year  %} as yearfilter
      from
        stage_tbeaggregation.fact_emqualification fem
        inner join stage_tbe.dim_member mem1 on
        fem.distributorid = mem1.distributorid
        and fem.distributorid = replace(replace({{fboid_param._parameter_value}},'-',''),' ','')
        and mem1.isdelete <>'D'
        left join stage_tbeaggregation.fact_emnewsupervisors supervisor
        on fem.distributorid = supervisor.distributorid
        and fem.period = supervisor.period
        left join stage_tbe.dim_member mem2 on
        mem2.distributorid = supervisor.supervisorid
        and mem2.isdelete <>'D'
      where fem.period = {% parameter parameter_year  %}
        )
        select
        distinct supd."FBO ID",
        supd."FBO Name",
        supd."period",
        spons.distributorid as "New Supervisor ID",
        (coalesce(dm.memberfirstname, '')+ ' ' + coalesce(dm.memberlastname, '')) as "New Supervisor Name",
        dm.enrolmentdate,
        dm.memberlevel as saleslevel,
        dm.lastmoveupdate as moveupdate,
        case
          when supd."New Supervisor ID" = spons.distributorid then supd.country
          else dm.operatingcompanycode
        end as country,
        supd.mgrfirstmonth,
        supd.yearfilter
      from
        stage_tbe.dim_sponsor spons
      left join superviordetails supd on
        spons.sponsordistributorid = supd."FBO ID"
      join stage_tbe.dim_member dm on
        dm.distributorid = spons.distributorid
        and dm.isdelete <>'D'
        where  supd."period" <= 2021
        and
        case
          when supd.mgrfirstmonth between concat(yearfilter-1, '05') ::int and concat(yearfilter, '04') ::int
            then dm.enrolmentdate between concat(supd.mgrfirstmonth::int,'01')::date and concat(yearfilter, '-04-30')
          else dm.enrolmentdate between concat(yearfilter-1, '-05-01') and concat(yearfilter, '-04-30')
        end
        UNION
      select
        distinct sd."FBO ID",
        sd."FBO Name",
        sd."period",
        spon.distributorid as "New Supervisor ID",
        (coalesce(m.memberfirstname, '')+ ' ' + coalesce(m.memberlastname, '')) as "New Supervisor Name",
        m.enrolmentdate,
        m.memberlevel as saleslevel,
        m.lastmoveupdate as moveupdate,
        case
          when sd."New Supervisor ID" = spon.distributorid then sd.country
          else m.operatingcompanycode
        end as country,
        sd.mgrfirstmonth,
        sd.yearfilter
      from
        stage_tbe.dim_sponsor spon
      left join superviordetails sd on
        spon.sponsordistributorid = sd."FBO ID"
      join stage_tbe.dim_member m on
        m.distributorid = spon.distributorid
        and m.enrolmentdate between concat(yearfilter-1, '-05-01') and concat(yearfilter, '-04-30')
        and m.isdelete <>'D'
        and m.memberstatus <>'Terminated'
        and period >= 2022
        UNION
        SELECT
        "FBO ID",
        "FBO Name",
        "period",
        "New Supervisor ID",
        "New Supervisor Name",
        enrolmentdate,
        saleslevel,
        moveupdate,
        country,
        mgrfirstmonth,
        {% parameter parameter_year  %}  as yearfilter
        FROM superviordetails
        where "New Supervisor ID" is not null
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: parameter_year {
    type: number
    allowed_value: { value: "2021" label: "May-2020 to April-2021"}
    allowed_value: { value: "2022" label: "May-2021 to April-2022"}
    default_value: "2022"
  }

  parameter: fboid_param {
    type: string
  }

  dimension: fbo_id {
    type: string
    label: "FBO ID"
    sql: SUBSTRING(${TABLE}."fbo id" , 1,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."fbo id" , 7,3) + '-' + SUBSTRING(${TABLE}."fbo id" , 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: fbo_name {
    type: string
    label: "FBO Name"
    sql: ${TABLE}."fbo name" ;;
  }

  dimension: period {
    type: number
    sql: ${TABLE}.period ;;
    value_format: "0"
  }

  dimension: new_supervisor_id {
    type: string
    label: "New Supervisor ID"
    sql: SUBSTRING(${TABLE}."new supervisor id" , 1,3) + '-' + SUBSTRING(${TABLE}."new supervisor id" , 4,3)
      + '-' + SUBSTRING(${TABLE}."new supervisor id" , 7,3) + '-' + SUBSTRING(${TABLE}."new supervisor id" , 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: new_supervisor_name {
    type: string
    label: "New Supervisor Name"
    sql: ${TABLE}."new supervisor name" ;;
  }

  dimension: enrolmentdate {
    label: "Enrolled Date"
    type: date
    sql: ${TABLE}.enrolmentdate ;;
    convert_tz: no
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension: saleslevel {
    label: "Sales Level"
    type: string
    sql: ${TABLE}.saleslevel ;;
  }

  dimension: moveupdate {
    label: "Move-Up Date"
    type: date
    sql: ${TABLE}.moveupdate ;;
    convert_tz: no
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: mgrfirstmonth {
    type: number
    hidden: yes
    sql: ${TABLE}.mgrfirstmonth ;;
  }

  dimension: yearfilter {
    type: number
    hidden: yes
    sql: ${TABLE}.yearfilter ;;
  }

  set: detail {
    fields: [
      fbo_id,
      fbo_name,
      period,
      new_supervisor_id,
      new_supervisor_name,
      enrolmentdate,
      saleslevel,
      moveupdate,
      country,
      mgrfirstmonth,
      yearfilter,
      parameter_year,
      fboid_param
    ]
  }
}
