Class HeartApp.Patient.Observations Extends (%Persistent, %JSON.Adaptor)
{

Property Age As %Integer(%JSONFIELDNAME = "age");

Property Sex As %String(%JSONFIELDNAME = "sex");

Property ChestPainType As %String(%JSONFIELDNAME = "chest_pain_type");

Property RestingBP As %Integer(%JSONFIELDNAME = "resting_bp");

Property Cholesterol As %Integer(%JSONFIELDNAME = "cholesterol");

Property FastingBS As %Integer(%JSONFIELDNAME = "fasting_bs");

Property RestingECG As %String(%JSONFIELDNAME = "resting_ecg");

Property MaxHR As %Integer(%JSONFIELDNAME = "max_hr");

Property ExerciseAngina As %String(%JSONFIELDNAME = "exercise_angina");

Property OldPeak As %Double(%JSONFIELDNAME = "old_peak");

Property STSlope As %String(%JSONFIELDNAME = "st_slope");

Property HeartDisease As %Integer(%JSONFIELDNAME = "heart_disease");

Parameter DSTIME = "AUTO";

Storage Default
{
<Data name="ObservationsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Age</Value>
</Value>
<Value name="3">
<Value>Sex</Value>
</Value>
<Value name="4">
<Value>ChestPainType</Value>
</Value>
<Value name="5">
<Value>RestingBP</Value>
</Value>
<Value name="6">
<Value>Cholesterol</Value>
</Value>
<Value name="7">
<Value>FastingBS</Value>
</Value>
<Value name="8">
<Value>RestingECG</Value>
</Value>
<Value name="9">
<Value>MaxHR</Value>
</Value>
<Value name="10">
<Value>ExerciseAngina</Value>
</Value>
<Value name="11">
<Value>OldPeak</Value>
</Value>
<Value name="12">
<Value>STSlope</Value>
</Value>
<Value name="13">
<Value>HeartDisease</Value>
</Value>
</Data>
<DataLocation>^HeartApp.Patient.ObservationsD</DataLocation>
<DefaultData>ObservationsDefaultData</DefaultData>
<ExtentSize>918</ExtentSize>
<IdLocation>^HeartApp.Patient.ObservationsD</IdLocation>
<IndexLocation>^HeartApp.Patient.ObservationsI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3.72</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb("1","62","124","186","247","308","369","430","491","552","613","674","735","796","857","918"),$lb(0,0,1,0,0,1,0,1,0,0,1,0,1,0,0),$lb(822083584,822083584,909246464,909246464,825373696,842268672,943063040,825767424,842282752,842282752,858798080,808976384,909705216,859191552,875769856,858783744,959512576,876163328,892678656,892678656,909193984,825425920,926154752,909587456,926102784,859111424,959840256,926496256,943011584,943011584,959526912,959526912))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="Age">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(28,38,42,45,48,50,52,54,55,57,58,60,62,64,67,77),$lb(0,0,1,1,0,1,1,1,1,1,0,1,1,1,0),$lb(842530816,842530816,859308032,859308032,875692032,838860800,889192448,889192448,939524096,876085248,892338176,805306368,838860800,838860800,872415232,872415232,889192448,889192448,922746880,922746880,939524096,892862464,909115392,805306368,838860800,838860800,872415232,872415232,922746880,909574144,926351360,926351360))</Histogram>
<Selectivity>2.0000%</Selectivity>
</Property>
<Property name="ChestPainType">
<AverageFieldSize>4.95</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" ASY"," ASY"," ASY"," ASY"," ASY"," ASY"," ASY"," ASY"," ASY"," ATA"," ATA"," NAP"," NAP"," NAP"," NAP"," TA"),$lb(5,5,5,5,5,5,5,5,2,5,1,5,5,5,1),$lb(541152089,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1398341632,1413545984,0,0,1096040704,1312903168,0,0,0,0,0,0,1312903168,1413545984,542392576))</Histogram>
<Selectivity>25.0000%</Selectivity>
</Property>
<Property name="Cholesterol">
<AverageFieldSize>3.12</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,0,0,139,180,197,209,219,227,239,250,264,276,294,318,603),$lb(1,1,0,1,1,0,1,1,1,1,1,1,1,0,0),$lb(805306368,0,0,0,0,805306368,825440512,859373568,942669824,942669824,959905792,825833216,842021120,809041920,825819136,825819136,842465280,842465280,859373568,859373568,892338176,892338176,909377536,909377536,926285824,926285824,959709184,842609664,858863616,858863616,909128448,909128448))</Histogram>
<OutlierSelectivity>.187364:0</OutlierSelectivity>
<Selectivity>0.3677%</Selectivity>
</Property>
<Property name="ExerciseAngina">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" N"," N"," N"," N"," N"," N"," N"," N"," N"," Y"," Y"," Y"," Y"," Y"," Y"," Y"),$lb(3,3,3,3,3,3,3,3,1,3,3,3,3,3,3),$lb(541982720,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1308622848,1493172224,0,0,0,0,0,0,0,0,0,0,0,0,542703616))</Histogram>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="FastingBS">
<AverageFieldSize>2.23</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1),$lb(1,1,1,1,1,1,1,1,1,1,1,0,1,1,1),$lb(805306368,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,805306368,822083584,0,0,0,0,0,0,822083584))</Histogram>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="HeartDisease">
<AverageFieldSize>2.55</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1),$lb(1,1,1,1,1,1,0,1,1,1,1,1,1,1,1),$lb(805306368,0,0,0,0,0,0,0,0,0,0,0,0,805306368,822083584,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,822083584))</Histogram>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="MaxHR">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(60,98,109,115,120,125,130,135,140,144,150,155,160,168,175,202),$lb(0,0,1,1,2,1,2,1,2,1,2,1,2,1,0),$lb(909115392,909115392,959971328,959971328,825243904,809041920,825556992,825556992,842006528,805306368,889192448,842334208,858783744,805306368,889192448,859111424,875560960,805306368,872415232,875823104,892338176,805306368,889192448,892665856,909115392,805306368,939524096,909639680,926220288,825701632,842019328,842019328))</Histogram>
<Selectivity>0.8403%</Selectivity>
</Property>
<Property name="OldPeak">
<AverageFieldSize>10</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb($double(-2.6000000000000000888),$double(0),$double(0),$double(0),$double(0),$double(0),$double(0),$double(.40000000000000002221),$double(.80000000000000004441),$double(1),$double(1.1999999999999999556),$double(1.5),$double(1.8000000000000000444),$double(2),$double(2.7999999999999998223),$double(6.2000000000000001776)),$lb(8,10,10,10,10,10,8,9,8,9,10,10,8,9,8),$lb(758263350,808464432,0,0,0,0,0,0,0,0,0,0,0,0,808464432,808464432,808464432,808464432,0,0,960051513,960051513,0,0,808464432,808464432,0,0,960051513,960051513,808464432,908997168))</Histogram>
<OutlierSelectivity>.400871:$double(0)</OutlierSelectivity>
<Selectivity>1.1522%</Selectivity>
</Property>
<Property name="RestingBP">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,110,112,120,120,124,128,130,130,136,140,140,145,150,160,200),$lb(0,2,1,3,2,2,1,3,2,1,3,2,1,1,0),$lb(805306368,805306368,825307136,805306368,838860800,825360384,842006528,0,0,805306368,872415232,872415232,939524096,842530816,858783744,0,0,805306368,905969664,859176960,875560960,0,0,805306368,889192448,875888640,892338176,892338176,909115392,825634816,842018816,842018816))</Histogram>
<OutlierSelectivity>.143791:120</OutlierSelectivity>
<Selectivity>1.2973%</Selectivity>
</Property>
<Property name="RestingECG">
<AverageFieldSize>6.61</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" LVH"," LVH"," LVH"," LVH"," NORMAL"," NORMAL"," NORMAL"," NORMAL"," NORMAL"," NORMAL"," NORMAL"," NORMAL"," NORMAL"," ST"," ST"," ST"),$lb(5,5,5,1,8,8,8,8,8,8,8,8,1,4,4),$lb(541873736,0,0,0,0,0,0,1280722944,1313821261,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1313821261,1398013952,0,0,0,0,542331904))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="STSlope">
<AverageFieldSize>5.14</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" DOWN"," DOWN"," FLAT"," FLAT"," FLAT"," FLAT"," FLAT"," FLAT"," FLAT"," UP"," UP"," UP"," UP"," UP"," UP"," UP"),$lb(6,1,6,6,6,6,6,6,1,4,4,4,4,4,4),$lb(541347671,0,0,1146050382,1179402580,0,0,0,0,0,0,0,0,0,0,0,0,1179402580,1431306240,0,0,0,0,0,0,0,0,0,0,0,0,542461952))</Histogram>
<Selectivity>33.3333%</Selectivity>
</Property>
<Property name="Sex">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" F"," F"," F"," F"," M"," M"," M"," M"," M"," M"," M"," M"," M"," M"," M"," M"),$lb(3,3,3,1,3,3,3,3,3,3,3,3,3,3,3),$lb(541458432,0,0,0,0,0,0,1174405120,1291845632,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,541917184))</Histogram>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-32</BlockCount>
</SQLMap>
<StreamLocation>^HeartApp.Patient.ObservationsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
