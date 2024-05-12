%dw 2.0
output application/json
---
{
    "approxMsgCount": vars.count,
    "firstTenMessages": payload map ((item, index) -> 
            item  update {
                case .body -> read($, "application/json")
            }
        )
}