%dw 2.0
output application/json
---
payload."payload" filter ((item, index) -> item.name contains "-dlq")