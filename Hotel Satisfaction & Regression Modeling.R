#  Hotel Satisfaction & Regression Modeling

# 📁 Load and inspect data
hotel.df <- read.csv("~/Downloads/hotelsat-data (1).csv")
str(hotel.df)
summary(hotel.df)

# 📚 Libraries
library(psych)
library(car)
library(corrplot)
library(psych)
library(multcomp)

# 🔍 Variable Exploration
describe(hotel.df)

# Scatterplot Matrices
scatterplotMatrix(hotel.df[, 1:9])
scatterplotMatrix(hotel.df[, 10:18])
scatterplotMatrix(hotel.df[, 19:25])

# 📐 Transform skewed variables
par(mfrow = c(1, 2))
hist(hotel.df$distanceTraveled)
hist(log(hotel.df$distanceTraveled))
hist(hotel.df$nightsStayed)
hist(log(hotel.df$nightsStayed))
hist(hotel.df$avgFoodSpendPerNight)
hist(log(hotel.df$avgFoodSpendPerNight + 1))
par(mfrow = c(1, 1))

# Save transformed dataset
hotel.df.tr <- hotel.df
hotel.df.tr$distanceTraveled     <- log(hotel.df$distanceTraveled)
hotel.df.tr$nightsStayed         <- log(hotel.df$nightsStayed)
hotel.df.tr$avgFoodSpendPerNight <- log(hotel.df$avgFoodSpendPerNight + 1)

# Transformed scatterplot matrix
scatterplotMatrix(hotel.df.tr[, 19:25])

# 🔄 Correlation patterns
corrplot(cor(hotel.df.tr[, c(-21, -25)]))
corrplot.mixed(cor(hotel.df.tr[, c(-21, -25)]), upper = "ellipse")

# 🧼 Cleanliness item correlations
cor(hotel.df[, 1:3])
polychoric(with(hotel.df, cbind(satCleanRoom, satCleanBath, satCleanCommon)))

# 📈 Predict satOverall from satPerks
hotel.perks.lm <- lm(satOverall ~ satPerks, data = hotel.df.tr)
summary(hotel.perks.lm)

# 📈 Add Front Staff + City to the model
hotel.perks.lm2 <- lm(satOverall ~ satPerks + satCity + satFrontStaff, data = hotel.df.tr)
summary(hotel.perks.lm2)

# 👑 Predict satRecognition for Gold & Platinum members
hotel.rec.lm <- lm(satRecognition ~ satCleanRoom + satFrontStaff + satPoints + satPerks,
                   data = subset(hotel.df.tr, eliteStatus %in% c("Gold", "Platinum")))
summary(hotel.rec.lm)

# 🍽️ Predict avgFoodSpendPerNight
hotel.food.lm <- lm(avgFoodSpendPerNight ~ eliteStatus + satDiningPrice, data = hotel.df.tr)
summary(hotel.food.lm)

# 💸 Simplified model
hotel.food.lm2 <- lm(avgFoodSpendPerNight ~ satDiningPrice, data = hotel.df.tr)
summary(hotel.food.lm2)

# 📊 Predict food spend based on nights stayed
hotel.food.lm.bynights <- lm(avgFoodSpendPerNight ~ nightsStayed, data = hotel.df.tr)
plot(jitter(exp(hotel.df.tr$nightsStayed)),
     jitter(exp(fitted(hotel.food.lm.bynights))),
     xlab = "Nights Stayed",
     ylab = "Mean Food Spend per Night ($)",
     main = "Predicted Food Spend by Nights Stayed")

# Predict for 40 nights
predict(hotel.food.lm.bynights, newdata = data.frame(nightsStayed = log(40)))
