## THE DATABASE HAS BEEN SETUP AND NAMED MEDICAL AND WILL BE USED FOR THIS ANALYSIS

USE  medical;

SELECT *
FROM heart;

##WHAT IS THE AGE RANGE WITHIN OUR DATASET OF 303 ROWS?

SELECT DISTINCT(age)
FROM heart
ORDER BY age ASC;

#THE AGE RANGE WITHIN THE DATASET ASCENDING IS FROM 29 TO 77 YEARS OF AGE

##THE COMMON CONVENTION WHEN IT COMES TO HOW SEX OR GENDER HAVE BEEN REPRESENTED IN THIS DATASET
##IS 1 = MALE AND 0 = FEMALE
##I WOULD LIKE TO FIND OUT HOW MANY OF THE 303 ENTRIES ARE MALE (1) AND HOW MANY ARE FEMALE (0)

SELECT sex, COUNT(*) AS no_per_sex
FROM heart
GROUP BY sex;

##WE FIND THAT THERE ARE 206 MALES AND 97 FEMALES IN OUR DATASET. THIS WILL ALLOW US TO 
##EXTRACT USEFUL INFORMATION LATER IN A MANNER MORE SPECIFIC TO GENDER AND AGE GROUP

##WE WOULD LIKE TO UNDERSTAND NOW THE SUBCATEGORIES WITHIN THE CHASTPAIN FIELD

SELECT DISTINCT(chestpain)
FROM heart;

##FOUR GROUPS NAMELY TYPICAL, ASYMPTOMATIC, NONANGINAL, NONTYPICAL

## WE WANT TO SEE NEXT WHAT NUMBERS ARE HIGHEST THROUGH TO LOWEST - THIS WILL FORM THE BASIS FOR LATER INVESTIGATING AROUND 
##WHY THIS IS THE CASE I.E. AGE? GENDER? SLOPE?

SELECT DISTINCT
	chestpain, COUNT(chestpain) AS chestpain_type_totals
    FROM heart
    GROUP BY chestpain
    ORDER BY chestpain_type_totals DESC;

SELECT restbp
FROM heart
ORDER BY restbp;

SELECT 
	MAX(restbp) - MIN(restbp) as restbp_range, 
    MAX(restbp) as max_restbp, 
    MIN(restbp) as min_restbp
FROM heart
ORDER BY restbp;

SELECT chol
FROM heart
ORDER BY chol;

SELECT 
	MAX(chol) - MIN(chol) as chol_range, 
    MAX(chol) as max_chol, 
    MIN(chol) as min_chol
FROM heart
ORDER BY chol;

SELECT DISTINCT fbs, COUNT(fbs) as fasting_blood_sugar
FROM heart
GROUP BY fbs;

SELECT DISTINCT restecg, COUNT(restecg) as rest_ecg
FROM heart
GROUP BY restecg
ORDER BY restecg;

SELECT 
	MAX(maxhr) - MIN(maxhr) as heart_rate_range, 
    MAX(maxhr) as max_max_hr, 
    MIN(maxhr) as min_max_hr
FROM heart
ORDER BY maxhr;

SELECT DISTINCT exang, COUNT(exang) as Exang
FROM heart
GROUP BY exang;

## THE SPREAD FO THE RESULTS FROM THE QUERY BELOW MIGHT BE OF INTEREST
##IT WILL BE INTERESTING TO SEE WHERE RELATIONSHIPS EXISTS WITH THIS SET OF DATA

SELECT DISTINCT oldpeak, COUNT(oldpeak) as oldpeak_totals
FROM heart
GROUP BY oldpeak
ORDER BY oldpeak;

SELECT *
FROM heart;

USE medical;

SELECT *
FROM heart;

##I WOULD LIKE TO GAIN INSIGHT INTO THE AVERAGE HEART RATE PER AGE GROUP INSIDE OF THE DATA COLLECTED
##WITH THE INCLUSION OF S SEPARATION BY GENDER

SELECT 
    CASE
        WHEN age = 29 THEN '29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 77 THEN '70-77'
    END AS age_group,
    CASE
        WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
    END AS gender,
    ROUND(AVG(maxhr), 2) AS Average_Max_HR
FROM heart
GROUP BY age_group, gender
ORDER BY age_group Asc, gender;


SELECT * FROM heart
ORDER BY age;

SELECT
	CASE 
		WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
	END AS gender,
    ROUND(AVG(maxhr), 2) AS Average_Maxhr_by_gender
FROM heart
GROUP BY sex;

##WHAT IS THE MOST PREVALANT CHESTPAIN EXPERIENCED BY EACH AGE GROUP AND GENDER

