# SIRS - Naive Bayes Classifer
Authors: Yuzhe You, Ziyuan Sun

This is an implementation of Naive Bayes Algorithmn using MIMIC-III data on septic patients.
The goal of this project is to evaluate the SIRS scoring system through data extraction/visualization and machine learning.

# Naive Bayes Algorithm

Bayes classifiers use training data to calculate an observed probability of each class based on all the features. The probability links feature values to classes like a map. When labeling the test data, we utilize the feature values in the test data and the “map” to classify our test data with the most likely class.

This link provides more details about the Naive Bayes Algorithm:
http://www.socr.umich.edu/people/dinov/courses/DSPA_notes/07_NaiveBayesianClass.html

# Systemic Inflammatory Response Syndrome

Systemic inflammatory response syndrome (SIRS) is an exaggerated defense response of the body to a noxious stressor (infection, trauma, surgery, acute inflammation, ischemia or reperfusion, or malignancy, to name a few) to localize and then eliminate the endogenous or exogenous source of the insult [Chakraborty & Burns 2021].

The SIRS scoring system in defined by the satisfaction of any two of the criteria below:
* Body temperature over 38 or under 36 degrees Celsius.
* Heart rate greater than 90 beats/minute
* Respiratory rate greater than 20 breaths/minute or partial pressure of CO2 less than 32 mmHg
* Leucocyte count greater than 12000 or less than 4000 /microliters or over 10% immature forms or bands.

Almost all septic patients have SIRS, but not all SIRS patients are septic. In this study, we investigate the performance of the Naive Bayes Model using three different approaches:
* Using the columns `temperature`, `heartrate`, `resprate`, `paco2` and `wbc`;
* Using only the patients' SIRS scores
* Using both `temperature`, `hearrate`, `resprate`, `paco2`, `wbc` and the patients' SIRS scores

See here for the full documentation presented in HTML format:
https://yyou22.github.io/SIRS-Naive-Bayes/

