---
  title: "Data Visualization - Coursework 02 - 1st diet"
author: "Emmanuel Akama (S2229758)"
date: "April 23, 2024"
output:
  html_document: default
pdf_document: default
---
  
  *ATTESTATION: I confirm that the material contained within the
submitted coursework is my own work*
  
  
  ## 1. Project Summary
  
  \"Good apples are the crisp symphony of nature\'s sweetness, each bite a
harmonious blend of juiciness and flavor. Bad apples, on the other
hand, are the sour note in the orchestra, a disappointing crunch
yielding to blandness or worse, a rot that taints the palate.\"*Anonymous.*

![Apple Quality](C:/Users/emman/OneDrive - GLASGOW CALEDONIAN UNIVERSITY/Documents/GCU/Trimester B/Data Visualisation/Assessments/CW 02/Report/apple_dataset.jpg)\


The objective of this report is to analyse a mock-up apple dataset to
gain insights into the characteristics and quality factors of apples
using a dataset containing various features such as colour, size,
weight, sweetness, crunchiness, juiciness, ripeness, acidity, and
quality. Through exploratory data analysis (EDA) and statistical
analysis, we aim to understand the relationships between these features
and the overall quality of apples.

## 2. Introduction

The report is based on a quality analysis of a mock-up apple dataset on
*Kaggle*. For more information on the dataset, see
<https://www.kaggle.com/datasets/tejpal123/apple-quality-analysis-dataset>.
The dataset contains 4001 observations about various attributes that
provide insights into the quality characteristics of an apple. It
includes features such as size, weight, sweetness, crunchiness,
juiciness, ripeness, acidity, and quality.

The objective of the report is to visually analyse a mock-up apple
dataset to gain insights into the characteristics features such as size,
weight, sweetness, crunchiness, juiciness, ripeness and acidity, to
understand the relationships between these features and the overall
quality of apples. Based on the research objective, we will attempt to
visually analyse the dataset to find answers to the following research
questions.

1.  What is the overall quality of the apples?

2.  Which intrinsic feature impact on quality the most?

3.  Is there any relationship between the size and weight and quality?

```{=html}
<!-- -->
```

## 3. Data Preprocessing, Wrangling and Exploratory Analysis

We will use the *tidyverse* package for data preprocessing wrangling and
exploration. For these, we will focus more on data visualization and
descriptive statistics techniques inherent in R and the *tidyverse*
package.

#### Import and Load Packages

```{r echo=TRUE}
#import and load library packages
library(tidyverse)
library(ggforce)
```

#### Data Ingestion


```{r echo=TRUE}
# load the dataset
data <- read.csv("C:/Users/emman/OneDrive - GLASGOW CALEDONIAN UNIVERSITY/Documents/GCU/Trimester B/Data Visualisation/Assessments/CW 02/Datasets/Apple_Quality.csv")
```

#### Data Preprocessing

After loading the data, we will first preview it to see how it looks, then we will
perform some preprocessing steps to clean up the data. This includes the removal of missing entries and duplicate records. However, we will first check that their removal wouldn't have any impact on the original distribution of the data.

```{r echo=TRUE}
# glimpse through the data
glimpse(data)
```
```{r echo=TRUE}
# check the data attributes
str(data)
```

```{r echo=TRUE}
# check the total missing values
sum(is.na(data))
```

```{r echo=TRUE}
# omit missing values
data <- na.omit(data)
```

#### Data Wrangling

```{r echo=TRUE}
# convert to numeric datatype
data$Acidity <- as.numeric(data$Acidity)
```

```{r echo=TRUE}
# drop unused columns
data <- data[, -which(names(data) == "A_id")]
```

```{r echo=TRUE}
# confirm the data attributes
str(data)
```
#### Data Exploration
1.	What is the overall quality of the apples?
To understand the overall distribution of the apple observations, we will make a bar plot of the number of occurrences in each quality category.

```{r echo=TRUE}
# select 'Quality' from the dataframe
# then assign it to a new variable df1
df1 <- data %>%
  select(Quality)

# make bar plot
ggplot(df1, 
       aes(x = factor(Quality),
       fill = Quality)) +

# set the geom type to bar (bin width=0.5)
geom_bar(alpha = 0.5, width=0.5) + 

# extend the y-axis to 2250    
ylim(0, 2250) +

# add text annotations (using 'count')
geom_text(stat = 'count', 
          aes(label = after_stat(count)), 
          vjust = -0.5, size = 3) +

# add title and subtitles
labs(
  x = "Quality",
  y = "Number of Occurrences",
  fill = "Quality",
  title = "Distribution of apple quality",
  subtitle = "with data points from 4,000 independent observations"
) +

# change the default fill colours
scale_fill_manual(values = c("bad" = "red", "good" = "green")) +
  
# change the theme
theme_classic()
```

