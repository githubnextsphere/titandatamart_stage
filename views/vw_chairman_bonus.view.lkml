view: vw_chairman_bonus {
  derived_table: {
    sql: with cte as(
      SELECT       distinct cc.distributorid,
              Max(cc.chairmansbonusglobalcc)    AS chairmansbonusglobalcc
      FROM            stage_tbe.dim_yearlycc cc
      WHERE
      Isnull(cc.isdelete, '') = ''
      AND
      --AND             extract(year from cc.processingdate)  = 2020
      {% if vw_chairman_bonus.parameter_year._parameter_value == "'Current Year'" %}
       extract(year from cc.processingdate) = extract(year from CURRENT_DATE)
      {% else %}  extract(year from cc.processingdate) = {{ vw_chairman_bonus.parameter_year._parameter_value }}
      {% endif %}
      GROUP BY        cc.distributorid
      ORDER BY  1
      )
      SELECT DISTINCT Date_part(year,cc.processingdate) AS year,
                      cc.chairmansbonuspersonalnonmanagercc,
                      cc.homecountrychairmansbonuscc,
                      cc.nonhomecountrychairmansbonuscc,
                      c.chairmansbonusglobalcc,
                      cc.numberofcbmanagers,
                      cc.numberofdownlinemanagerswith600cc,
                      cc.distributorid,
                      cc.operatingcompanycode,
                      cc.homecompanycode,
                      Replace(Quote_literal(Replace(Trim(cc.downlinechairmansbonusqualifiers),'|', ',')),',',Quote_literal(',')) AS downlinechairmansbonusqualifiers
      FROM            stage_tbe.dim_yearlycc cc
      join cte c on c.distributorid = cc.distributorid
      WHERE
      Isnull(cc.isdelete, '') = ''
      and {% condition operating_country_code %} cc.operatingcompanycode {% endcondition %}
      and
      {% if vw_chairman_bonus.parameter_year._parameter_value == "'Current Year'" %}
       extract(year from cc.processingdate) = extract(year from CURRENT_DATE)
      {% else %}  extract(year from cc.processingdate) = {{ vw_chairman_bonus.parameter_year._parameter_value }}
      {% endif %}
     -- AND             extract(year from cc.processingdate) = 2020
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: year {
    type: number
    label: "Processing Year"
    sql: ${TABLE}.year ;;
  }

  dimension: chairmansbonuspersonalnonmanagercc {
    label: "Home Personal N/M CC"
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercc ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: homecountrychairmansbonuscc {
    label: "Home New N/M CC"
    type: number
    sql: ${TABLE}.homecountrychairmansbonuscc ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: nonhomecountrychairmansbonuscc {
    label: "Non-Home New N/M CC"
    type: number
    sql: ${TABLE}.nonhomecountrychairmansbonuscc ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: chairmansbonusglobalcc {
    label: "Global New N/M CC"
    type: number
    sql: ${TABLE}.chairmansbonusglobalcc ;;
    value_format: "#,##0.000"
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: numberofcbmanagers {
    label: "Chairman Bonus Manager lines"
    type: number
    sql: ${TABLE}.numberofcbmanagers ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: numberofdownlinemanagerswith600cc {
    label: "600 CC Managers"
    type: number
    sql: ${TABLE}.numberofdownlinemanagerswith600cc ;;
    html: <font style="white-space: nowrap;"> {{rendered_value}}  </font>;;
  }

  dimension: distributorid {
    type: string
    case_sensitive: no
    sql: ${TABLE}.distributorid ;;
  }

  dimension: operating_country_code {
    type: string
    case_sensitive: no
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: home_country_code {
    type: string
    case_sensitive: no
    sql: ${TABLE}.homecompanycode ;;
  }

  dimension: downlinechairmansbonusqualifiers {
    type: string
    case_sensitive: no
    sql: ${TABLE}.downlinechairmansbonusqualifiers ;;
  }

  parameter: parameter_year {
    type: string
    allowed_value: { value: "Current Year"}
    allowed_value: { value: "2025" }
    allowed_value: { value: "2024" }
    allowed_value: { value: "2023" }
    allowed_value: { value: "2022" }
    allowed_value: { value: "2021" }
    allowed_value: { value: "2020" }
    allowed_value: { value: "2019" }
    allowed_value: { value: "2018" }
    allowed_value: { value: "2017" }
    allowed_value: { value: "2016" }
    default_value: "Current Year"
  }


  set: detail {
    fields: [
      year,
      chairmansbonuspersonalnonmanagercc,
      homecountrychairmansbonuscc,
      nonhomecountrychairmansbonuscc,
      chairmansbonusglobalcc,
      numberofcbmanagers,
      numberofdownlinemanagerswith600cc,
      distributorid,
      downlinechairmansbonusqualifiers,
      operating_country_code

    ]
  }
 }
