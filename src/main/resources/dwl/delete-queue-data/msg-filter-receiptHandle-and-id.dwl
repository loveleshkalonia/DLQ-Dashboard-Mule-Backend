/*
	DWL Path:
	/src/main/resources/dwl/delete-queue-data/msg-filter-receiptHandle-and-id.dwl
*/

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