From the frequency distribution, we could see that the quality of apples
is evenly distributed. *Bad* apples had a count of 2004 (or 51%), while
*Good* apples had a count of 1996 (or 41%)

2.  *Which intrinsic feature impact on quality the most?*

To understand the features of apples that have the most significant
impact on quality, we will calculate the correlation between each
feature and quality. Then, we will make a *heat plot* to visualize their
impact on quality.

3.  *Is there any relationship between physical attributes and quality?*

From the heat plot analysis of the most impactful quality feature, we
noted that the correlation between the apple size and weight to quality
was 0.24 and 0.0 respectively. This shows that there's no relationship
between physical attributes, such as size and weight in relation to the
quality of apples. However, to visualize this report, we will make a
*scatter plot* of their observations in relation to the quality of
apples.

```{r echo=TRUE}
# select 'Size', 'Weight' and 'Quality' from the dataframe
# then assign it to a new variable df2
df2 <- data %>%
  select(Size, Weight, Quality) %>%
  group_by(Quality) 

# make scatter plot of size and weight
ggplot(df2, 
       aes(x = Size, y = Weight)) +
  
geom_point(alpha = 0.5, aes(colour = Quality)) +
  
# draw elliptical shapes around the cylinder groups and label them
geom_mark_ellipse(alpha = 0.5, aes(label = Quality, group = Quality)) +
  
# extend the x and y-axis from -10 to 10    
xlim(-10, 10) +
ylim(-10, 10) +
  
# add title and subtitles
labs(
  x = "Size",
  y = "Weight",
  fill = "Quality",
  title = "Distribution of apple quality by size and weight",
  subtitle = "with data points from 4,000 independent observations"
) +

# change the default fill colours
  scale_colour_manual(values = c("bad" = "red", "good" = "green")) +

# change the theme
theme_classic()
```

From the observations, we see that there is an even distribution of
*'bad'* and *'good'* apples. However, to further analyse the report, we
will make a visual inspection of this report using a *box plot* to
further understand the distribution of the observations in relation to
central tendencies, such as median and standard deviation.

```{r echo=TRUE}
# violin plot of size and weight
ggplot(df2, aes(x = Quality, y = Size, fill=Quality)) +
  geom_boxplot() +
  scale_fill_manual(values = c("bad" = "red", "good" = "green")) +

# add title and subtitles
labs(
  x = "Size",
  y = "Weight",
  fill = "Quality",
  title = "Distribution of apple quality by size and weight",
  subtitle = "with data points from 4,000 independent observations"
) +

# change the default fill colours
  scale_colour_manual(values = c("bad" = "red", "good" = "green")) +

# change the theme
theme_classic()
```

From the *box plot* showing the distribution of apple sizes in relation
to quality, we see that there's an overlap between *'bad'* and *'good'*
apples. This indicates that apples slightly bigger than the median size
are more likely to be *'good'* apples. Conversely, apples slightly
smaller than the median size are more likely to be *'bad'* apples.

Again, looking the *box plot* showing the distribution of apple weight
in relation to quality, we see that there's an overlap between *'bad'*
and *'good'* apples. However, this time, there's a strong indication
that [all]{.underline} the *'bad'* could also have been *'good'* ones
given their weigh distribution in relation to quality. Hence, the apples
were tagged *'bad'* or *'good'* due to other factors unrelated to their
weight.

## 4. Conclusion

From the visual exploration of the Apple dataset, the following findings
were observed.

-   In terms of quality, the overall distribution of *'bad'* and
    *'good'* apples was evenly distributed.

-   Further analysis to determine which intrinsic feature had the most
    impact on revealed that [none]{.underline} of the features had any
    strong correlation to the quality of apples in the distribution.
    Hence, the features were exclusively independent on quality.

-   Looking further into distribution of the size and weights of the
    apples, we observed that there's no impact on the weight of the
    apples in relation to quality. This finding revealed that both
    lightweight and heavy-weight apples can either be '*bad'* or
    *'good'* apples. Hence, from the distribution, the weight of an
    apple had no indication on quality. However, looking at the size
    distribution of the apples, we observed there was slightly higher
    probability of bigger apples been *'good'* apples compared smaller
    apples in the distribution. However, there was also an overlap
    indicating that both big and small apples can be tagged *'bad'* or
    *'good'* quality apples.

## 5. References