%dw 2.0
output application/json
---
(payload filter ((item, index) -> 
    vars.messageIds contains item."id"
)) map ((item, index) -> 
    item filterObject ((value, key, index) -> 
        ["id", "receiptHandle"] contains ((key) as String)
    )
)