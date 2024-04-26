view: inventory_by_day_simple {
  sql_table_name: `ant-billet-looker-core-argolis.sample_data.inventory_by_day_simple` ;;

  dimension_group: day {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Day ;;
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}.Quantity ;;
  }
  dimension: sku_ {
    type: number
    sql: ${TABLE}.SKU_ ;;
  }
  dimension: store {
    type: string
    sql: ${TABLE}.Store ;;
  }

  measure: sum_quantity {
    type: sum
    sql: ${quantity} ;;
  }

  dimension: is_opening_date {
    view_label: "Z) Helper dims"
    type: yesno
    sql: ${day_date} = DATE_TRUNC(${day_date}, MONTH) ;;
  }

  dimension: is_closing_date {
    view_label: "Z) Helper dims"
    type: yesno
    sql: ${day_date} = DATE_SUB(DATE_ADD(DATE_TRUNC(${day_date}, MONTH),INTERVAL 1 MONTH), INTERVAL 1 DAY) ;;
  }

  measure: sum_opening_quantity {
    type: sum
    # can write with SQL if you want
    sql: CASE WHEN ${is_opening_date} THEN ${quantity} ELSE NULL END ;;
    # Or with Looker's filter object, they both do the same thing
    # sql: ${quantity} ;;
    # filters: [is_opening_date: "Yes"]
  }

  measure: sum_closing_quantity {
    type: sum
    # can write with SQL if you want
    # sql: CASE WHEN ${is_closing_date} THEN ${quantity} ELSE NULL END ;;
    # Or with Looker's filter object, they both do the same thing
    sql: ${quantity} ;;
    filters: [is_closing_date: "Yes"]
  }
}
