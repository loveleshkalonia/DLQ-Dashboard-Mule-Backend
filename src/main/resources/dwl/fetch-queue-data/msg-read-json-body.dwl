/*
	DWL Path:
	/src/main/resources/dwl/fetch-queue-data/msg-read-json-body.dwl
*/

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