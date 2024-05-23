/*
	DWL Path:
	/src/main/resources/dwl/common/composite-error-response-default.dwl
*/

%dw 2.0
output application/json
---
{
	"errorType": error.errorType.identifier,
	"errorDescription": error.childErrors map ((item, index) -> 
    {
        ("route-" ++ index): {
        	"errorType": item.errorType.identifier,
        	"errorDescription": item.detailedDescription
        }
    }
)
}