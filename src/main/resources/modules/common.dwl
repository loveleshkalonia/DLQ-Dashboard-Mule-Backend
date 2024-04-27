%dw 2.0

/*
	For More Information, Visit - https://www.loveleshkalonia.com/2024/04/dataweave-code-to-sort-nested-json-objects-and-arrays.html
*/
fun sortObjectAndArray(inputPayload) = (
  if(inputPayload is Object) (
    inputPayload mapObject ((value, key, index) -> 
      (key): sortObjectAndArray(value)
    ) orderBy $$
  )
  else if(inputPayload is Array) (
    if(inputPayload[0] is Object)
      inputPayload map ((item, index) -> 
        sortObjectAndArray(item)
      )
    else
      inputPayload orderBy $
  )
  else inputPayload
)

/*
	For More Information, Visit - https://www.jerney.io/how-to-remove-nested-values-with-dataweave/
*/
fun removeKeyValuePair(e, key) =
  e match {
    case is Object -> e mapObject (v, k) ->
        if ((k as String) == key)
            {}
        else
            {(k): removeKeyValuePair(v, key)}
    else -> e
  }