# heartdisease-ml-analytics

A demonstration of how to use InterSystems IRIS for Health Data Platform to perform machine learning using IntegratedML, as well as build a cube and dashboard to analyze near real-time data.

This demo uses a sample dataset containing various patient observations related to risk of heart disease. In the demo, the data will be prepared, a machine learning model will be created and new patient observations will be scored against the model via a REST API to determine the patient's risk of heart disease. The results will be displayed on a dashboard, updating in near real-time.

## Solution
![/images/ml-demo.png](https://github.com/isc-reven-singh/heartdisease-ml-analytics/blob/main/images/ml-demo.png)
 
 ## Prerequisites
 This demo requires that you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [Docker desktop](https://www.docker.com/products/docker-desktop) and [Postman](https://www.postman.com/downloads/) installed.
 
 ## Installation 

Clone/git pull the repo into any local directory

```
git clone https://github.com/isc-reven-singh/heartdisease-ml-analytics.git
```

Open the terminal in this directory and run:

```
cd heartdisease-ml-analytics
docker-compose build
```
Among other things, iris.script which is called by the installer, compiles the required classes for this demo and sets up the analytics components.

Run the IRIS container with your project:

```
docker-compose up -d
```

## How to Use it

### Log into InterSystems IRIS for Health
------------------------------------------
Open [InterSystems IRIS Management Portal](http://localhost:52773/csp/sys/UtilHome.csp) on your browser.

The default account _SYSTEM / SYS will need to be changed at first login.


### Prepare the data to create a Machine Learning Model
------------------------------------------

In the docker build step above, data was imported into a table called _"HeartApp_Patient.Observations"_. This data must first be split into a training and testing set using a 70/30 split of the 899 records. To do this, open the [SQL editor](http://localhost:52773/csp/sys/exp/%25CSP.UI.Portal.SQL.Home.zen?$NAMESPACE=HEARTAPP) in the management console to run SQL scripts below.

```
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
WHERE ID <= 629 ---70% of total data size
```

```
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
WHERE ID > 629 ---remaining 30% of data
```

Configure ML Provider - Optional
```
CREATE ML CONFIGURATION H2OConfig PROVIDER H2O
```
```
SET ML CONFIGURATION H2OConfig
```

Create ML Model HeartDiseaseRisk to determine the risk of heart disease
```
CREATE MODEL HeartDiseaseRisk 
PREDICTING (HeartDisease) 
FROM HeartApp_Patient.ObservationsMLTrain
```



Train HeartDiseaseRisk Model using training data set
```
TRAIN MODEL HeartDiseaseRisk
```

Test/validate Model use test data set to determine accuracy
```
VALIDATE MODEL HeartDiseaseRisk AS HeartDiseaseRiskValidation From HeartApp_Patient.ObservationsMLTest
```

View validation metrics
```
SELECT * FROM INFORMATION_SCHEMA.ML_VALIDATION_METRICS
```

Test that the model works by scoring against some manual input
```
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
		)
```


### Update the REST API configuration
------------------------------------------

Go to the web application definition for the [/heartapp](http://localhost:52773/csp/sys/sec/%25CSP.UI.Portal.Applications.Web.zen?PID=%2Fheartapp) web app. Update the defintion as follows:

- Switch application type from _"CSP/ZEN"_ to _"REST"_
- Set the Dispatch class to _"HeartApp.REST.Server"_
- Click _"Save"_


### Predict risk of heart disease
------------------------------------------

Using the REST API above and the _"HeartDiseaseRisk"_ model, next predict the risk of heart disease by posting sets of observations to the REST API which scores these using the model and returns a heart disease risk prediction of _0_ or _1_ indicating either low risk or high risk respectively.


Using Postman, send a _"POST"_ request to localhost:52773/heartapp/predict. Ensure that an Authorization header is set to pass through basic authentication in your request using the "__SYSTEM"_ user.

![/images/Postman.png](https://github.com/isc-reven-singh/heartdisease-ml-analytics/blob/main/images/Postman.png)

Send multiple requests using the following request bodies, sending them one at a time:

```
{
      "age": 61,
      "sex": "M",
      "chest_pain_type": "ASY",
      "resting_bp": 148,
      "cholesterol": 203,
      "fasting_bs": 0,
      "resting_ecg": "Normal",
      "max_hr": 161,
      "exercise_angina": "N",
      "old_peak": 0,
      "st_slope": "Up"
    }
 ```
 
 ```
 {
      "age": 58,
      "sex": "M",
      "chest_pain_type": "ASY",
      "resting_bp": 114,
      "cholesterol": 318,
      "fasting_bs": 0,
      "resting_ecg": "ST",
      "max_hr": 140,
      "exercise_angina": "N",
      "old_peak": 4.4,
      "st_slope": "Down"
    }
```

```
{
      "age": 58,
      "sex": "F",
      "chest_pain_type": "ASY",
      "resting_bp": 170,
      "cholesterol": 225,
      "fasting_bs": 1,
      "resting_ecg": "LVH",
      "max_hr": 146,
      "exercise_angina": "Y",
      "old_peak": 2.8,
      "st_slope": "Flat"
    }
```

```
{
      "age": 58,
      "sex": "M",
      "chest_pain_type": "ATA",
      "resting_bp": 125,
      "cholesterol": 220,
      "fasting_bs": 0,
      "resting_ecg": "Normal",
      "max_hr": 144,
      "exercise_angina": "N",
      "old_peak": 0.4,
      "st_slope": "Flat"
    }
```

```
{
      "age": 56,
      "sex": "M",
      "chest_pain_type": "ATA",
      "resting_bp": 130,
      "cholesterol": 221,
      "fasting_bs": 0,
      "resting_ecg": "LVH",
      "max_hr": 163,
      "exercise_angina": "N",
      "old_peak": 0,
      "st_slope": "Up"
    }
```

The REST API will return an output like below:

```
{
    "heart_disease_risk": "0"
}
```


### View the Heart Disease Risk Prediction Dashboard
----------------------------------------------
Open the [Heart Disease Risk Prediction Dashboard](http://localhost:52773/csp/heartapp/_DeepSee.UserPortal.DashboardViewer.zen?DASHBOARD=HeartApp/HeartDiseaseRisk.dashboard) to view, in near real-time, a count of all patients predicted to be at risk of heart disease.

![/images/dashboard.png](https://github.com/isc-reven-singh/heartdisease-ml-analytics/blob/main/images/dashboard.png)

Explore the [Observations](http://localhost:52773/csp/heartapp/_DeepSee.UI.Analyzer.zen?$NAMESPACE=HEARTAPP&PIVOT=HeartApp%2FHeartRiskByAge.pivot) further. Explore the [cube definition](http://localhost:52773/csp/heartapp/_DeepSee.UI.Architect.zen?$NAMESPACE=HEARTAPP&$NAMESPACE=HEARTAPP&) and expand on the data available in the cube to build your own pivots and dashboards.

