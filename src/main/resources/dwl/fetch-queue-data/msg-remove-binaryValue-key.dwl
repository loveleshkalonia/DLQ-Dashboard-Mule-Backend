%dw 2.0
import removeKeyValuePair from modules::common
output application/json skipNullOn="everywhere"
---
/*
	For this project, you may have noticed that we are not even using the "binaryValue" key,
	but still removing it using the code below. Why? because there is an issue with current
	SQS connector that this field is being added in Java response from SQS Read component and 
	dataweave is unable to convert that Java response's ("_b" key whose value is null) to JSON
	and causes java.lang.NullPointerException
*/
payload map ((item, index) -> removeKeyValuePair(item,"binaryValue"))