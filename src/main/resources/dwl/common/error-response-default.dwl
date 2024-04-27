%dw 2.0
output application/json
---
{
	"errorType": error.errorType.identifier,
	"errorDescription": error.detailedDescription
}