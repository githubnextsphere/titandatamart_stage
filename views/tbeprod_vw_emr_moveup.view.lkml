view: tbeprod_vw_emr_moveup {

  derived_table: {
    sql: SELECT  sponsordistributorid,
                (
                CASE
                                WHEN ml.currentlevel='Novus Customer' THEN ml.fpcorfbolevel_processingmonth
                                WHEN ml.currentlevel='Assistant Supervisor' THEN ml.assistantsupervisorlevel_processingmonth
                                WHEN ml.currentlevel='Supervisor' THEN ml.supervisorlevel_processingmonth
                                WHEN ml.currentlevel='Assistant Manager' THEN ml.assistantmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Unrecognized Manager' THEN ml.unrecognizedmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Recognized Manager' THEN ml.recognizedmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Senior Manager' THEN ml.seniormanagerlevel_processingmonth
                                WHEN ml.currentlevel='Soaring Manager' THEN ml.soaringmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Sapphire Manager' THEN ml.sapphiremanagerlevel_processingmonth
                                WHEN ml.currentlevel='Diamond Sapphire Manager' THEN ml.diamondsapphiremanagerlevel_processingmonth
                                WHEN ml.currentlevel='Diamond Manager' THEN ml.diamondmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Double Diamond Manager' THEN ml.doublediamondmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Triple Diamond Manager' THEN ml.triplediamondmanagerlevel_processingmonth
                                WHEN ml.currentlevel='Diamond Centurion Manager' THEN ml.diamondcenturionmanagerlevel_processingmonth
                END) AS month , (
                CASE
                                WHEN ml.currentlevel='Novus Customer' THEN ml.fpcorfbolevel_processingyear
                                WHEN ml.currentlevel='Assistant Supervisor' THEN ml.assistantsupervisorlevel_processingyear
                                WHEN ml.currentlevel='Supervisor' THEN ml.supervisorlevel_processingyear
                                WHEN ml.currentlevel='Assistant Manager' THEN ml.assistantmanagerlevel_processingyear
                                WHEN ml.currentlevel='Unrecognized Manager' THEN ml.unrecognizedmanagerlevel_processingyear
                                WHEN ml.currentlevel='Recognized Manager' THEN ml.recognizedmanagerlevel_processingyear
                                WHEN ml.currentlevel='Senior Manager' THEN ml.seniormanagerlevel_processingyear
                                WHEN ml.currentlevel='Soaring Manager' THEN ml.soaringmanagerlevel_processingyear
                                WHEN ml.currentlevel='Sapphire Manager' THEN ml.sapphiremanagerlevel_processingyear
                                WHEN ml.currentlevel='Diamond Sapphire Manager' THEN ml.diamondsapphiremanagerlevel_processingyear
                                WHEN ml.currentlevel='Diamond Manager' THEN ml.diamondmanagerlevel_processingyear
                                WHEN ml.currentlevel='Double Diamond Manager' THEN ml.doublediamondmanagerlevel_processingyear
                                WHEN ml.currentlevel='Triple Diamond Manager' THEN ml.triplediamondmanagerlevel_processingyear
                                WHEN ml.currentlevel='Diamond Centurion Manager' THEN ml.diamondcenturionmanagerlevel_processingyear
                END) AS year ,
                    Count( Distinct m.distributorid)
FROM            prod_as400.dim_member m
JOIN            prod_as400.dim_sponsor s
ON              s.distributorid = m.distributorid
LEFT JOIN       prod_as400.dim_memberlevel ml
ON              m.distributorid=ml.distributorid
WHERE           m.active = 'true'
AND             s.active = 'true'
AND             sponsordistributorid IN ('490000000630',
'600000287413','330000000811','490000034164','390000000224','460000000284','390100021064','270000834395','440000003805','360000000100',
'460000000107','410000007190','971000555210','550000014055','600000150452','440100598194','360000000143','360000606326','490000038602',
'480000000260','270001022624','440000826597','490000525393','330000001183','330000000002','490000000670','630000005569','330000010724',
'440000003884','330000003409','360000000773','234000006205','360000006929','490000033621','360000000661','490000004463','270001246693',
'600000364116','490000010100','490000083067'
)
AND             1= (
                CASE
                                WHEN ml.currentlevel='Diamond Centurion Manager'
                                AND             diamondcenturionmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Triple Diamond Manager'
                                AND             triplediamondmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Double Diamond Manager'
                                AND             doublediamondmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Diamond Manager'
                                AND             diamondmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Diamond Sapphire Manager'
                                AND             diamondsapphiremanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Sapphire Manager'
                                AND             sapphiremanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Soaring Manager'
                                AND             soaringmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Senior Manager'
                                AND             seniormanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Recognized Manager'
                                AND             recognizedmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Unrecognized Manager'
                                AND             unrecognizedmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Assistant Manager'
                                AND             assistantmanagerlevel_processingyear=2019
                                THEN 1
                                WHEN ml.currentlevel='Supervisor'
                                AND             supervisorlevel_processingyear=2019
                                THEN 1
                END )
                GROUP By sponsordistributorid,month,year
ORDER BY        sponsordistributorid,month,year
 ;;
  }

  dimension: sponsordistributorid {
    type: string
    sql: ${TABLE}.sponsordistributorid ;;
  }

  dimension: month {
    type: number
    sql: ${TABLE}.month ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: sum_distinct
    sql: ${TABLE}.count ;;
    sql_distinct_key: ${sponsordistributorid} ;;
  }


  dimension: month_name {
    type: string
    sql:
    CASE  WHEN ${TABLE}.month='1' THEN 'Jan'
          WHEN ${TABLE}.month='2' THEN 'Feb'
          WHEN ${TABLE}.month='3' THEN 'Mar'
          WHEN ${TABLE}.month='4' THEN 'Apr'
          WHEN ${TABLE}.month='5' THEN 'May'
          WHEN ${TABLE}.month='6' THEN 'Jun'
          WHEN ${TABLE}.month='7' THEN 'Jul'
          WHEN ${TABLE}.month='8' THEN 'Aug'
          WHEN ${TABLE}.month='9' THEN 'Sep'
          WHEN ${TABLE}.month='10' THEN 'Oct'
          WHEN ${TABLE}.month='11' THEN 'Nov'
          WHEN ${TABLE}.month='12' THEN 'Dec'
      END
    ;;
    order_by_field: month
  }


  set: detail {
    fields: [sponsordistributorid, month, year, count,month_name]
  }

  }
