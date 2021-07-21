view: vw_cc_required_moveup {
  derived_table: {
    sql: select
      m.distributorid,
      sum(f.unitqualificationvalue) as total_ccs,
      case when total_ccs >=2 then 0
        else (2-total_ccs)
      end as cc_required_to_moveup
      from prod2.dim_member m
      join prod2.fact_orderdetails f on f.distributorid = m.distributorid
      and f.isdelete <> 'D' and m.isdelete <> 'D'
      and m.memberlevel in ('Preferred Customer','Novus Customer')
      and m.memberstatus IN ('Active',
      'Restricted',
      'Pending')
      group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: total_ccs {
    type: number
    sql: ${TABLE}.total_ccs ;;
  }

  dimension: cc_required_to_moveup {
    type: number
    sql: ${TABLE}.cc_required_to_moveup ;;
  }

  set: detail {
    fields: [distributorid, total_ccs, cc_required_to_moveup]
  }
}
