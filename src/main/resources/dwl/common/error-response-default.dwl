/*
	DWL Path:
	/src/main/resources/dwl/common/error-response-default.dwl
*/

%dw 2.0
output application/json
---
{
	"errorType": error.errorType.identifier,
	"errorDescription": error.detailedDescription
}