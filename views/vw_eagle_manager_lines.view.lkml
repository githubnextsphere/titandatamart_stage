view: vw_eagle_manager_lines {
  derived_table: {
    sql: SELECT
        Trim(fe.frontlineid) as frontlineId,
        Trim(Isnull(mem.memberfirstname, '') + ' ' + Isnull(mem.memberlastname, '')) as frontlineName,
        Trim(fe.em_id) as downlineId,
        Trim(Isnull(m.memberfirstname, '') + ' ' + Isnull(m.memberlastname, '')) as downlineName,
        fe.country,
        dc.displayname,
        fe.generation,
        fe.emlevel,
        feq.downlineemcount
      FROM
        prod2aggregation_tbe.fact_emlines fe
      JOIN prod2.dim_member mem on
        mem.distributorid = fe.frontlineid
      JOIN prod2.dim_country dc on
        fe.country = dc.isocodethree
      JOIN prod2.dim_member m on
        m.distributorid = fe.em_id
      JOIN prod2aggregation_tbe.fact_emqualification feq on
        feq.distributorid = fe.em_id
        and
        feq.period =  {% parameter parameter_year  %}
      WHERE
        fe.distributorid = Replace(Replace({{ fboid_param._parameter_value }},'-',''),' ','')
        and  fe.period =  {% parameter parameter_year  %}
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  parameter: parameter_year {
    label: "Period"
    type: number
    allowed_value: { value: "2021" label:"May-2020 to April-2021"}
    allowed_value: { value: "2022" label:"May-2021 to April-2022"}
    default_value: "2022"
  }

  parameter: fboid_param {
    label:"FBO ID"
    type: string
  }

  dimension: frontlineid {
    label: "Front Line ID"
    type: string
    sql: SUBSTRING(${TABLE}.frontlineid, 1,3) + '-' + SUBSTRING(${TABLE}.frontlineid, 4,3)
          + '-' + SUBSTRING(${TABLE}.frontlineid, 7,3) + '-' + SUBSTRING(${TABLE}.frontlineid, 10,3)
          ;;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: frontlinename {
    label: "Front Line Name"
    type: string
    sql: ${TABLE}.frontlinename ;;
  }

  dimension: downlineid {
    label: "Downline ID"
    type: string
    sql: SUBSTRING(${TABLE}.downlineid, 1,3) + '-' + SUBSTRING(${TABLE}.downlineid, 4,3)
            + '-' + SUBSTRING(${TABLE}.downlineid, 7,3) + '-' + SUBSTRING(${TABLE}.downlineid, 10,3)
            ;;
    html: <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: downlinename {
    label: "Downline Name"
    type: string
    sql: ${TABLE}.downlinename ;;
  }

  dimension: country {
    hidden: yes
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: displayname {
    label: "Qualifying Country"
    type: string
    sql: ${TABLE}.displayname ;;
  }

  dimension: generation {
    label: "Generation"
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: emlevel {
    type: number
    hidden: yes
    sql: ${TABLE}.emlevel ;;
  }

  dimension: eaglemanagerlevel {
    label: "Eagle Mgr Level"
    case: {
      when: {
        sql: ${emlevel} = '1' ;;
        label: "Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '2' ;;
        label: "Senior Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '3' ;;
        label: "Soaring Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '4' ;;
        label: "Sapphire Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '5' ;;
        label: "Diamond Sapphire Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '6' ;;
        label: "Diamond Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '7' ;;
        label: "Double Diamond Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '8' ;;
        label: "Triple Diamond Eagle Manager"
      }
      when: {
        sql: ${emlevel} = '9' ;;
        label: "Diamond Centurion Eagle Manager"
      }
    }
  }

  dimension: downlineemcount {
    label: "Downline EM Managers"
    type: number
    sql: ${TABLE}.downlineemcount ;;
    html: {% if value != 0 %}
    <a href="https://foreverliving.looker.com/dashboards-next/6245?FBO+ID={{downlineid._value}}&Period={{_filters['vw_eagle_manager_lines.parameter_year']}}" target="_blank">
    <font color="blue" style="white-space: nowrap;">
    <u> {{ rendered_value  }} </u>
    </font>
    </a>
    {% else %}
    {{rendered_value}}
    {% endif %} ;;
  }

  set: detail {
    fields: [
      frontlineid,
      frontlinename,
      downlineid,
      downlinename,
      country,
      displayname,
      generation,
      emlevel,
      eaglemanagerlevel,
      downlineemcount
    ]
  }
}
