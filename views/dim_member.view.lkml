view: dim_member {
  sql_table_name: uat_tbe.dim_member ;;

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

  dimension: fbo_id_new {
    description: "FBO ID (000 000000000)"
    type: string
    label: "FBO ID"
    group_label: "Primary Data"
    sql: SUBSTRING(${TABLE}.distributorid, 1,3) + ' ' + SUBSTRING(${TABLE}.distributorid, 4,9)
      ;;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: fbo_id_grc {
    description: "FBO ID (000 000-000-000)"
    label: "FBO ID"
    type: string
    sql: SUBSTRING(${TABLE}.distributorid , 1,3) + ' ' + SUBSTRING(${TABLE}.distributorid , 4,3)
      + '-' + SUBSTRING(${TABLE}.distributorid , 7,3) + '-' + SUBSTRING(${TABLE}.distributorid , 10,3);;
    html:  <a href="https://foreverliving.looker.com/dashboards/3502?Distributor%20Id= {{value|replace:"-",""|replace:" ",""}}" target="_blank"><font color="blue" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a> ;;
  }

  dimension: active {
    hidden: yes
    type: string
    sql: ${TABLE}.active ;;
  }

  dimension: address_1 {
    description: "This field shows member address 1"
    group_label: "Contact Info"
    type: string
    sql: initcap(${TABLE}.addressline1) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: address_2 {
    description: "This field shows member address 2"
    group_label: "Contact Info"
    type: string
    sql: initcap(${TABLE}.addressline2) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }


  dimension: address_3 {
    description: "This field shows member address 3"
    label: "Address 3"
    group_label: "Contact Info"
    type: string
    sql: initcap(${TABLE}.addressline3) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: address_4 {
    description: "This field shows member address 4"
    group_label: "Contact Info"
    type: string
    sql: initcap(${TABLE}.addressline4) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_address_1 {
    description: "This field shows the address 1 of retail customer."
    label: "Address 1"
    type: string
    sql: initcap(${TABLE}.addressline1) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_address_2 {
    description: "This field shows the address 2 of retail customer."
    label: "Address 2"
    type: string
    sql: initcap(${TABLE}.addressline2) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }


  dimension: retail_address_3 {
    description: "This field shows the address 3 of retail customer."
    label: "Address 3"
    type: string
    sql: initcap(${TABLE}.addressline3) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_address_4 {
    description: "This field shows the address 4 of retail customer."
    label: "Address 4"
    type: string
    sql: initcap(${TABLE}.addressline4) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_fbo_id {
    description: "Retail FBO ID formatted with dashes"
    type: string
    label: "FBO ID"
    sql: SUBSTRING(${TABLE}.distributorid, 1,3) + '-' + SUBSTRING(${TABLE}.distributorid, 4,3)
          + '-' + SUBSTRING(${TABLE}.distributorid, 7,3) + '-' + SUBSTRING(${TABLE}.distributorid, 10,3)
          ;;
  }

  dimension: retail_email {
    description: "This field shows email address of Retail Customer"
    type: string
    label: "Email"
    sql: ${TABLE}.emailaddress ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: address1_2 {
    hidden: yes
    type: string
    label: "Address 1-2"
    sql: CONCAT(CONCAT(${address_1},','), ${address_2}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: address3_4 {
    hidden: yes
    type: string
    view_label: "Address 3-4"
    label: "Address 3-4"
    sql: CONCAT(CONCAT(${address_3},','), ${address_4});;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: phone_1 {
    description: "This field shows phone 1 of member"
    group_label: "Contact Info"
    type: string
    sql: ${TABLE}.alternatephone1 ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: phone_2 {
    description: "This field shows phone 2 of member"
    group_label: "Contact Info"
    type: string
    sql: ${TABLE}.alternatephone2 ;;
  }

  dimension: phone_3 {
    hidden: yes
    label: "Phone 3"
    type: string
    sql: ${TABLE}.alternatephone3 ;;
  }

  dimension: phone1_3 {
    hidden: yes
    type: string
    view_label: "Phone 1-3"
    label: "Phone 1-3"
    sql:  CONCAT(CONCAT(CONCAT(CONCAT(trim(${phone_1}),' : '), trim(${phone_2})),' : '),${phone_3});;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: area {
    description: "This field shows the area code of member"
    group_label: "Info"
    suggest_explore: member_details
    suggest_dimension: dim_member.area_suggestion
    type: string
    sql: ${TABLE}.areacode ;;
  }

  dimension: area_suggestion {
    hidden: yes
    type: string
    sql: ${TABLE}.areacode ;;
  }

  dimension_group: assistantsupervisordate {
    hidden: yes
    label: "Assistant Supervisor"
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

  dimension: assistant_supervisor_processing_period{
    label: "Assistant Supervisor processing period"
    sql: ${assistantsupervisordate_date} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%m-%Y" }}</font> ;;
  }

  dimension: assistantsupervisorinsamemonth {
    description: "This field shows if the member has become assistant supervisor in same month."
    label: "Acheive AS At Enrolled"
    group_label: "Info"
    type: string
    case_sensitive: no
    sql: CASE WHEN ${TABLE}.assistantsupervisorinsamemonth = 1 THEN 'Yes'
         ELSE 'No'
         END ;;
  }

  dimension: autoshipenabled {
    hidden: yes
    type: string
    sql: ${TABLE}.autoshipenabled ;;
  }

  dimension: bindingid {
    hidden: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.bindingid ;;
  }

  dimension: city {
    description: "This field shows city of member"
    type: string
    group_label: "Contact Info"
    suggest_explore: member_details
    suggest_dimension: dim_member.city_suggestion
    sql: initcap(${TABLE}.city) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: city_suggestion {
    type: string
    hidden: yes
    sql: initcap(${TABLE}.city) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_city {
    description: "This field shows the city of retail customer."
    label: "City"
    suggest_explore: member_details
    suggest_dimension: dim_member.city_suggestion
    sql: initcap(${TABLE}.city) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: closetomoveup {
    hidden: no
    type: string
    case_sensitive: no
    sql: initcap(${TABLE}.closetomoveup) ;;
  }
#
#   dimension: country {
#     description: "This field shows country of member."
#     group_label: "Contact Info"
#     type: string
#     map_layer_name: countries
#     suggest_explore: member_details
#     suggest_dimension: dim_member.country_suggestion
#     sql: ${TABLE}.country ;;
#     html: <font style="white-space: nowrap;">{{ value  }}</font>;;
#   }

  dimension: country_suggestion {
    type: string
    map_layer_name: countries
    hidden: yes
    sql: ${TABLE}.country ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_country {
    description: "This field shows the country of retail customer."
    label: "Country"
    type: string
    map_layer_name: countries
    suggest_explore: member_details
    suggest_dimension: dim_member.country_suggestion
    sql: ${TABLE}.country ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: county {
    hidden: yes
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension_group: created {
    description: "This field shows the date of member created."
    type: time
    group_label: "Info"
    timeframes: [
      date
    ]
    sql: ${TABLE}.createddate ;;
  }

  dimension_group: retail_created {
    label: "Created"
    description: "This field shows the date of the retail customer created."
    type: time
    group_label: "Info"
    timeframes: [
      date
    ]
    sql: ${TABLE}.createddate ;;
  }

  dimension: datapipelinestatus {
    hidden: yes
    type: string
    sql: ${TABLE}.datapipelinestatus ;;
  }

  dimension: datasource {
    hidden: yes
    type: string
    sql: ${TABLE}.datasource ;;
  }

  dimension: displayphoneinsearch {
    hidden: yes
    type: string
    sql: ${TABLE}.displayphoneinsearch ;;
  }

  dimension: distributorid {
    description: "This field shows distributor's id."
    label: "Distributor ID"
    group_label: "Primary Data"
    type: string
    sql: ${TABLE}.distributorid ;;
  }

  dimension_group: first_downline_date {
    description: "This field shows the First Downline Date of the Member."
    label: "First Downline"
    group_label: "Info"
    convert_tz: no
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.downlinememberfirstjoindate ;;
  }

  dimension_group: downline_member_join {
    hidden: no
    type: time
    convert_tz: no
    view_label: " "
    label: "First Downline Sponsor"
    sql: ${TABLE}.downlinememberfirstjoindate ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension: drivinglicensenumber {
    hidden: yes
    type: string
    sql: ${TABLE}.drivinglicensenumber ;;
  }

  dimension: eirnumber {
    hidden: yes
    type: string
    sql: ${TABLE}.eirnumber ;;
  }

  dimension: email {
    description: "This field shows email address of member."
    label: "Email"
    group_label: "Contact Info"
    type: string
    sql: ${TABLE}.emailaddress ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: enrollmenttype {
    hidden: yes
    type: string
    sql: ${TABLE}.enrollmenttype ;;
  }

  dimension: enrolled {
    convert_tz: no
    type: date
    view_label: ""
    label: "Enrolled Date"
    group_label: "Enrolled Date"
    sql: ${enrolled_date_date} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension: terminationdate {
    type: date
    view_label: ""
    label: "Termination Date"
    group_label: "Termination Date"
    sql: ${termination_date_date} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension_group: termination_date {
    convert_tz: no
    type: time
    group_label: "Termination Date"
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

  dimension_group: enrolled_date {
    convert_tz: no
    type: time
    group_label: "Enrolled Date"
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

  dimension: Enrolled_period {
    group_label: "Primary Data"
    type: string
    sql: concat(concat(lpad(EXTRACT(MONTH FROM ${enrolled_date_date}),2,0),'-'),EXTRACT(YEAR FROM ${enrolled_date_date}));;
  }

  dimension: enrolled_year {
    description: "This field shows the Enrolled Year of the Member."
    group_label: "Primary Data"
    type: number
    sql: extract(year from ${enrolled_date_date}) ;;
  }

  dimension: enrolled_month {
    description: "This field shows the Enrolled Month of the Member."
    group_label: "Primary Data"
    type: number
    sql: extract(month from ${enrolled_date_date}) ;;
  }

  dimension: externalsequencenumber {
    hidden: yes
    type: number
    sql: ${TABLE}.externalsequencenumber ;;
  }

  dimension: firstpurchasemonth {
    hidden: yes
    description: "This field shows the First Purchase Month"
    label: "First Purchase Month"
    type: number
    sql: ${TABLE}.firstpurchasemonth ;;
  }

  dimension: firstpurchaseyear {
    #hidden: yes
    description: "This field shows the First Purchase Year"
    group_label: "Primary Data"
    type: number
    label: "First Purchase Year"
    sql: ${TABLE}.firstpurchaseyear ;;
  }

  dimension: first_purchase {
    hidden: yes
    convert_tz: no
    type: date
    label: "First Purchase"
    group_label: "Primary Data"
    sql: CASE WHEN ${firstpurchaseyear} != 0 AND ${firstpurchasemonth} != 0
      THEN ${firstpurchaseyear} || '-' || ${firstpurchasemonth} || '-01' ELSE NULL END;;
  }

  dimension_group: purchase {
    label: "First Purchase"
    group_label: "Primary Data"
    convert_tz: no
    type: time
    timeframes: [
      date,
      month
    ]
    sql: ${TABLE}.memberfirstpurchasedate ;;
  }

  dimension: hasdownline {
    hidden: yes
    type: string
    sql: ${TABLE}.hasdownline ;;
  }

  dimension: home_country {
    hidden:no
    description: "This field shows the home country of the member."
    label: "Member Home Country"
    case_sensitive: no
    group_label: "Info"
    type: string
    sql: ${TABLE}.homecompanycode ;;
  }

  dimension: homephone {
    hidden: yes
    type: string
    sql: ${TABLE}.homephone ;;
  }

  dimension: isdelete {
    hidden: yes
    type: string
    sql: ${TABLE}.isdelete ;;
  }

  dimension: itinnumber {
    hidden: yes
    type: string
    sql: ${TABLE}.itinnumber ;;
  }

  dimension: languagepreference {
    hidden: yes
    type: string
    sql: ${TABLE}.languagepreference ;;
  }

  dimension_group: last_move_up_period {
    hidden: no
    label: "Last Move-up"
    type: time
    convert_tz: no
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
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension: last_move_up_processing_period{
    description: "This field shows last move up processing period of member."
    label: "Last Move-up Processing Period"
    group_label: "Info"
    sql: ${last_move_up_period_date} ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%m-%Y" }}</font> ;;
  }

  dimension: lookupenabled {
    hidden: yes
    type: string
    sql: ${TABLE}.lookupenabled ;;
  }

  dimension: maritalstatus {
    hidden: yes
    type: string
    sql: ${TABLE}.maritalstatus ;;
  }

  dimension: memberactive {
    type: string
    sql: ${TABLE}.memberactive ;;
  }

  dimension: memberaliasname {
    hidden: yes
    type: string
    sql: ${TABLE}.memberaliasname ;;
  }

  dimension_group: memberbirthdate {
    hidden: no
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

  dimension_group: memberbirthdate_format1 {
    label: "Member BirthDate Format 1"
    description: "Member Birthdate in the format of DD/MM/YYYY"
    group_label: "Contact Info"
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.memberbirthdate ;;
    html:
    <font style="white-space: nowrap;">{{ rendered_value | date: "%d/%m/%Y" }}</font>
    ;;
  }
  dimension_group: memberbirthdate_format2 {
    label: "Member BirthDate Format 2"
    description: "Member Birthdate in the format of MM/DD/YYYY"
    group_label: "Contact Info"
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.memberbirthdate ;;
    html:
    <font style="white-space: nowrap;">{{ rendered_value | date: "%m/%d/%Y" }}</font>
    ;;
  }
  dimension_group: memberbirthdate_format3 {
    label: "Member BirthDate Format 3"
    description: "Member Birthdate in the format of DD-MMM-YYYY like 01-Aug-2019"
    group_label: "Contact Info"
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.memberbirthdate ;;
    html:
    <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>
    ;;
  }
  dimension_group: created_date {
    group_label: "Info"
    label: "Created"
    type: time
    timeframes: [
      date
    ]
    sql: ${TABLE}.membercreateddate ;;
  }

  dimension: firstname {
    type: string
    label: "First Name"
    group_label: "Primary Data"
    sql: initcap(${TABLE}.memberfirstname) ;;
    html: <font style="white-space: nowrap;">{{ value }} </font>;;
  }

  dimension: first {
    type: string
    description: "This field shows member first name"
    group_label: "Primary Data"
    sql: initcap(${TABLE}.memberfirstname) ;;
    html: <font style="white-space: nowrap;">{{ value }} </font>;;
  }

  dimension_group: memberfirstpurchasedate {
    hidden: yes
    label: "1st Order"
    convert_tz: no
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
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font> ;;
  }

  dimension: membergender {
    hidden: yes
    type: string
    sql: ${TABLE}.membergender ;;
  }

  dimension: memberkey {
    hidden: yes
    type: number
    sql: ${TABLE}.memberkey ;;
  }

  dimension: last {
    type: string
    description: "This field shows member last name"
    group_label: "Primary Data"
    sql: initcap(${TABLE}.memberlastname) ;;
  }

  dimension: level {
    label: "Member Level"
    description: "This field shows current level of the member"
    case_sensitive: no
    type: string
    group_label: "Info"
    sql: ${TABLE}.memberlevel ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: middle {
    type: string
    description: "This field shows member middle name"
    group_label: "Primary Data"
    sql: initcap(${TABLE}.membermiddlename) ;;
  }

  dimension: fbo_name_first_last {
    description: "FBO Name(First Last)"
    type: string
    view_label: ""
    label: "Name"
    sql: CONCAT(CONCAT(${first}, ' '), ${last}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: membersalutation {
    hidden: yes
    type: string
    sql: ${TABLE}.membersalutation ;;
  }

  dimension: fbo_status {
    description: "This field shows member current status"
    type: string
    label: "FBO Status"
    group_label: "Primary Data"
    case_sensitive: no
    sql: ${TABLE}.memberstatus ;;
  }

  dimension: membersuffix {
    hidden: yes
    type: string
    sql: ${TABLE}.membersuffix ;;
  }

  dimension: member_type {
    description: "It shows if the member is of type Distributor or Retail Customer."
    type: string
    label: "Member Type"
    group_label: "Primary Data"
    sql: ${TABLE}.membertype ;;
  }

  dimension: retail_member_type {
    type: string
    case_sensitive: no
    label: "Retail Member Type"
    sql:case when  ${TABLE}.membertype = 'Retail Customer'
              then 'Registered'
            when  ${TABLE}.membertype = 'Guest'
              then 'Guest'
            when ${TABLE}.membertype = 'Distributor'
             then 'Distributor'
        end;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension_group: memberupdateddate {
    hidden: yes
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
    hidden: yes
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

  dimension: operatingcompanyname {
    type: string
    sql: ${TABLE}.operatingcompanyname ;;
  }

  dimension: region {
    label : "Member Region"
    case_sensitive: no
    type: string
    sql: ${TABLE}.regionname ;;
  }

  dimension: optindate {
    hidden: no
    type: string
    sql: ${TABLE}.optindate ;;
  }

  dimension: optindoc {
    hidden: yes
    type: string
    sql: ${TABLE}.optindoc ;;
  }

  dimension: optinflag {
    hidden: no
    type: string
    sql: ${TABLE}.optinflag ;;
  }

  dimension: optinver {
    hidden: yes
    type: string
    sql: ${TABLE}.optinver ;;
  }

  dimension: pipa {
    hidden: yes
    type: string
    sql: ${TABLE}.pipa ;;
  }

  dimension: postal_code {
    description: "This field shows postal code."
    group_label: "Contact Info"
    suggest_explore: member_details
    suggest_dimension: dim_member.postal_code_suggestion
    type: string
    sql: ${TABLE}.postalcode ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: postal_code_suggestion {
    hidden: yes
    type: string
    sql: ${TABLE}.postalcode ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: retail_postal_code {
    description: "This field shows the postal code of retail customer"
    label: "Postal Code"
    suggest_explore: member_details
    suggest_dimension: dim_member.postal_code_suggestion
    type: string
    sql: ${TABLE}.postalcode ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font>;;
  }

  dimension: previous_level {
    description: "It shows the previous level of member"
    group_label: "Info"
    type: string
    sql: ${TABLE}.previouslevel ;;
  }

  dimension: joining_level {
    description: "It shows the joining level of member"
    type: string
    group_label: "Info"
    sql: 'Novus Customer' ;;
  }

  dimension_group: recentmoveupexpirydate {
    hidden: yes
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

  dimension: retailcustomerreffboid {
    hidden: no
    type: string
    sql: ${TABLE}.retailcustomerreffboid ;;
  }

  dimension: send_email {
    group_label: "Primary Data"
    type: yesno
    sql: ${TABLE}.sendemail = 'Y' ;;
  }

  dimension: sendemail {
    type: string
    sql: ${TABLE}.sendemail ;;
  }

  dimension: sinnumber {
    hidden: yes
    type: string
    sql: ${TABLE}.sinnumber ;;
  }

  dimension: socialsecuritynumber {
    hidden: yes
    type: string
    sql: ${TABLE}.socialsecuritynumber ;;
  }

  dimension_group: spousedateofbirth {
    hidden: yes
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

  dimension: spouse_first {
    description: "This field shows spouse first name"
    type: string
    group_label: "Primary Data"
    sql: ${TABLE}.spousefirstname ;;
  }

  dimension: spousefirstnameold {
    hidden: no
    type: string
    sql: ${TABLE}.spousefirstnameold ;;
  }

  dimension: spouse_last {
    description: "This field shows spouse last name"
    type: string
    group_label: "Primary Data"
    sql: ${TABLE}.spouselastname ;;
  }

  dimension: spouselastnameold {
    hidden: yes
    type: string
    sql: ${TABLE}.spouselastnameold ;;
  }

  dimension: spousesocialsecurity {
    hidden: yes
    type: string
    sql: ${TABLE}.spousesocialsecurity ;;
  }

  dimension: state {
    description: "This field shows the state"
    label: "State"
    group_label: "Contact Info"
    suggest_explore: member_details
    suggest_dimension: dim_member.state_suggestion
    type: string
    sql: ${TABLE}.state ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: state_suggestion {
    hidden: yes
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: retail_state {
    description: "This field shows the state of retail customer."
    label: "State"
    suggest_explore: member_details
    suggest_dimension: dim_member.state_suggestion
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: supresspii {
    hidden: yes
    type: string
    sql: ${TABLE}.supresspii ;;
  }

  dimension_group: updateddate {
    hidden: yes
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
    hidden: yes
    type: string
    sql: ${TABLE}.usmilitarynumber ;;
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

  dimension_group: validto {
    hidden: yes
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

  dimension: wholesalequalified {
    hidden: yes
    type: string
    sql: ${TABLE}.wholesalequalified ;;
  }

  dimension: workphone {
    hidden: yes
    type: string
    sql: ${TABLE}.workphone ;;
  }

  dimension: name {
    description: "FBOs Name(LastName, FirstName MiddleName)"
    type: string
    group_label: "Primary Data"
    label: "Name"
    sql: CONCAT(CONCAT(CONCAT(CONCAT(${last}, ', '), ${first}), ' '), ${middle}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: retail_name {
    description: "This field shows the Retail customer name."
    type: string
    label: "Name"
    sql: CONCAT(CONCAT(CONCAT(CONCAT(${last}, ', '), ${first}), ' '), ${middle}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: sponsor_name {
    description: "Sponsor Name(LastName, FirstName MiddleName)"
    type: string
    group_label: "Primary Data"
    label: "Sponsor Name"
    sql: CONCAT(CONCAT(CONCAT(CONCAT(${last}, ', '), ${first}), ' '), ${middle}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: sponsor_name_first_last {
    description: "Sponsor Name(First Last)"
    type: string
    view_label: ""
    label: "Sponsor Name"
    sql: CONCAT(CONCAT(${first}, ' '), ${last}) ;;
    html: <font style="white-space: nowrap;">{{ value  }}</font> ;;
  }

  dimension: purchasedinenrolledmonth {
    description: "This fiels shows Member purchased in enrolled month or not."
    type: string
    label: "Purchased in Enrollment Month"
    group_label: "Info"
    sql: Case when ${TABLE}.purchasedinenrolledmonth='true'
              then 'Yes'
              else 'No'
          end;;
  }

  parameter: parameter_distributorid {
    hidden: yes
    type: number
  }

  parameter: parameter_opco {
    type: string
  }


#
#   measure: count {
#     hidden: yes
#     type: count
#     drill_fields: [detail*]
#   }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: fbo_count {
    label : "Count of FBOs"
    description: "This field shows the count of FBOs"
    type: count_distinct
    sql: ${distributorid} ;;
    drill_fields: [detail*]
  }

  parameter: parameter_period {
    type: string
    suggest_explore: monthly_cc
    suggest_dimension: dim_monthlycc.period
  }

  parameter: parameter_period_upto_last_month {
    type: string
    suggest_explore: period_suggestion_upto_lastmont
    suggest_dimension: dim_monthlycc.period
  }

  dimension: last_period_enrolled {
    type: date
    convert_tz: no
    sql: dateadd(month,-1,to_date('01-' || {% parameter parameter_period_upto_last_month %} , 'DD-MM-YYYY'));;
  }

  dimension: selected_previous_period {
    type: string
    sql:  concat(concat(lpad(EXTRACT(MONTH FROM ${last_period_enrolled}),2,0),'-'),EXTRACT(YEAR FROM  ${last_period_enrolled}))  ;;
  }

  dimension: selected_period {
    type: string
    sql: {% parameter parameter_period_upto_last_month %}  ;;
  }

  measure: fbo_details {
    hidden: yes
    type: count_distinct
    sql: ${distributorid} ;;
    label: " "
    html:
    <div style="background-color: #73AB50;" class="row" >
      <br>
      <div class="col-sm-12" style="font-size: 40px">
       {% if parameter_opco._parameter_value.size > 2 %}
        <div style="font-weight:bold;">
        <a href="https://foreverliving.looker.com/dashboards/1120?FBO%20ID={{parameter_distributorid._parameter_value}}&OpCO={{parameter_opco._parameter_value }}"><font color="white" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a>
        </div>
        {% else %}
        <a href="https://foreverliving.looker.com/dashboards/1120?FBO%20ID={{parameter_distributorid._parameter_value}}"><font color="white" style="white-space: nowrap;"> <u> {{ value  }} </u> </font></a>
       {% endif %}
      </div>
    </div>
    <div style="background-color: #73AB50;" class="row" >
      <h2><span style="font-weight:bold;">Recruitment</span></h2>
      <h4><span style="font-weight:bold;white-space: nowrap;">Number of personally enrolled with purchase</span></h4>
      <br>
    </div>
       ;;
  }

  dimension_group: enrollment_date {
    label: "Enrolment"
    timeframes: [date]
    type: time
    sql: ${TABLE}.enrolmentdate ;;
    html: <font style="white-space: nowrap;">{{ rendered_value | date: "%d-%b-%Y" }}</font>;;
  }

  dimension: allowsponsortocontact {
    description: "This field shows Allow Sponsor to Contact"
    label: "Contact (Y/N)"
    type: string
    sql: ${TABLE}.allowsponsortocontact ;;
  }


  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      first,
      last,
      middle,
      spouse_first,
      spouse_last,
      name,
      distributorid,
      fbo_id,
      fbo_count,
      name,
      member_type,
      enrolled_date_date,
      termination_date_date,
      fbo_status,
      address_1,
      address_2,
      address_3,
      city,
      state,
      postal_code,
      country,
      email,
      memberbirthdate_format1_date,
      memberbirthdate_format2_date,
      memberbirthdate_format3_date,
      phone_1,
      phone_2,
      joining_level,
      previous_level,
      level,
      assistantsupervisorinsamemonth,
      area,
      vat,
      last_move_up_processing_period,
      validfrom_date,
      created_date,
      first_downline_date_date,
      purchasedinenrolledmonth,
      enrolled_date_month,
      purchase_date,
      purchase_month,
      enrolled_year,
      send_email,
      fbo_name_first_last,
      Enrolled_period,
      enrolled_month,
      parameter_period,
      fbo_id_new,
      allowsponsortocontact
    ]
  }

  dimension: sponsor_level {
    description: "This field shows Sponsor Level."
    label: "Sponsor Level"
    type: string
    sql: ${level} ;;
  }

  dimension: operatingcompanycode {
    description: "Stores operating country code"
    type: string
    view_label: ""
    label: "Op Code"
    sql: ${TABLE}.operatingcompanycode ;;
  }

  set: sponsor_name {
    fields: [
      sponsor_name,
      sponsor_name_first_last,
      sponsor_level
    ]
  }

  set: retail_customer {
    fields: [
      retail_address_1,
      retail_address_2,
      retail_address_3,
      retail_address_4,
      retail_city,
      retail_state,
      retail_country,
      retail_created_date,
      retail_postal_code,
      retail_name,
      retail_email,
      retail_fbo_id
]
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

  dimension: emailaddress {
    type: string
    sql: ${TABLE}.emailaddress ;;
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

  dimension: hasglobaldownline {
    type: string
    sql: ${TABLE}.hasglobaldownline ;;
  }

  dimension: homecompanycode {
    type: string
    sql: ${TABLE}.homecompanycode ;;
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


  dimension: memberstatus {
    type: string
    sql: ${TABLE}.memberstatus ;;
  }


  dimension: membertype {
    type: string
    sql: ${TABLE}.membertype ;;
  }


  dimension: postalcode {
    type: string
    sql: ${TABLE}.postalcode ;;
  }

  dimension: previouslevel {
    type: string
    sql: ${TABLE}.previouslevel ;;
  }


  dimension: regionname {
    type: string
    sql: ${TABLE}.regionname ;;
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

  dimension: spousefirstname {
    type: string
    sql: ${TABLE}.spousefirstname ;;
  }

  dimension: spouselastname {
    type: string
    sql: ${TABLE}.spouselastname ;;
  }


  dimension: statecode {
    type: string
    sql: ${TABLE}.statecode ;;
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


  dimension: vatregistered {
    type: string
    sql: ${TABLE}.vatregistered ;;
  }

}
