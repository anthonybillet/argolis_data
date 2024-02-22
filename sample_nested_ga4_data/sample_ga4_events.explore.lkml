include: "/sample_nested_ga4_data/sample_ga4_events_20231201.view.lkml"

explore: sample_ga4_events_20231201 {
  join: sample_ga4_events_20231201__hits {
    view_label: "Sample Ga4 Events 20231201: Hits"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201.hits}) as sample_ga4_events_20231201__hits ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__product {
    view_label: "Sample Ga4 Events 20231201: Hits Product"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.product}) as sample_ga4_events_20231201__hits__product ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__promotion {
    view_label: "Sample Ga4 Events 20231201: Hits Promotion"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.promotion}) as sample_ga4_events_20231201__hits__promotion ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__custom_metrics {
    view_label: "Sample Ga4 Events 20231201: Hits Custommetrics"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.custom_metrics}) as sample_ga4_events_20231201__hits__custom_metrics ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__custom_variables {
    view_label: "Sample Ga4 Events 20231201: Hits Customvariables"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.custom_variables}) as sample_ga4_events_20231201__hits__custom_variables ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__custom_dimensions {
    view_label: "Sample Ga4 Events 20231201: Hits Customdimensions"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.custom_dimensions}) as sample_ga4_events_20231201__hits__custom_dimensions ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__experiment {
    view_label: "Sample Ga4 Events 20231201: Hits Experiment"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.experiment}) as sample_ga4_events_20231201__hits__experiment ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__publisher_infos {
    view_label: "Sample Ga4 Events 20231201: Hits Publisher Infos"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits.publisher_infos}) as sample_ga4_events_20231201__hits__publisher_infos ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__product__custom_metrics {
    view_label: "Sample Ga4 Events 20231201: Hits Product Custommetrics"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits__product.custom_metrics}) as sample_ga4_events_20231201__hits__product__custom_metrics ;;
    relationship: one_to_many
  }
  join: sample_ga4_events_20231201__hits__product__custom_dimensions {
    view_label: "Sample Ga4 Events 20231201: Hits Product Customdimensions"
    sql: LEFT JOIN UNNEST(${sample_ga4_events_20231201__hits__product.custom_dimensions}) as sample_ga4_events_20231201__hits__product__custom_dimensions ;;
    relationship: one_to_many
  }
}
