---Cleanup data to recreate model
DROP Model HeartDiseaseRisk;
DROP Table HeartApp_Patient.ObservationsMLTrain;
DROP Table HeartApp_Patient.ObservationsMLTest;
DROP ML CONFIGURATION H2OConfig;