# 🏨 Hotel Satisfaction & Regression Modeling

This project analyzes guest satisfaction survey data from a hotel chain using linear regression modeling. It explores relationships between satisfaction factors (e.g., cleanliness, staff, perks), elite membership levels, and behavioral outcomes like food spend and overall satisfaction.

---

## 📂 Dataset

**File:** `hotelsat-data.csv`  
Each row represents a guest's survey feedback and behavioral data, including:
- `satCleanRoom`, `satFrontStaff`, `satPerks`: Satisfaction ratings (1–5 scale)
- `eliteStatus`: Guest's loyalty level (Silver, Gold, Platinum)
- `distanceTraveled`, `nightsStayed`, `avgFoodSpendPerNight`: Numeric behavior indicators
- `satOverall`: Overall satisfaction rating

---

## 🔍 Key Analyses

### 1. 📊 Data Inspection
- Loaded dataset using `read.csv()`, inspected using `str()` and `summary()`
- Used `psych::describe()` for quick variable summaries

### 2. 📐 Exploratory Visualization
- Used `scatterplotMatrix()` for grouped variable clusters
- Applied histograms for skewed variables and log transformations to normalize:
  - `distanceTraveled`, `nightsStayed`, `avgFoodSpendPerNight`

### 3. 🔁 Variable Transformations
- Transformed skewed features using `log()` and created `hotel.df.tr`
- Re-analyzed distributions and relationships using updated data

### 4. 🔄 Correlation Analysis
- Created correlation matrices and visualized with `corrplot()` and `corrplot.mixed()`
- Explored polychoric correlations for ordinal variables related to cleanliness

---

## 📈 Regression Models

### A. Predicting Overall Satisfaction
- Simple model: `satOverall ~ satPerks`
- Expanded model: `satOverall ~ satPerks + satCity + satFrontStaff`

### B. Elite Members Recognition
- Subset model for `Gold` and `Platinum`:
  - `satRecognition ~ satCleanRoom + satFrontStaff + satPoints + satPerks`

### C. Predicting Food Spend
- Main model: `avgFoodSpendPerNight ~ eliteStatus + satDiningPrice`
- Simplified model: `avgFoodSpendPerNight ~ satDiningPrice`
- Behavioral model: `avgFoodSpendPerNight ~ nightsStayed`

- Used `predict()` to estimate food spend for a 40-night stay

---

## 📊 Sample Output

| Model                          | Key Predictor        | Insight                                  |
|-------------------------------|----------------------|------------------------------------------|
| satOverall ~ satPerks         | satPerks (↑)         | Higher perks satisfaction boosts overall |
| FoodSpend ~ nightsStayed      | nightsStayed (↑)     | Longer stays = higher average food spend |
| Recognition ~ satPerks, Staff | satPerks, Staff (↑)  | Key drivers for elite member recognition |

---

## 📦 Libraries Used

```r
library(psych)
library(car)
library(corrplot)
library(multcomp)
