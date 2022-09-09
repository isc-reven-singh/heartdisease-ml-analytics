Class HeartApp.REST.Server Extends %CSP.REST
{

Parameter HandleCorsRequest = 1;

Parameter CONTENTTYPE = "application/json";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<Route Url="/test" Method="GET" Call="Test" />
  <Route Url="/predict" Method="POST" Call="Predict" />
</Routes>
}

ClassMethod Test() As %Status
{
    Set sc = $$$OK
    // do something
    s output = { "status" : "success" }
    w output.%ToJSON()
    Return sc
}

ClassMethod Predict() As %Status
{
  

    Set sc = ##class(HeartApp.Utilities.JSONHelper).GetJSONFromRequest(%request,.obj)
    
    	If '$D(obj) {
        	Set %response.Status = ..#HTTP400BADREQUEST
          Set sc = ##class(HeartApp.Utilities.JSONHelper).RespondError("JSON not found, or JSON document is incorrect")
          Quit $$$OK
	      }
 
  	
	S observations = ##class(HeartApp.Patient.Observations).%New() 
	S sc = observations.%JSONImport(obj)
	S sc = observations.%Save()
	S id = observations.%Id()

	S HeartDiseaseRisk = -1
	
	&sql(SELECT
		PREDICT(HeartDiseaseRisk) INTO :HeartDiseaseRisk
		FROM
		HeartApp_Patient.Observations
		Where ID = :id
	)
	S observations.HeartDisease=HeartDiseaseRisk
	S sc = observations.%Save()
	S output = {}
	S output."heart_disease_risk" = HeartDiseaseRisk 
	W output.%ToJSON()
  
    Return sc
}

}