SELECT 
    CASE
        WHEN chestpain = 'typical' THEN 'typical'
        WHEN chestpain = 'asymptomatic' THEN 'asymptomatic'
        WHEN chestpain = 'nonanginal' THEN 'nonanginal'
        WHEN chestpain = 'nontypical' THEN 'nontypical'
    END AS chestpain,
    CASE
        WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
    END AS gender,
    CASE
        WHEN age = 29 THEN '29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 77 THEN '70-77'
    END AS age_group,
    COUNT(*) AS gender_count
FROM heart
GROUP BY chestpain, gender, age_group
ORDER BY age_group ASC, gender;

## I WOULD LIKE TO SEE WHAT THE DATA LOOKS LIKE AROUND CHOLESTEROL BY AGE ADN GENDER

SELECT * 
FROM heart;

SELECT
    CASE
        WHEN chol BETWEEN 0 AND 200 THEN 'DESIRABLE'
        WHEN chol BETWEEN 201 AND 239 THEN 'BORDERLINE HIGH'
        WHEN chol > 239 THEN 'HIGH'
    END AS Cholesterol_Level,
    CASE
        WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
    END AS gender,
    CASE
        WHEN age = 29 THEN '29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 77 THEN '70-77'
    END AS age_group,
    Count(chol) AS chol_no
FROM heart
GROUP BY Cholesterol_Level, gender, age_group
ORDER BY age_group ASC, gender;

## I AM INTERESTED TO SEE WHAT THE NUMBERS AROUND CALCIIFICATION IN THE COLUMN Ca LOOK LIKE
##THIS IS WITH THE PREDICTION THAT THE HIGHER AGE GROUPS WILL HAVE HIGH READINGS OF CALCIFICATION
## I AM DOUBTFULL THAT GENDER WILL HAVE ANY SIGNIFICANT FINDING TO PRESENT  WHEN IT COMES TO CALCIFICATION
##BUT THIS REMAINS TO BE SEEN IN THE OUTPUTS FROM MY QUERIES

SELECT DISTINCT ca 
FROM heart;

SELECT
    CASE
        WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
    END AS gender,
    CASE
        WHEN age = 29 THEN '29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 77 THEN '70-77'
    END AS age_group,
    CASE
        WHEN ca = 0 THEN 'None'
        WHEN ca = 1 THEN 'Minimal'
        WHEN ca = 2 THEN 'Moderate'
        WHEN ca = 3 THEN 'Severe'
    END AS Calcification_Level,
    COUNT(ca) AS calcification
FROM heart
GROUP BY gender, age_group, Calcification_Level
ORDER BY age_group ASC, calcification;

## NOW I WILL LOOK INTO THE THAL COLUMN
## THAL REFERS TO THALLIUM STRESS TEST

SELECT *
FROM heart;

SELECT DISTINCT thal, COUNT(thal) as thal_result
FROM heart
GROUP BY thal;

SELECT
    CASE
        WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
    END AS gender,
    CASE
        WHEN age = 29 THEN '29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 77 THEN '70-77'
    END AS age_group,
    CASE
        WHEN thal = 'normal' THEN 'normal'
        WHEN thal = 'fixed' THEN 'fixed'
        WHEN thal = 'reversable' THEN 'reversable'
    END AS Thal_Status,
    COUNT(*) AS Thal_Status_Count
FROM heart
GROUP BY gender, age_group, Thal_Status
ORDER BY age_group ASC, Thal_Status;

##NOW i WOULD LIKE TO LOOK INTO EXERCISE INDUCED ANGINA WHICH IS CHEST PAIN BUT NOT THE SAME
## AS WHAT WE DEALT WITH EARLIER IN THAT THIS EXANG LOOKS SPECIFICALLY AT CHEST PAIN
## INDUCED BY EXERCISE.

SELECT exang
FROM heart;

SELECT
    CASE
        WHEN sex = 0 THEN 'Female'
        WHEN sex = 1 THEN 'Male'
    END AS gender,
    CASE
        WHEN age = 29 THEN '29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 77 THEN '70-77'
    END AS age_group,
    CASE
        WHEN exang = 0 THEN 'no_exang'
        WHEN exang = 1 THEN 'exang'
    END AS ex_ang_presence,
    COUNT(*) AS ex_ang_count
FROM heart
GROUP BY gender, age_group, ex_ang_presence
ORDER BY ex_ang_count DESC;

SELECT 
      CASE  
		WHEN sex = 0 THEN 'Female'
		WHEN sex = 1 THEN 'Male'
	END AS gender_count,
    COUNT(sex) AS gender_count
FROM heart
GROUP BY sex;