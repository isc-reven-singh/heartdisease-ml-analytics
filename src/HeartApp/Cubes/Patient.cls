/// 
Class HeartApp.Cubes.Patient Extends %DeepSee.CubeDefinition [ DependsOn = HeartApp.Patient.Observations, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="PatientCube" displayName="Patient" disabled="false" abstract="false" sourceClass="HeartApp.Patient.Observations" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Observation" disabled="false" hasAll="false" allCaption="All Observation" allDisplayName="Observation" type="data" hidden="false" showHierarchies="default">
    <hierarchy name="Sex" disabled="false" hidden="false">
      <level name="Sex" disabled="false" sourceProperty="Sex" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
    </hierarchy>
    <hierarchy name="HeartDisease" displayName="HeartDiseasePredicted" disabled="false" hidden="false">
      <level name="HeartDisease" disabled="false" sourceProperty="HeartDisease" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
    </hierarchy>
    <hierarchy name="Age" disabled="false" hidden="false">
      <level name="Age" disabled="false" sourceProperty="Age" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
      </level>
    </hierarchy>
  </dimension>
  <listing name="ObservationDetails" disabled="false" listingType="table" fieldList="Age,Sex,MaxHR,RestingBP,ExerciseAngina,RestingECG,Cholesterol,ChestPainType,STSlope,FastingBS,OldPeak">
  </listing>
</cube>
}

Parameter DOMAIN;

Parameter DSTIME = "AUTO";

}
