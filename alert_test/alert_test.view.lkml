view: alert_test {
  derived_table: {
    sql: SELECT 1 as number

      UNION ALL

      SELECT 2 as number ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    tags: ["first name", "fn"]
  }

  dimension: number {
    type: number
    sql: ${TABLE}.number ;;
  }

  measure: sum {
    type: sum
    sql: ${number} ;;
  }

  set: detail {
    fields: [
      number
    ]
  }
}
