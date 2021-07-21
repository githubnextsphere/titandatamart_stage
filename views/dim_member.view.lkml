view: dim_member {
  sql_table_name: prod_as400.dim_member ;;

  dimension: fbo_id {
    description: "FBO ID formatted with dashes"
    type: string
    label: "FBO ID"
    group_label: "Primary Data"
    sql: SUBSTRING(${TABLE}.distributorid, 1,3) + '-' + SUBSTRING(${TABLE}.distributorid, 4,3)
          + '-' + SUBSTRING(${TABLE}.distributorid, 7,3) + '-' + SUBSTRING(${TABLE}.distributorid, 10,3)
          ;;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: first {
    type: string
    description: "This field shows member first name"
    group_label: "Primary Data"
    sql: initcap(${TABLE}.memberfirstname) ;;
    html: <font style="white-space: nowrap;">{{ value }} </font>;;
  }

  dimension: last {
    type: string
    description: "This field shows member first name"
    group_label: "Primary Data"
    sql: initcap(${TABLE}.memberlastname) ;;
    html: <font style="white-space: nowrap;">{{ value }} </font>;;
  }


  dimension: fbo_name_first_last {
    description: "FBO Name"
    type: string
    label: "FBO Name"
    sql: CONCAT(CONCAT(${first}, ' '), ${last}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: opco {
    label : "Member OpCO"
    type: string
    case_sensitive: no
    sql: ${TABLE}.operatingcompanycode ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: country {
    label: "Member Country"
    case_sensitive: no
    type: string
    map_layer_name: countries
    sql: INITCAP(${TABLE}.country) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension_group: enrollment_date {
    label: "Enrolment"
    timeframes: [date]
    type: time
    sql: ${TABLE}.enrolmentdate ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension_group: validfrom {
    description: "This field shows last modified date of member"
    label: "Last Modified"
    group_label: "Info"
    convert_tz: no
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.validfrom ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font> ;;
  }

  dimension: retail_email {
    description: "This field shows email address of Retail Customer"
    type: string
    label: "Email"
    sql: ${TABLE}.emailaddress ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: phone_1 {
    description: "This field shows phone 1 of member"
    group_label: "Contact Info"
    type: string
    sql: ${TABLE}.alternatephone1 ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: vat {
    description: "This field shows if the distributor is VAT registered or not."
    label: "VAT"
    group_label: "Info"
    type: string
    case_sensitive: no
    sql:  CASE WHEN ${TABLE}.vatregistered='true' THEN 'Yes'
               WHEN ${TABLE}.vatregistered='false' THEN 'No'
               ELSE ''
          END;;
  }

  dimension: active {
    type: string
    sql: ${TABLE}.active ;;
  }

  dimension: addressline1 {
    type: string
    sql: ${TABLE}.addressline1 ;;
  }

  dimension: addressline2 {
    type: string
    sql: ${TABLE}.addressline2 ;;
  }

  dimension: addressline3 {
    type: string
    sql: ${TABLE}.addressline3 ;;
  }

  dimension: addressline4 {
    type: string
    sql: ${TABLE}.addressline4 ;;
  }

  dimension: allowsponsortocontact {
    type: string
    sql: ${TABLE}.allowsponsortocontact ;;
  }

  dimension: alternatephone1 {
    type: string
    sql: ${TABLE}.alternatephone1 ;;
  }

  dimension: alternatephone2 {
    type: string
    sql: ${TABLE}.alternatephone2 ;;
  }

  dimension: alternatephone3 {
    type: string
    sql: ${TABLE}.alternatephone3 ;;
  }

  dimension: areacode {
    type: string
    sql: ${TABLE}.areacode ;;
  }

  dimension_group: assistantsupervisordate {
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
    sql: ${TABLE}.assistantsupervisordate ;;
  }

  dimension: assistantsupervisorinsamemonth {
    type: number
    sql: ${TABLE}.assistantsupervisorinsamemonth ;;
  }

  dimension: autoshipenabled {
    type: string
    sql: ${TABLE}.autoshipenabled ;;
  }

  dimension: bindingid {
    type: number
    value_format_name: id
    sql: ${TABLE}.bindingid ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: closetomoveup {
    type: string
    sql: ${TABLE}.closetomoveup ;;
  }

  dimension_group: closetomoveupexpirydate {
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
    sql: ${TABLE}.closetomoveupexpirydate ;;
  }


  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
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

  dimension: datapipelinestatus {
    type: string
    sql: ${TABLE}.datapipelinestatus ;;
  }

  dimension: datasource {
    type: string
    sql: ${TABLE}.datasource ;;
  }

  dimension: displayphoneinsearch {
    type: string
    sql: ${TABLE}.displayphoneinsearch ;;
  }

  dimension: distributorid {
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension_group: downlinememberfirstjoindate {
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
    sql: ${TABLE}.downlinememberfirstjoindate ;;
  }

  dimension: drivinglicensenumber {
    type: string
    sql: ${TABLE}.drivinglicensenumber ;;
  }

  dimension: eirnumber {
    type: string
    sql: ${TABLE}.eirnumber ;;
  }

  dimension: emailaddress {
    type: string
    sql: ${TABLE}.emailaddress ;;
  }

  dimension: enrollmenttype {
    type: string
    sql: ${TABLE}.enrollmenttype ;;
  }

  dimension_group: enrolmentdate {
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
    sql: ${TABLE}.enrolmentdate ;;
  }

  dimension: enrolmentyear {
    type: number
    sql: ${TABLE}.enrolmentyear ;;
  }

  dimension: externalsequencenumber {
    type: number
    sql: ${TABLE}.externalsequencenumber ;;
  }

  dimension_group: firstorderdate {
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
    sql: ${TABLE}.firstorderdate ;;
  }

  dimension: firstorderhomecompanycode {
    type: string
    sql: ${TABLE}.firstorderhomecompanycode ;;
  }

  dimension: firstordernumber {
    type: string
    sql: ${TABLE}.firstordernumber ;;
  }

  dimension: firstorderoperatingcompanycode {
    type: string
    sql: ${TABLE}.firstorderoperatingcompanycode ;;
  }

  dimension: firstorderprocessingmonth {
    type: number
    sql: ${TABLE}.firstorderprocessingmonth ;;
  }

  dimension: firstorderprocessingyear {
    type: number
    sql: ${TABLE}.firstorderprocessingyear ;;
  }

  dimension: firstordertdmorderid {
    type: number
    value_format_name: id
    sql: ${TABLE}.firstordertdmorderid ;;
  }

  dimension: firstpurchasemonth {
    type: number
    sql: ${TABLE}.firstpurchasemonth ;;
  }

  dimension: firstpurchaseyear {
    type: number
    sql: ${TABLE}.firstpurchaseyear ;;
  }

  dimension: hasdownline {
    type: string
    sql: ${TABLE}.hasdownline ;;
  }

  dimension: hasglobaldownline {
    type: string
    sql: ${TABLE}.hasglobaldownline ;;
  }

  dimension: homecompanycode {
    type: string
    sql: ${TABLE}.homecompanycode ;;
  }

  dimension: homephone {
    type: string
    sql: ${TABLE}.homephone ;;
  }

  dimension: imagefilename {
    type: string
    sql: ${TABLE}.imagefilename ;;
  }

  dimension: imagestorageinfoid {
    type: number
    value_format_name: id
    sql: ${TABLE}.imagestorageinfoid ;;
  }

  dimension: isdelete {
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: itinnumber {
    type: string
    sql: ${TABLE}.itinnumber ;;
  }

  dimension: languagepreference {
    type: string
    sql: ${TABLE}.languagepreference ;;
  }

  dimension_group: lastmoveupdate {
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
    sql: ${TABLE}.lastmoveupdate ;;
  }

  dimension: levelhistorycode {
    type: string
    sql: ${TABLE}.levelhistorycode ;;
  }

  dimension: levelprocessingmonth {
    type: number
    sql: ${TABLE}.levelprocessingmonth ;;
  }

  dimension: levelprocessingyear {
    type: number
    sql: ${TABLE}.levelprocessingyear ;;
  }

  dimension: lookupenabled {
    type: string
    sql: ${TABLE}.lookupenabled ;;
  }

  dimension: maritalstatus {
    type: string
    sql: ${TABLE}.maritalstatus ;;
  }

  dimension: memberactive {
    type: string
    sql: ${TABLE}.memberactive ;;
  }

  dimension: memberaliasname {
    type: string
    sql: ${TABLE}.memberaliasname ;;
  }

  dimension_group: memberbirthdate {
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
    sql: ${TABLE}.memberbirthdate ;;
  }

  dimension_group: membercreateddate {
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
    sql: ${TABLE}.membercreateddate ;;
  }

  dimension: memberfirstname {
    type: string
    sql: ${TABLE}.memberfirstname ;;
  }

  dimension_group: memberfirstpurchasedate {
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
    sql: ${TABLE}.memberfirstpurchasedate ;;
  }

  dimension: membergender {
    type: string
    sql: ${TABLE}.membergender ;;
  }

  dimension: memberkey {
    type: number
    sql: ${TABLE}.memberkey ;;
  }

  dimension: memberlastname {
    type: string
    sql: ${TABLE}.memberlastname ;;
  }

  dimension: memberlevel {
    type: string
    sql: ${TABLE}.memberlevel ;;
  }

  dimension: membermiddlename {
    type: string
    sql: ${TABLE}.membermiddlename ;;
  }

  dimension: membersalutation {
    type: string
    sql: ${TABLE}.membersalutation ;;
  }

  dimension: memberstatus {
    type: string
    sql: ${TABLE}.memberstatus ;;
  }

  dimension: membersuffix {
    type: string
    sql: ${TABLE}.membersuffix ;;
  }

  dimension: membertype {
    type: string
    sql: ${TABLE}.membertype ;;
  }

  dimension_group: memberupdateddate {
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
    sql: ${TABLE}.memberupdateddate ;;
  }

  dimension: mobilenumber {
    type: string
    sql: ${TABLE}.mobilenumber ;;
  }

  dimension: newexternallocationid {
    type: number
    value_format_name: id
    sql: ${TABLE}.newexternallocationid ;;
  }

  dimension: oldexternallocationid {
    type: number
    value_format_name: id
    sql: ${TABLE}.oldexternallocationid ;;
  }

  dimension: operatingcompanycode {
    type: string
    sql: ${TABLE}.operatingcompanycode ;;
  }

  dimension: operatingcompanyname {
    type: string
    sql: ${TABLE}.operatingcompanyname ;;
  }

  dimension: optindate {
    type: string
    sql: ${TABLE}.optindate ;;
  }

  dimension: optindoc {
    type: string
    sql: ${TABLE}.optindoc ;;
  }

  dimension: optinflag {
    type: string
    sql: ${TABLE}.optinflag ;;
  }

  dimension: optinver {
    type: string
    sql: ${TABLE}.optinver ;;
  }

  dimension: pipa {
    type: string
    sql: ${TABLE}.pipa ;;
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.postalcode ;;
  }

  dimension: previouslevel {
    type: string
    sql: ${TABLE}.previouslevel ;;
  }

  dimension: purchasedinenrolledmonth {
    type: string
    sql: ${TABLE}.purchasedinenrolledmonth ;;
  }

  dimension_group: recentmoveupexpirydate {
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
    sql: ${TABLE}.recentmoveupexpirydate ;;
  }

  dimension: regionname {
    type: string
    sql: ${TABLE}.regionname ;;
  }

  dimension: retailcustomerreffboid {
    type: string
    sql: ${TABLE}.retailcustomerreffboid ;;
  }

  dimension: sendemail {
    type: string
    sql: ${TABLE}.sendemail ;;
  }

  dimension: sinnumber {
    type: string
    sql: ${TABLE}.sinnumber ;;
  }

  dimension: socialsecuritynumber {
    type: string
    sql: ${TABLE}.socialsecuritynumber ;;
  }

  dimension_group: sourcedatachangecapturedatetime {
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
    sql: ${TABLE}.sourcedatachangecapturedatetime ;;
  }

  dimension_group: spousedateofbirth {
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
    sql: ${TABLE}.spousedateofbirth ;;
  }

  dimension: spousefirstname {
    type: string
    sql: ${TABLE}.spousefirstname ;;
  }

  dimension: spouselastname {
    type: string
    sql: ${TABLE}.spouselastname ;;
  }

  dimension: spousesocialsecurity {
    type: string
    sql: ${TABLE}.spousesocialsecurity ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: statecode {
    type: string
    sql: ${TABLE}.statecode ;;
  }

  dimension: supresspii {
    type: string
    sql: ${TABLE}.supresspii ;;
  }

  dimension_group: terminationdate {
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
    sql: ${TABLE}.terminationdate ;;
  }

  dimension: unmodified_memberfirstname {
    type: string
    sql: ${TABLE}.unmodified_memberfirstname ;;
  }

  dimension: unmodified_memberlastname {
    type: string
    sql: ${TABLE}.unmodified_memberlastname ;;
  }

  dimension: unmodified_membermiddlename {
    type: string
    sql: ${TABLE}.unmodified_membermiddlename ;;
  }

  dimension_group: updateddate {
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
    sql: ${TABLE}.updateddate ;;
  }

  dimension: usmilitarynumber {
    type: string
    sql: ${TABLE}.usmilitarynumber ;;
  }



  dimension_group: validto {
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
    sql: ${TABLE}.validto ;;
  }

  dimension: vatregistered {
    type: string
    sql: ${TABLE}.vatregistered ;;
  }

  dimension: wholesalequalified {
    type: string
    sql: ${TABLE}.wholesalequalified ;;
  }

  dimension: workinglevel {
    type: string
    sql: ${TABLE}.workinglevel ;;
  }

  dimension: workphone {
    type: string
    sql: ${TABLE}.workphone ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      memberfirstname,
      memberlastname,
      membermiddlename,
      memberaliasname,
      operatingcompanyname,
      spousefirstname,
      spouselastname,
      imagefilename,
      regionname,
      unmodified_memberfirstname,
      unmodified_memberlastname,
      unmodified_membermiddlename
    ]
  }
}
