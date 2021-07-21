connection: "titanbonusenginestage"

# include all the views
include: "/views/**/*.view"

datagroup: titandatamart_tbe_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: titandatamart_tbe_default_datagroup

explore: downlinememberdetails {}

explore: fact_cb600ccindownline {}

explore: fact_cb600cclines {}

explore: fact_cbindownline {}

explore: fact_cblines {}

explore: fact_cbmgrsindownline {}

explore: fact_cbqualification {}

explore: fact_distributordownlinecount_aggregation {}

explore: fact_distributordownlinecount_aggregation_global {}

explore: fact_downlinetreebydistributors {}

explore: fact_emindownline {}

explore: fact_emlines {}

explore: fact_emmgrsindownline {}

explore: fact_emnewsupervisors {}

explore: fact_emqualification {}

explore: fact_emyearlycc {}

explore: fact_globalrallyrewards {}

explore: fact_grqualification {}

explore: fact_levelhistory {}

explore: fact_memberstats_aggregation {}

explore: fact_memberstats_aggregation_global {}

explore: fact_moveupsbygenerationandlevel {}

explore: fact_treehistory {}

explore: generationdetails {}

explore: generationdetails_global {}

explore: stage_factdownlinecount_roguedata {}

explore: stage_memberstats_roguedata {}

explore: member {
  view_name: dim_member

  label: "FBO Details"
  sql_always_where:  $(dim_memebr.membertype) = 'Distributor';;
  access_filter: {
    field: dim_member.opco
    user_attribute: operatingcountry
  }
}
