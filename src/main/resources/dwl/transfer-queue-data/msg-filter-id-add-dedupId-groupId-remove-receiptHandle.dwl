/*
	DWL Path:
	/src/main/resources/dwl/transfer-queue-data/msg-filter-id-add-dedupId-groupId-remove-receiptHandle.dwl
*/

%dw 2.0
output application/json
---
(payload filter ((item, index) -> 
    vars.messageIds contains item."id"
)) map ((item, index) -> 
    (
        item ++ {
            "deduplicationId": dw::Crypto::MD5(item.id),
            "groupId": "mule-backend"
        }
    ) - "receiptHandle"
)