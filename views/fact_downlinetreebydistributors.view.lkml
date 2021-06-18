view: fact_downlinetreebydistributors {
  sql_table_name: stage_tbeaggregation.fact_downlinetreebydistributors ;;

  dimension: chairmansbonusglobalcccurrentyear {
    type: number
    sql: ${TABLE}.chairmansbonusglobalcccurrentyear ;;
  }

  dimension: chairmansbonusglobalccpreviousyear {
    type: number
    sql: ${TABLE}.chairmansbonusglobalccpreviousyear ;;
  }

  dimension: chairmansbonuspersonalnonmanagercccurrentmonth {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercccurrentmonth ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast10month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast10month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast11month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast11month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast2month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast2month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast3month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast3month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast4month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast4month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast5month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast5month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast6month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast6month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast7month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast7month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast8month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast8month ;;
  }

  dimension: chairmansbonuspersonalnonmanagercclast9month {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagercclast9month ;;
  }

  dimension: chairmansbonuspersonalnonmanagerccpreviousmonth {
    type: number
    sql: ${TABLE}.chairmansbonuspersonalnonmanagerccpreviousmonth ;;
  }

  dimension_group: createddate {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.createddate ;;
  }

  dimension: currentmonthactivecurrentmonth {
    type: string
    sql: ${TABLE}.currentmonthactivecurrentmonth ;;
  }

  dimension: currentmonthactivelast10month {
    type: string
    sql: ${TABLE}.currentmonthactivelast10month ;;
  }

  dimension: currentmonthactivelast11month {
    type: string
    sql: ${TABLE}.currentmonthactivelast11month ;;
  }

  dimension: currentmonthactivelast2month {
    type: string
    sql: ${TABLE}.currentmonthactivelast2month ;;
  }

  dimension: currentmonthactivelast3month {
    type: string
    sql: ${TABLE}.currentmonthactivelast3month ;;
  }

  dimension: currentmonthactivelast4month {
    type: string
    sql: ${TABLE}.currentmonthactivelast4month ;;
  }

  dimension: currentmonthactivelast5month {
    type: string
    sql: ${TABLE}.currentmonthactivelast5month ;;
  }

  dimension: currentmonthactivelast6month {
    type: string
    sql: ${TABLE}.currentmonthactivelast6month ;;
  }

  dimension: currentmonthactivelast7month {
    type: string
    sql: ${TABLE}.currentmonthactivelast7month ;;
  }

  dimension: currentmonthactivelast8month {
    type: string
    sql: ${TABLE}.currentmonthactivelast8month ;;
  }

  dimension: currentmonthactivelast9month {
    type: string
    sql: ${TABLE}.currentmonthactivelast9month ;;
  }

  dimension: currentmonthactivepreviousmonth {
    type: string
    sql: ${TABLE}.currentmonthactivepreviousmonth ;;
  }

  dimension: distributorcccurrentyear {
    type: number
    sql: ${TABLE}.distributorcccurrentyear ;;
  }

  dimension: distributorccpreviousyear {
    type: number
    sql: ${TABLE}.distributorccpreviousyear ;;
  }

  dimension: distributorccurrentmonth {
    type: number
    sql: ${TABLE}.distributorccurrentmonth ;;
  }

  dimension: distributorclast10month {
    type: number
    sql: ${TABLE}.distributorclast10month ;;
  }

  dimension: distributorclast11month {
    type: number
    sql: ${TABLE}.distributorclast11month ;;
  }

  dimension: distributorclast2month {
    type: number
    sql: ${TABLE}.distributorclast2month ;;
  }

  dimension: distributorclast3month {
    type: number
    sql: ${TABLE}.distributorclast3month ;;
  }

  dimension: distributorclast4month {
    type: number
    sql: ${TABLE}.distributorclast4month ;;
  }

  dimension: distributorclast5month {
    type: number
    sql: ${TABLE}.distributorclast5month ;;
  }

  dimension: distributorclast6month {
    type: number
    sql: ${TABLE}.distributorclast6month ;;
  }

  dimension: distributorclast7month {
    type: number
    sql: ${TABLE}.distributorclast7month ;;
  }

  dimension: distributorclast8month {
    type: number
    sql: ${TABLE}.distributorclast8month ;;
  }

  dimension: distributorclast9month {
    type: number
    sql: ${TABLE}.distributorclast9month ;;
  }

  dimension: distributorcpreviousmonth {
    type: number
    sql: ${TABLE}.distributorcpreviousmonth ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension: distributoridworkinglevel {
    type: string
    sql: ${TABLE}.distributoridworkinglevel ;;
  }

  dimension: downlineallowsponsortocontact {
    type: string
    sql: ${TABLE}.downlineallowsponsortocontact ;;
  }

  dimension: downlinealternatephone1 {
    type: string
    sql: ${TABLE}.downlinealternatephone1 ;;
  }

  dimension: downlineassistantsupervisorinsamemonth {
    type: number
    sql: ${TABLE}.downlineassistantsupervisorinsamemonth ;;
  }

  dimension: downlinedistributorid {
    type: string
    sql: ${TABLE}.downlinedistributorid ;;
  }

  dimension: downlinedistributoridworkinglevel {
    type: string
    sql: ${TABLE}.downlinedistributoridworkinglevel ;;
  }

  dimension: downlineemailaddress {
    type: string
    sql: ${TABLE}.downlineemailaddress ;;
  }

  dimension_group: downlineenrolmentdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.downlineenrolmentdate ;;
  }

  dimension: downlinefirstname {
    type: string
    sql: ${TABLE}.downlinefirstname ;;
  }

  dimension: downlinelastname {
    type: string
    sql: ${TABLE}.downlinelastname ;;
  }

  dimension_group: downlinememberfirstpurchasedate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.downlinememberfirstpurchasedate ;;
  }

  dimension: downlinememberlevel {
    type: string
    sql: ${TABLE}.downlinememberlevel ;;
  }

  dimension: downlinememberstatus {
    type: string
    sql: ${TABLE}.downlinememberstatus ;;
  }

  dimension: downlinepurchaseinsamemonth {
    type: string
    sql: ${TABLE}.downlinepurchaseinsamemonth ;;
  }

  dimension_group: downlinewholesaledistributordate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.downlinewholesaledistributordate ;;
  }

  dimension: eaglemanagerglobalcccurrentyear {
    type: number
    sql: ${TABLE}.eaglemanagerglobalcccurrentyear ;;
  }

  dimension: eaglemanagerglobalccpreviousyear {
    type: number
    sql: ${TABLE}.eaglemanagerglobalccpreviousyear ;;
  }

  dimension: eaglemanagertotalcccurrentmonth {
    type: number
    sql: ${TABLE}.eaglemanagertotalcccurrentmonth ;;
  }

  dimension: eaglemanagertotalcclast10month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast10month ;;
  }

  dimension: eaglemanagertotalcclast11month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast11month ;;
  }

  dimension: eaglemanagertotalcclast2month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast2month ;;
  }

  dimension: eaglemanagertotalcclast3month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast3month ;;
  }

  dimension: eaglemanagertotalcclast4month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast4month ;;
  }

  dimension: eaglemanagertotalcclast5month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast5month ;;
  }

  dimension: eaglemanagertotalcclast6month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast6month ;;
  }

  dimension: eaglemanagertotalcclast7month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast7month ;;
  }

  dimension: eaglemanagertotalcclast8month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast8month ;;
  }

  dimension: eaglemanagertotalcclast9month {
    type: number
    sql: ${TABLE}.eaglemanagertotalcclast9month ;;
  }

  dimension: eaglemanagertotalccpreviousmonth {
    type: number
    sql: ${TABLE}.eaglemanagertotalccpreviousmonth ;;
  }

  dimension: factdownlinetreebydistributorskey {
    type: number
    sql: ${TABLE}.factdownlinetreebydistributorskey ;;
  }

  dimension: generation {
    type: number
    sql: ${TABLE}.generation ;;
  }

  dimension: globalcasecreditscurrentmonth {
    type: number
    sql: ${TABLE}.globalcasecreditscurrentmonth ;;
  }

  dimension: globalcasecreditscurrentyear {
    type: number
    sql: ${TABLE}.globalcasecreditscurrentyear ;;
  }

  dimension: globalcasecreditslast10month {
    type: number
    sql: ${TABLE}.globalcasecreditslast10month ;;
  }

  dimension: globalcasecreditslast11month {
    type: number
    sql: ${TABLE}.globalcasecreditslast11month ;;
  }

  dimension: globalcasecreditslast2month {
    type: number
    sql: ${TABLE}.globalcasecreditslast2month ;;
  }

  dimension: globalcasecreditslast3month {
    type: number
    sql: ${TABLE}.globalcasecreditslast3month ;;
  }

  dimension: globalcasecreditslast4month {
    type: number
    sql: ${TABLE}.globalcasecreditslast4month ;;
  }

  dimension: globalcasecreditslast5month {
    type: number
    sql: ${TABLE}.globalcasecreditslast5month ;;
  }

  dimension: globalcasecreditslast6month {
    type: number
    sql: ${TABLE}.globalcasecreditslast6month ;;
  }

  dimension: globalcasecreditslast7month {
    type: number
    sql: ${TABLE}.globalcasecreditslast7month ;;
  }

  dimension: globalcasecreditslast8month {
    type: number
    sql: ${TABLE}.globalcasecreditslast8month ;;
  }

  dimension: globalcasecreditslast9month {
    type: number
    sql: ${TABLE}.globalcasecreditslast9month ;;
  }

  dimension: globalcasecreditspreviousmonth {
    type: number
    sql: ${TABLE}.globalcasecreditspreviousmonth ;;
  }

  dimension: globalcasecreditspreviousyear {
    type: number
    sql: ${TABLE}.globalcasecreditspreviousyear ;;
  }

  dimension: globalchairmansbonuscurrentmonth {
    type: number
    sql: ${TABLE}.globalchairmansbonuscurrentmonth ;;
  }

  dimension: globalchairmansbonuslast10month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast10month ;;
  }

  dimension: globalchairmansbonuslast11month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast11month ;;
  }

  dimension: globalchairmansbonuslast2month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast2month ;;
  }

  dimension: globalchairmansbonuslast3month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast3month ;;
  }

  dimension: globalchairmansbonuslast4month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast4month ;;
  }

  dimension: globalchairmansbonuslast5month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast5month ;;
  }

  dimension: globalchairmansbonuslast6month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast6month ;;
  }

  dimension: globalchairmansbonuslast7month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast7month ;;
  }

  dimension: globalchairmansbonuslast8month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast8month ;;
  }

  dimension: globalchairmansbonuslast9month {
    type: number
    sql: ${TABLE}.globalchairmansbonuslast9month ;;
  }

  dimension: globalchairmansbonuspreviousmonth {
    type: number
    sql: ${TABLE}.globalchairmansbonuspreviousmonth ;;
  }

  dimension: globaleagemanagercurrentmonth {
    type: number
    sql: ${TABLE}.globaleagemanagercurrentmonth ;;
  }

  dimension: globaleagemanagerlast10month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast10month ;;
  }

  dimension: globaleagemanagerlast11month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast11month ;;
  }

  dimension: globaleagemanagerlast2month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast2month ;;
  }

  dimension: globaleagemanagerlast3month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast3month ;;
  }

  dimension: globaleagemanagerlast4month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast4month ;;
  }

  dimension: globaleagemanagerlast5month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast5month ;;
  }

  dimension: globaleagemanagerlast6month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast6month ;;
  }

  dimension: globaleagemanagerlast7month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast7month ;;
  }

  dimension: globaleagemanagerlast8month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast8month ;;
  }

  dimension: globaleagemanagerlast9month {
    type: number
    sql: ${TABLE}.globaleagemanagerlast9month ;;
  }

  dimension: globaleagemanagerpreviousmonth {
    type: number
    sql: ${TABLE}.globaleagemanagerpreviousmonth ;;
  }

  dimension: hasdownline {
    type: string
    sql: ${TABLE}.hasdownline ;;
  }

  dimension: homecountry {
    type: string
    sql: ${TABLE}.homecountry ;;
  }

  dimension: isnonmgrdownline {
    type: string
    sql: ${TABLE}.isnonmgrdownline ;;
  }

  dimension: leadershipcasecreditscurrentyear {
    type: number
    sql: ${TABLE}.leadershipcasecreditscurrentyear ;;
  }

  dimension: leadershipcasecreditspreviousyear {
    type: number
    sql: ${TABLE}.leadershipcasecreditspreviousyear ;;
  }

  dimension: leadershipcccurrentmonth {
    type: number
    sql: ${TABLE}.leadershipcccurrentmonth ;;
  }

  dimension: leadershipcclast10month {
    type: number
    sql: ${TABLE}.leadershipcclast10month ;;
  }

  dimension: leadershipcclast11month {
    type: number
    sql: ${TABLE}.leadershipcclast11month ;;
  }

  dimension: leadershipcclast2month {
    type: number
    sql: ${TABLE}.leadershipcclast2month ;;
  }

  dimension: leadershipcclast3month {
    type: number
    sql: ${TABLE}.leadershipcclast3month ;;
  }

  dimension: leadershipcclast4month {
    type: number
    sql: ${TABLE}.leadershipcclast4month ;;
  }

  dimension: leadershipcclast5month {
    type: number
    sql: ${TABLE}.leadershipcclast5month ;;
  }

  dimension: leadershipcclast6month {
    type: number
    sql: ${TABLE}.leadershipcclast6month ;;
  }

  dimension: leadershipcclast7month {
    type: number
    sql: ${TABLE}.leadershipcclast7month ;;
  }

  dimension: leadershipcclast8month {
    type: number
    sql: ${TABLE}.leadershipcclast8month ;;
  }

  dimension: leadershipcclast9month {
    type: number
    sql: ${TABLE}.leadershipcclast9month ;;
  }

  dimension: leadershipccpreviousmonth {
    type: number
    sql: ${TABLE}.leadershipccpreviousmonth ;;
  }

  dimension: nonmanagercccurrentmonth {
    type: number
    sql: ${TABLE}.nonmanagercccurrentmonth ;;
  }

  dimension: nonmanagercccurrentyear {
    type: number
    sql: ${TABLE}.nonmanagercccurrentyear ;;
  }

  dimension: nonmanagercclast10month {
    type: number
    sql: ${TABLE}.nonmanagercclast10month ;;
  }

  dimension: nonmanagercclast11month {
    type: number
    sql: ${TABLE}.nonmanagercclast11month ;;
  }

  dimension: nonmanagercclast2month {
    type: number
    sql: ${TABLE}.nonmanagercclast2month ;;
  }

  dimension: nonmanagercclast3month {
    type: number
    sql: ${TABLE}.nonmanagercclast3month ;;
  }

  dimension: nonmanagercclast4month {
    type: number
    sql: ${TABLE}.nonmanagercclast4month ;;
  }

  dimension: nonmanagercclast5month {
    type: number
    sql: ${TABLE}.nonmanagercclast5month ;;
  }

  dimension: nonmanagercclast6month {
    type: number
    sql: ${TABLE}.nonmanagercclast6month ;;
  }

  dimension: nonmanagercclast7month {
    type: number
    sql: ${TABLE}.nonmanagercclast7month ;;
  }

  dimension: nonmanagercclast8month {
    type: number
    sql: ${TABLE}.nonmanagercclast8month ;;
  }

  dimension: nonmanagercclast9month {
    type: number
    sql: ${TABLE}.nonmanagercclast9month ;;
  }

  dimension: nonmanagerccpreviousmonth {
    type: number
    sql: ${TABLE}.nonmanagerccpreviousmonth ;;
  }

  dimension: nonmanagerccpreviousyear {
    type: number
    sql: ${TABLE}.nonmanagerccpreviousyear ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: passthroughcccurrentmonth {
    type: number
    sql: ${TABLE}.passthroughcccurrentmonth ;;
  }

  dimension: passthroughcclast10month {
    type: number
    sql: ${TABLE}.passthroughcclast10month ;;
  }

  dimension: passthroughcclast11month {
    type: number
    sql: ${TABLE}.passthroughcclast11month ;;
  }

  dimension: passthroughcclast2month {
    type: number
    sql: ${TABLE}.passthroughcclast2month ;;
  }

  dimension: passthroughcclast3month {
    type: number
    sql: ${TABLE}.passthroughcclast3month ;;
  }

  dimension: passthroughcclast4month {
    type: number
    sql: ${TABLE}.passthroughcclast4month ;;
  }

  dimension: passthroughcclast5month {
    type: number
    sql: ${TABLE}.passthroughcclast5month ;;
  }

  dimension: passthroughcclast6month {
    type: number
    sql: ${TABLE}.passthroughcclast6month ;;
  }

  dimension: passthroughcclast7month {
    type: number
    sql: ${TABLE}.passthroughcclast7month ;;
  }

  dimension: passthroughcclast8month {
    type: number
    sql: ${TABLE}.passthroughcclast8month ;;
  }

  dimension: passthroughcclast9month {
    type: number
    sql: ${TABLE}.passthroughcclast9month ;;
  }

  dimension: passthroughccpreviousmonth {
    type: number
    sql: ${TABLE}.passthroughccpreviousmonth ;;
  }

  dimension: personalcccurrentmonth {
    type: number
    sql: ${TABLE}.personalcccurrentmonth ;;
  }

  dimension: personalcccurrentyear {
    type: number
    sql: ${TABLE}.personalcccurrentyear ;;
  }

  dimension: personalcclast10month {
    type: number
    sql: ${TABLE}.personalcclast10month ;;
  }

  dimension: personalcclast11month {
    type: number
    sql: ${TABLE}.personalcclast11month ;;
  }

  dimension: personalcclast2month {
    type: number
    sql: ${TABLE}.personalcclast2month ;;
  }

  dimension: personalcclast3month {
    type: number
    sql: ${TABLE}.personalcclast3month ;;
  }

  dimension: personalcclast4month {
    type: number
    sql: ${TABLE}.personalcclast4month ;;
  }

  dimension: personalcclast5month {
    type: number
    sql: ${TABLE}.personalcclast5month ;;
  }

  dimension: personalcclast6month {
    type: number
    sql: ${TABLE}.personalcclast6month ;;
  }

  dimension: personalcclast7month {
    type: number
    sql: ${TABLE}.personalcclast7month ;;
  }

  dimension: personalcclast8month {
    type: number
    sql: ${TABLE}.personalcclast8month ;;
  }

  dimension: personalcclast9month {
    type: number
    sql: ${TABLE}.personalcclast9month ;;
  }

  dimension: personalccpreviousmonth {
    type: number
    sql: ${TABLE}.personalccpreviousmonth ;;
  }

  dimension: personalccpreviousyear {
    type: number
    sql: ${TABLE}.personalccpreviousyear ;;
  }

  dimension: personaldistributorid {
    type: string
    sql: ${TABLE}.personaldistributorid ;;
  }

  dimension: personaldistributorname {
    type: string
    sql: ${TABLE}.personaldistributorname ;;
  }

  dimension_group: personalsponsoredenrollmentdate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.personalsponsoredenrollmentdate ;;
  }

  dimension: personalsponsoredmemberlevel {
    type: string
    sql: ${TABLE}.personalsponsoredmemberlevel ;;
  }

  dimension: recursiveuplinedistributorids {
    type: string
    sql: ${TABLE}.recursiveuplinedistributorids ;;
  }

  dimension_group: sponsordate {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.sponsordate ;;
  }

  dimension: sponsordistributorid {
    type: string
    sql: ${TABLE}.sponsordistributorid ;;
  }

  dimension: sponsordistributoridworkinglevel {
    type: string
    sql: ${TABLE}.sponsordistributoridworkinglevel ;;
  }

  dimension: sponsorfirstname {
    type: string
    sql: ${TABLE}.sponsorfirstname ;;
  }

  dimension: sponsorlastname {
    type: string
    sql: ${TABLE}.sponsorlastname ;;
  }

  dimension: sponsorstatus {
    type: string
    sql: ${TABLE}.sponsorstatus ;;
  }

  dimension: totalactivecccurrentmonth {
    type: number
    sql: ${TABLE}.totalactivecccurrentmonth ;;
  }

  dimension: totalactivecccurrentyear {
    type: number
    sql: ${TABLE}.totalactivecccurrentyear ;;
  }

  dimension: totalactivecclast10month {
    type: number
    sql: ${TABLE}.totalactivecclast10month ;;
  }

  dimension: totalactivecclast11month {
    type: number
    sql: ${TABLE}.totalactivecclast11month ;;
  }

  dimension: totalactivecclast2month {
    type: number
    sql: ${TABLE}.totalactivecclast2month ;;
  }

  dimension: totalactivecclast3month {
    type: number
    sql: ${TABLE}.totalactivecclast3month ;;
  }

  dimension: totalactivecclast4month {
    type: number
    sql: ${TABLE}.totalactivecclast4month ;;
  }

  dimension: totalactivecclast5month {
    type: number
    sql: ${TABLE}.totalactivecclast5month ;;
  }

  dimension: totalactivecclast6month {
    type: number
    sql: ${TABLE}.totalactivecclast6month ;;
  }

  dimension: totalactivecclast7month {
    type: number
    sql: ${TABLE}.totalactivecclast7month ;;
  }

  dimension: totalactivecclast8month {
    type: number
    sql: ${TABLE}.totalactivecclast8month ;;
  }

  dimension: totalactivecclast9month {
    type: number
    sql: ${TABLE}.totalactivecclast9month ;;
  }

  dimension: totalactiveccpreviousmonth {
    type: number
    sql: ${TABLE}.totalactiveccpreviousmonth ;;
  }

  dimension: totalactiveccpreviousyear {
    type: number
    sql: ${TABLE}.totalactiveccpreviousyear ;;
  }

  dimension: totalcccurrentmonth {
    type: number
    sql: ${TABLE}.totalcccurrentmonth ;;
  }

  dimension: totalcccurrentyear {
    type: number
    sql: ${TABLE}.totalcccurrentyear ;;
  }

  dimension: totalcclast10month {
    type: number
    sql: ${TABLE}.totalcclast10month ;;
  }

  dimension: totalcclast11month {
    type: number
    sql: ${TABLE}.totalcclast11month ;;
  }

  dimension: totalcclast2month {
    type: number
    sql: ${TABLE}.totalcclast2month ;;
  }

  dimension: totalcclast3month {
    type: number
    sql: ${TABLE}.totalcclast3month ;;
  }

  dimension: totalcclast4month {
    type: number
    sql: ${TABLE}.totalcclast4month ;;
  }

  dimension: totalcclast5month {
    type: number
    sql: ${TABLE}.totalcclast5month ;;
  }

  dimension: totalcclast6month {
    type: number
    sql: ${TABLE}.totalcclast6month ;;
  }

  dimension: totalcclast7month {
    type: number
    sql: ${TABLE}.totalcclast7month ;;
  }

  dimension: totalcclast8month {
    type: number
    sql: ${TABLE}.totalcclast8month ;;
  }

  dimension: totalcclast9month {
    type: number
    sql: ${TABLE}.totalcclast9month ;;
  }

  dimension: totalccpreviousmonth {
    type: number
    sql: ${TABLE}.totalccpreviousmonth ;;
  }

  dimension: totalccpreviousyear {
    type: number
    sql: ${TABLE}.totalccpreviousyear ;;
  }

  dimension: uplinefboids {
    type: string
    sql: ${TABLE}.uplinefboids ;;
  }

  dimension_group: validfrom {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.validfrom ;;
  }

  measure: count {
    type: count
    drill_fields: [personaldistributorname, downlinefirstname, downlinelastname, sponsorfirstname, sponsorlastname]
  }
}
