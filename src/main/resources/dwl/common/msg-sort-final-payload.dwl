/*
	DWL Path:
	/src/main/resources/dwl/common/msg-sort-final-payload.dwl
*/

%dw 2.0
import * from modules::common
output application/json
---
sortObjectAndArray(payload)