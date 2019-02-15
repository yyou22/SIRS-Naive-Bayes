---
title: "MIMIC-III Naive Bayes on SIRS Data"
author: "<h3><p>Yuzhe You</p><p>vyou@umich.edu</p></h3>"
date: "`r format(Sys.time(), '%B %Y')`"
output:
  html_document:
    highlight: tango
    number_sections: yes
    theme: default
    toc: yes
    toc_depth: 3
    toc_float:
      collapsed: yes
      smooth_scroll: yes
subtitle: <h2><u>Winter 2019, SOCR-MDP</u></h2>
---
```{r message=F, warning=F}
# Plots and tables
library('knitr')          # knitting Rmd to HTML; kable() function
library('kableExtra')     # extra formating options for knitr tables
library('ggplot2')        # 2d plotting
library('ggpubr')         # extra formatting options for ggplot
```

**Random Seed Set**
```{r message=F, warning=F}
set.seed(123456)
```

# Exploring and preparing the data
First we are going to create the sample cohort of patients and extracted their diagnosis codes and the physiologic predictors used in the SIRS criteria by loading the CSV.

```{r eval=T, message=F, warning=F}
cohort_data <- read.csv('../SIRS/sample_data.csv')
str(cohort_data)
```

Then, we'll screen the patients based on their ICD9 codes to identify those with sepsis based on a post in <a href=https://stackoverflow.com/questions/50672316/r-test-if-a-string-vector-contains-any-element-of-another-list>Stack Overflow</a>. The codes for sepsis, severe sepsis, and septic shock are 99591, 99592, and 78552 respectively.

```{r eval=T, message=F, warning=F}
# Search for septic patients
search_patterns = paste(c(99591, 99592, 78552), collapse="|")

for (i in 1:nrow(cohort_data)){
  cohort_data$septic[i] <- grepl(search_patterns, cohort_data[i, 'icd9_code'])
}

kable(head(cohort_data), caption="Sample of cohort data from Part 1 after searching for sepsis diagnosis.") %>%
  kable_styling(bootstrap_options='striped')
```


We'll also choose to remove rows that contain missing variables in order to make visualization and exploratory data analysis easier.

```{r eval=T, message=F, warning=F}
cohort_data = cohort_data[complete.cases(cohort_data),]
```



##Calculation of SIRS scores
Here we are going to calculate SIRS scores for all patients

```{r eval=T, message=F, warning=F}
for (i in 1:nrow(cohort_data)) {
  cohort_data$sirs.score[i] <-sum(as.numeric(cohort_data$temperature[i] > 38 | 
                                             cohort_data$temperature[i] < 36),
                                  as.numeric(cohort_data$heartrate[i] > 90),
                                  as.numeric(cohort_data$resprate[i]>20 |
                                             cohort_data$paco2[i] < 32),
                                  as.numeric(cohort_data$wbc[i] > 12 | cohort_data$wbc[i] < 4))
}
```

Change the `sirs.score` variable into a factor.

```{r eval=T, message=F, warning=F}
cohort_data$sirs.score <- factor(cohort_data$sirs.score)
str(cohort_data$sirs.score)
```

```{r eval=T, message=F, warning=F}
table(cohort_data$sirs.score)
```



