# heartdisease-ml-analytics

A demonstration of how to use InterSystems IRIS for Health Data Platform to perform machine learning using IntegratedML, as well as build a cube and dashboard to analyze near real-time data.

This demo uses a sample dataset containing various patient observations related to risk of heart disease. In the demo, the data will be prepared, a machine learning model will be created and new patient observations will be scored against the model via a REST API to determine the patient's risk of heart disease. The results will be displayed on a dashboard, updating in near real-time.
 
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

CREATE ML Model HeartDiseaseRisk to determine the risk of heart disease
```
CREATE MODEL HeartDiseaseRisk 
PREDICTING (HeartDisease) 
FROM HeartApp_Patient.ObservationsMLTrain
```

Configure ML Provider - Optional
```
CREATE ML CONFIGURATION H2OConfig PROVIDER H2O
```
```
SET ML CONFIGURATION H2OConfig
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

Using Postman, send a _"POST"_ request to localhost:52773/heartapp/predict. Ensure that an Authorization header is set to pass through basic authentication in your request using the "_SYSTEM"_ user.

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


------------------------------




### Start Kafka
----------------------
#### EXECUTE 4x CONTAINER SHELLS:

- Shell 1 : Start Zookeeper
- Shell 2 : Start Kafka Broker
- Shell 3 : Create Topics and produce events
- Shell 4 : Consume events


```
docker-compose exec iris bash
```

#### START THE KAFKA ENVIRONMENT
##### Shell 1 
Start Zookeeper
```
zookeeper-server-start.sh /kafka/kafka_2.13-3.0.1/config/zookeeper.properties
```
##### Shell 2 
Start Kafka Broker
```
kafka-server-start.sh /kafka/kafka_2.13-3.0.1/config/server.properties
```
##### Shell 3 
Create a topic for incoming credit card transactions
```
kafka-topics.sh --create --topic cctransactions --bootstrap-server localhost:9092
```
Create a topic for notifications of transaction that have been processed
```
kafka-topics.sh --create --topic agentworklist --bootstrap-server localhost:9092
```
Describe a topic
```
kafka-topics.sh --describe --topic cctransactions --bootstrap-server localhost:9092
```
Produce events to the topic
```
kafka-console-producer.sh --topic cctransactions --bootstrap-server localhost:9092
```
##### Shell 4 
Consume events from a topic
```
kafka-console-consumer.sh --topic agentworklist --bootstrap-server localhost:9092
```




Go back to the **Shell 3**
and generate credit card transaction events, one line at a time. After each event is produced, the [KafkaBank.Stream.Production](http://localhost:52773/csp/kafkabank/EnsPortal.ProductionConfig.zen?PRODUCTION=KafkaBank.Stream.Production) consumes the message and the outut will be visible on **Shell 4** as well as in the Management Portal (Select any of the components of the production by clicking once -> On the right hand pane, select the "Messages" tab, then any of the messages in the list to explore them in depth)

```
{ "transdatetime": "2020-06-21 12:14:25", "cc_num": "2291163933867244", "merchant": "fraud_Kirlin and Sons", "category": "personal_care", "amt": 2.86, "first": "Jeff", "last": "Elliott", "gender": "M", "street": "351 Darlene Green", "city": "Columbia", "state": "SC", "zip": "29209", "lat": 33.9659, "long": -80.9355, "city_pop": 333497, "job": "Mechanical engineer", "dob": "1968-03-19", "trans_num": "2da90c7d74bd46a0caf3777415b3ebd3", "unix_time": "1371816865", "merch_lat": 33.986391, "merch_long": -81.200714, "is_fraud": true }
```
```  
{ "transdatetime": "2019-01-01 00:00:18", "cc_num": "2703186189652095", "merchant": "fraud_Rippin, Kub and Mann", "category": "misc_net", "amt": 4.97, "first": "Jennifer", "last": "Banks", "gender": "F", "street": "561 Perry Cove", "city": "Moravian Falls", "state": "NC", "zip": "28654", "lat": 36.0788, "long": -81.1781, "city_pop": 3495, "job": "Psychologist, counselling", "dob": "1988-03-09", "trans_num": "0b242abb623afc578575680df30655b9", "unix_time": "1325376018", "merch_lat": 36.011293, "merch_long": -82.048315, "is_fraud": true }
```
```
{ "transdatetime": "2019-01-01 00:00:44", "cc_num": "630423337322", "merchant": "fraud_Heller, Gutmann and Zieme", "category": "grocery_pos", "amt": 107.23, "first": "Stephanie", "last": "Gill", "gender": "F", "street": "43039 Riley Greens Suite 393", "city": "Orient", "state": "WA", "zip": "99160", "lat": 48.8878, "long": -118.2105, "city_pop": 149, "job": "Special educational needs teacher", "dob": "1978-06-21", "trans_num": "1f76529f8574734946361c461b024d99", "unix_time": "1325376044", "merch_lat": 49.159046999999994, "merch_long": -118.186462, "is_fraud": true }
```
```
{ "transdatetime": "2019-01-01 00:00:51", "cc_num": "38859492057661", "merchant": "fraud_Lind-Buckridge", "category": "entertainment", "amt": 220.11, "first": "Edward", "last": "Sanchez", "gender": "M", "street": "594 White Dale Suite 530", "city": "Malad City", "state": "ID", "zip": "83252", "lat": 42.1808, "long": -112.262, "city_pop": 4154, "job": "Nature conservation officer", "dob": "1962-01-19", "trans_num": "a1a22d70485983eac12b5b88dad1cf95", "unix_time": "1325376051", "merch_lat": 43.150704, "merch_long": -112.154481, "is_fraud": true }
```
```
{ "transdatetime": "2019-01-01 00:01:16", "cc_num": "3534093764340240", "merchant": "fraud_Kutch, Hermiston and Farrell", "category": "gas_transport", "amt": 45, "first": "Jeremy", "last": "White", "gender": "M", "street": "9443 Cynthia Court Apt. 038", "city": "Boulder", "state": "MT", "zip": "59632", "lat": 46.2306, "long": -112.1138, "city_pop": 1939, "job": "Patent attorney", "dob": "1967-01-12", "trans_num": "6b849c168bdad6f867558c3793159a81", "unix_time": "1325376076", "merch_lat": 47.034331, "merch_long": -112.561071, "is_fraud": true }
```
### View the Fraudulent Transaction Dashboard
----------------------------------------------
Open the [Fraudulent Transaction Dashboard](http://localhost:52773/csp/kafkabank/_DeepSee.UserPortal.DashboardViewer.zen?DASHBOARD=KafkaBank/TransactionsDashboard.dashboard) to view, in near real-time, a count of all transactions suspected to be fraudulent, seperated by State.

Explore the [Transaction cube](http://localhost:52773/csp/kafkabank/_DeepSee.UI.Analyzer.zen?$NAMESPACE=KAFKABANK&PIVOT=KafkaBank%2FFraudFilter.pivot) further, and build your own pivots and dashboards.

