/*
	DWL Path:
	/src/main/resources/dwl/fetch-queue-data/msg-extract-filter-dlqs.dwl
*/

%dw 2.0
output application/json
---
payload."payload" filter ((item, index) -> item.name contains "-dlq")