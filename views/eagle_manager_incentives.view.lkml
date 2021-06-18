view: eagle_manager_incentives {
  derived_table: {
    sql:
    With cte as
      (
        SELECT cc.distributorid as distributorid,
          cc.operatingcompanycode as monthlyopco,
          cc.eaglemanagerlevel as eaglemanagerlevel,
          cc.eaglemanagertotalcc as eaglemanagertotalcc,
          cc.homecountryeaglemanagercc as homecountrynewcc ,
          cc.nonhomecountryeaglemanagercc as nonhomecountrynewcc,
          cc.homecountryeaglemanagercc+cc.nonhomecountryeaglemanagercc as totalglobalnewcc,
          cc.numberofeaglemanagersrequired as numberofeaglemanagersrequired,
          cc.numberofnewsupervisors as numberofnewsupervisors,
          cc.numberofeaglemanagers as eaglemanagers,
          Replace(Quote_literal(Replace(Trim(cc.downlineeaglemanagerqualifiers),'|', ',')),',',Quote_literal(',')) AS downlineeaglemanagers,
          (LENGTH(Replace(Trim(cc.downlineeaglemanagerqualifiers),'|', '')))/12 AS numberofdownlineeaglemanagers,
          ROW_NUMBER() over(PARTITION BY distributorid,cc.operatingcompanycode ORDER BY cc.eaglemanagertotalcc DESC,
          cc.homecountryeaglemanagercc DESC, cc.homecountryeaglemanagercc DESC, cc.nonhomecountryeaglemanagercc DESC) as rown
        FROM prod2.dim_monthlycc cc
        where 1=1
          and Isnull(cc.isdelete,'') = ''
          and (
                (cc.processingmonth>4 and cc.processingyear={% parameter year %}-1)
                  or
                (cc.processingmonth<5 and cc.processingyear= {% parameter year %})
              )
      )
    SELECT
      c.distributorid,m.operatingcompanycode as opco,
      m.homecompanycode,m.emailaddress,m.alternatephone1,m.memberlevel,
      INITCAP(m.city) as city,
      INITCAP(CONCAT(CONCAT(m.memberlastname,','),m.memberfirstname)) as name,
      c.monthlyopco,c.eaglemanagerlevel,c.eaglemanagertotalcc,c.homecountrynewcc,c.nonhomecountrynewcc,
      c.totalglobalnewcc,c.numberofeaglemanagersrequired,c.numberofnewsupervisors,c.eaglemanagers,c.downlineeaglemanagers,
      c.numberofdownlineeaglemanagers
    from cte c
    join prod2.dim_member m
      on m.distributorid=c.distributorid
    WHERE c.rown=1
      and {% condition memopco %} m.operatingcompanycode {% endcondition %}
      and {% condition homeopco %} m.homecompanycode {% endcondition %}
--      and lower(m.operatingcompanycode) = lower({% parameter parameter_opco %})
--      and lower(m.homecompanycode)=lower({% parameter parameter_home_opco %})
    ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: parameter_opco {
    type: string
  }

  parameter: parameter_home_opco {
    type: string
  }

  filter: memopco {
    case_sensitive: no
    type: string
  }

  filter: homeopco {
    case_sensitive: no
    type: string
  }
  dimension: distributorid {
    label: "FBO ID"
    type: string
    sql: SUBSTRING(${TABLE}.distributorid, 1,3) + '-' + SUBSTRING(${TABLE}.distributorid, 4,3)
        + '-' + SUBSTRING(${TABLE}.distributorid, 7,3) + '-' + SUBSTRING(${TABLE}.distributorid, 10,3)
        ;;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: opco {
    label: "Member OpCO"
    case_sensitive: no
    type: string
    sql: ${TABLE}.opco ;;
  }

  dimension: homecompanycode {
    label: "Home Country"
    case_sensitive: no
    type: string
    sql: ${TABLE}.homecompanycode ;;
  }

  dimension: emailaddress {
    label: "Email"
    type: string
    sql: ${TABLE}.emailaddress ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: alternatephone1 {
    label: "Phone"
    type: string
    sql: ${TABLE}.alternatephone1 ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: memberlevel {
    label: "Level"
    case_sensitive: no
    type: string
    sql: ${TABLE}.memberlevel ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: name {
    label: "Name"
    type: string
    sql: ${TABLE}.name ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: monthlyopco {
    label: "Monthly OpCO"
    case_sensitive: no
    type: string
    sql: ${TABLE}.monthlyopco ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: eaglemanagerlevel {
    label: "Eagle Manager Level"
    type: string
    sql: ${TABLE}.eaglemanagerlevel ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: eaglemanagertotalcc {
    label: "Eagle Manager Total CC"
    type: number
    sql: ${TABLE}.eaglemanagertotalcc ;;
  }

  dimension: homecountrynewcc {
    label: "Home New N/M CC"
    type: number
    sql: ${TABLE}.homecountrynewcc ;;
  }

  dimension: nonhomecountrynewcc {
    label: "Non-Home New N/M CC"
    type: number
    sql: ${TABLE}.nonhomecountrynewcc ;;
  }

  dimension: totalglobalnewcc {
    label: "Total New N/M CC"
    type: number
    sql: ${TABLE}.totalglobalnewcc ;;
  }

  dimension: numberofeaglemanagersrequired {
    label: "Number of Eagle Managers Required"
    type: number
    sql: ${TABLE}.numberofeaglemanagersrequired ;;
  }

  dimension: numberofnewsupervisors {
    label: "Number of New Supervisors"
    type: number
    sql: ${TABLE}.numberofnewsupervisors ;;
  }

  dimension: eaglemanagers {
    label: "Eagle Managers"
    type: number
    sql: ${TABLE}.eaglemanagers ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: downlineeaglemanagers {
    label: "Downline Eagle Managers Ids"
    type: string
    sql: ${TABLE}.downlineeaglemanagers ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: numberofdownlineeaglemanagers {
    label: "Downline Eagle Managers "
    type: number
    sql: ${TABLE}.numberofdownlineeaglemanagers ;;
  }
  dimension: eagle_manager_lines {
    type: number
    sql: ${TABLE}.numberofdownlineeaglemanagers ;;
  }

  parameter: year {
    type: string
    allowed_value: {label: "Ending Apr-2021" value: "2021"}
    allowed_value: {label: "Ending Apr-2020" value: "2020"}
    allowed_value:{ label: "Ending Apr-2019" value: "2019"}
    allowed_value:{ label: "Ending Apr-2018" value: "2018"}
    allowed_value:{ label: "Ending Apr-2017" value: "2017"}
    allowed_value:{ label: "Ending Apr-2016" value: "2016"}
    allowed_value:{ label: "Ending Apr-2015" value: "2015"}
    allowed_value:{ label: "Ending Apr-2014" value: "2014"}
  }

  set: detail {
    fields: [
      distributorid,
      opco,
      homecompanycode,
      emailaddress,
      alternatephone1,
      memberlevel,
      city,
      name,
      monthlyopco,
      eaglemanagerlevel,
      eaglemanagertotalcc,
      homecountrynewcc,
      nonhomecountrynewcc,
      totalglobalnewcc,
      numberofeaglemanagersrequired,
      numberofnewsupervisors,
      eaglemanagers,
      downlineeaglemanagers,
      numberofdownlineeaglemanagers,
      eagle_manager_lines
    ]
  }

}
