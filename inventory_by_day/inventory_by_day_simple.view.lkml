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
  dimension: sku {
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
    # hidden: yes
    type: yesno
    sql: ${day_date} = DATE_TRUNC(${day_date}, MONTH) ;;
  }

  dimension: is_closing_date {
    view_label: "Z) Helper dims"
    # hidden:  yes
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







  #Lets make it dynamic

  # create a choice for the user to interact with - we call this a parameter
  parameter: opening_closing_choice {
    view_label: "Z) Dynamic Measures"
    label: "Opening/Closing?"
    description: "Use with Dynamic Sum Quantity to choose how to sum inventory - by closing or opening value"
    type: unquoted
    allowed_value: {
      value: "Opening"
    }
    allowed_value: {
      value: "Closing"
    }
  }

  measure: dynamic_sum_quantity  {
    view_label: "Z) Dynamic Measures"
    description: "Use with Opening/Closing? Field to choose how to sum inventory - by closing or opening value"
    type: sum
    sql: CASE WHEN
                  {% if opening_closing_choice._parameter_value == "Opening" %}
                        ${is_opening_date}
                  {% elsif opening_closing_choice._parameter_value == "Closing" %}
                        ${is_closing_date}
                  {% else %}
                        ${is_opening_date}
                  {% endif %}
                  THEN ${quantity} ELSE NULL END;;
    # we can even label by parameter
    label: "Dynamic Sum {% parameter opening_closing_choice %} Quantity"

    link: {
      label: "See by SKU"
      url: "{{link}}&fields=inventory_by_day.sku,inventory_by_day.dynamic_sum_quantity"
    }

    link: {
      label: "See by Store"
      url: "{{link}}&fields=inventory_by_day.store,inventory_by_day.dynamic_sum_quantity"
    }
  }

  drill_fields: [day_date,sku, store, quantity]

}
