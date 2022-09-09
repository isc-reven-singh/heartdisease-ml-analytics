--SPLIT DATA INTO TRAIN AND TEST SETS
CREATE TABLE HeartApp_Patient.ObservationsMLTrain
AS 
SELECT 
		ID, 
		Age, 
		ChestPainType, 
		Cholesterol, 
		ExerciseAngina, 
		FastingBS, 
		HeartDisease, 
		MaxHR, 
		OldPeak, 
		RestingBP, 
		RestingECG, 
		STSlope, 
		Sex 
FROM HeartApp_Patient.Observations
WHERE ID <= 629; ---70% of total data size

CREATE TABLE HeartApp_Patient.ObservationsMLTest
AS 
SELECT 
		ID, 
		Age, 
		ChestPainType, 
		Cholesterol, 
		ExerciseAngina, 
		FastingBS, 
		HeartDisease, 
		MaxHR, 
		OldPeak, 
		RestingBP, 
		RestingECG, 
		STSlope, 
		Sex 
FROM HeartApp_Patient.Observations
WHERE ID > 629; ---remaining 30% of data

---CREATE ML Model HeartDiseaseRisk to determine the risk of heart disease
CREATE MODEL HeartDiseaseRisk 
PREDICTING (HeartDisease) 
FROM HeartApp_Patient.ObservationsMLTrain;

---Configure ML Provider - Optional
CREATE ML CONFIGURATION H2OConfig PROVIDER H2O;

SET ML CONFIGURATION H2OConfig;

---Train HeartDiseaseRisk Model using training data set
TRAIN MODEL HeartDiseaseRisk;

---Test/validate Model use test data set to determine accuracy
VALIDATE MODEL HeartDiseaseRisk AS HeartDiseaseRiskValidation From HeartApp_Patient.ObservationsMLTest;

---View validation metrics
---SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS

---Test that the model works by scoring against some manual input
SELECT *, 
		PREDICT(HeartDiseaseRisk) As PredictedHeartDisease
FROM
(
SELECT 0 ID,
		61 Age, 
		'ASY' ChestPainType, 
		203 Cholesterol, 
		'N' ExerciseAngina, 
		0 FastingBS, 
		161 MaxHR, 
		0 OldPeak, 
		148 RestingBP, 
		'Normal' RestingECG, 
		'Up' STSlope, 
		'M' Sex 
		);
	
	






		
