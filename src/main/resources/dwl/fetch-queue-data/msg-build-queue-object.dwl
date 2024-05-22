/*
	DWL Path:
	/src/main/resources/dwl/fetch-queue-data/msg-build-queue-object.dwl
*/

%dw 2.0
import substringAfterLast from dw::core::Strings
output application/json
---
{
	"name": substringAfterLast(payload,"/"),
	"approxMsgCount": vars.count,
//	The code below can be used for Debugging after un-commenting "All Queue Attributes" component
//	"queueAttributes": vars.queueAttributes
}