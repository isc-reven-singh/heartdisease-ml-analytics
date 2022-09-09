Class HeartApp.Utilities.Scheduler
{

ClassMethod CreateTask() As %Status
{
    Set task=##class(%SYS.Task).%New()
    Set task.Name = "Sync Patient Cube"
    Set task.NameSpace=$Namespace
    Set task.TimePeriod=0 // Daily
    Set task.TimePeriodEvery=1 // Every 1 day
     Set task.DailyFrequency=1 // Run Several times in a day
    Set task.DailyFrequencyTime=0 // Run every x minutes
    Set task.DailyIncrement=0.2 // # of minutes between runs

    Set taskdef = ##class(HeartApp.Utilities.Task).%New()
    Do task.AssignSettings(taskdef)
    Set task.TaskClass=$classname(taskdef)
    
    Set st = task.%Save()
    Return:$$$ISERR(st) st
    Return ##class(%SYS.Task).RunNow(task.%Id())
}

}
