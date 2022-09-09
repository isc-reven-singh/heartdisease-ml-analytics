Class HeartApp.Utilities.JSONHelper
{

ClassMethod GetJSONFromRequest(request As %CSP.Request, Output obj As %DynamicObject) As %Boolean
{
	Set ok = 1
	Try {
		Set obj = ##class(%DynamicObject).%FromJSON(request.Content)
	} Catch ex {
		Set ok = 0
	}
	Quit ok
}

}
