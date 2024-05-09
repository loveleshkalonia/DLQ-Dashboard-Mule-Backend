%dw 2.0
output application/json
---
payload map ((item, index) -> 
    (item  update {
        case .body -> write($, "application/json")
    }) ++
    {
        "id": uuid(),
        "deduplicationId": dw::Crypto::MD5(uuid()),
        "groupId": "mule-backend"
    }
)