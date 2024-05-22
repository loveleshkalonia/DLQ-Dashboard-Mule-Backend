/*
	DWL Path:
	/src/main/resources/dwl/transfer-queue-data/msg-extract-payload.dwl
*/

%dw 2.0
output application/json
---
payload mapObject ((value, key, index) -> 
    if((key) as String == "0") "sendToDestQueue": value."payload"
    else "deleteFromSrcQueue": value."payload"
)