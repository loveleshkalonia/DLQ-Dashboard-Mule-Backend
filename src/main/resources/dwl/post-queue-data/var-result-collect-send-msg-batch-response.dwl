/*
	DWL Path:
	/src/main/resources/dwl/post-queue-data/var-result-collect-send-msg-batch-response.dwl
*/

%dw 2.0
output application/json
---
(vars.result default []) ++ [payload]