Class HeartApp.Utilities.Task Extends %SYS.Task.Definition
{

Method OnTask() As %Status
{
    return ##class(%DeepSee.Utils).%SynchronizeCube("PatientCube")
}

}
