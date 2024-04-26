include: "/inventory_by_day/inventory_by_day_simple.view.lkml"

view: inventory_by_day {

  extends: [inventory_by_day_simple]
  #copies all my objects from my other view file ,but allows me to overwrite or add onto them

  sql_table_name: `ant-billet-looker-core-argolis.sample_data.inventory_by_day` ;;

  # here are our old helper dimensions for visibility
  # dimension: is_opening_date {
  #   view_label: "Z) Helper dims"
  #   # hidden: yes
  #   type: yesno
  #   sql: ${day_date} = DATE_TRUNC(${day_date}, MONTH) ;;
  # }

  # dimension: is_closing_date {
  #   view_label: "Z) Helper dims"
  #   # hidden:  yes
  #   type: yesno
  #   sql: ${day_date} = DATE_SUB(DATE_ADD(DATE_TRUNC(${day_date}, MONTH),INTERVAL 1 MONTH), INTERVAL 1 DAY) ;;
  # }

  #lets overwrite them and make them dynamic to what we are querying

  dimension: is_opening_date {
    sql: {% if inventory_by_day.day_date._is_selected %}
            ${day_date} = ${day_date}
         {% elsif inventory_by_day.day_month._is_selected %}
            ${day_date} = DATE_TRUNC(${day_date}, MONTH)
         {% elsif inventory_by_day.day_quarter._is_selected %}
            ${day_date} = DATE_TRUNC(${day_date}, QUARTER)
         {% else %}
            ${day_date} = CURRENT_DATE()
         {% endif %};;
  }

   dimension: is_closing_date {
    sql: {% if inventory_by_day.day_date._is_selected %}
            ${day_date} = ${day_date}
         {% elsif inventory_by_day.day_month._is_selected %}
            ${day_date} = DATE_SUB(DATE_ADD(DATE_TRUNC(${day_date}, MONTH),INTERVAL 1 MONTH), INTERVAL 1 DAY)
         {% elsif inventory_by_day.day_quarter._is_selected %}
            ${day_date} = DATE_SUB(DATE_ADD(DATE_TRUNC(${day_date}, QUARTER),INTERVAL 1 QUARTER), INTERVAL 1 DAY)
         {% else %}
            ${day_date} = CURRENT_DATE()
         {% endif %} ;;
  }



}
