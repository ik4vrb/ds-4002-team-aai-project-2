### MLR tee hee

  ### load in data for painting metadata

library(tidyverse)
library(corrplot)
library(Hmisc)
library(car)
library(olsrr)

  ### read in csv
painting_data <- read.csv("painting_meda_data_final.csv", na.strings=c("","NA"))
painting_data <- drop_na(painting_data)


  ### convert columns to correct datatypes 

painting_data$time_period <- as.factor(painting_data$time_period)
painting_data$artist <- as.factor(painting_data$artist)
painting_data$paint_type <- as.factor(painting_data$paint_type)
painting_data$painting_material <- as.factor(painting_data$painting_material)

painting_data$estimated_price_millions <- as.numeric(gsub("[\\$,]", "", painting_data$estimated_price_millions))

  ### collapse levels 

table(painting_data$paint_type)

levels(painting_data$paint_type) <- list("Other" = c("Acrylic", "Casein and wax crayon", " Crayons", 
                                                     "Encaustic and collage", "Encaustic paint and newsprint",
                                                     "Encaustic painting and collage", "Gouache ", 
                                                     "Hanging scroll", "Oil and acrylic", "Oil and magma", 
                                                     "Oil and tempera", "Oil and wax crayon ", "Pastel",
                                                     "Polymer and graphite ", " Silkscreen", "Tempera"),
                                         "Oil"=c("Oil", "Oil ", "Two oil"))

table(painting_data$painting_material)

levels(painting_data$painting_material) <- list("Other"=c("board", "cardboard", "cotton",
                                                          "cypress wood", "fiberboard", "oak panel", "panel", 
                                                          "paper", "Scroll", "Scroll on paper", "wood"),
                                                "Canvas"=c("canvas"))

painting_data <- drop_na(painting_data)
### Variables to use

MLR_check_time_period <- boxplot(estimated_price_millions ~ time_period, data=painting_data)

MLR_check_paint_type <- boxplot(estimated_price_millions ~ paint_type, data=painting_data)

MLR_check_painting_material <- boxplot(estimated_price_millions ~ painting_material, data=painting_data)

#boxplot(estimated_price_millions ~ painting)
  ### drop
MLR_check_area <- cor(x=painting_data$area_cm2, y=painting_data$estimated_price_millions, use="complete.obs")
MLR_check_area

  ### most important predictors:
# time period (qual), paint type (qual), painting_material (qual)

  ### checking to see if there is any interactions:

interaction.plot(painting_data$paint_type, painting_data$time_period, 
                 painting_data$estimated_price_millions, fun=mean,trace.label="Time Period", 
                 xlab="Paint Type",ylab="Estimated Price (Millions)")

# => no time_period X paint_type interaction

interaction.plot(painting_data$paint_type, painting_data$painting_material, 
                 painting_data$estimated_price_millions, fun=mean,trace.label="Painting Material", 
                 xlab="Paint Type",ylab="Estimated Price (Millions)")

# => no paint_type X painting_material interaction

interaction.plot(painting_data$painting_material, painting_data$time_period, 
                 painting_data$estimated_price_millions, fun=mean,trace.label="time_period", 
                 xlab="Paint Type",ylab="Estimated Price (Millions)")

# => no painting_material X time_period interaction

  ### MLR, alpha = 0.25

# E(estimated_price_millions)= beta_0+ beta_1 1850_1945 + beta_2 post_war_contemporary 
#                            + beta_3 oil + beta_4 canvas$

painting_data$time_period <- relevel(factor(painting_data$time_period),ref="Painting before 1850")

paintmodel1<-lm(estimated_price_millions ~ time_period+paint_type+painting_material, data=painting_data)
summary(paintmodel1)

ols_step_both_p(paintmodel1,pent=0.25,prem=0.25,details=F)

  ### final regression model

# E(estimated_price_millions)= beta_0+ beta_1 1850-1945 + 
#                              beta_2 post_war_contemporary 

paintmodel2 <- lm(estimated_price_millions ~ time_period, data=painting_data)
summary(paintmodel2)

# E(estimated_price_millions)= 162.903 -(9.184) 1850-1945 -(23.581) post_war_contemporary

# $\widehat{estimated_price_millions}=162.903-9.184 Factorlevel1850to1945- 23.581 Factorlevelpostwarcontemp$

# Outliers/ infleuntial datapoints

influencePlot(paintmodel2,fill=F)

  ### RMSE

paintmodel_RMSE <- sqrt(mean(paintmodel2$residuals^2))
paintmodel_RMSE
==============================================================

  ### load in painting characteristics csv

painting_char_data <- read.csv("Image_URL_Data.csv")

  ### Clean data

names(painting_char_data)[2] <- "image_name"

name_price <- painting_data[, c('image_name', 'estimated_price_millions')]

painting2 <- merge(painting_char_data, name_price, by='image_name', all.X=TRUE)

  ### scatterplot EDS

plot(painting2$Entropy.Values, painting2$estimated_price_millions)

cor(painting2$Entropy.Values, painting2$estimated_price_millions)

plot(painting2$Number.of.Colors, painting2$estimated_price_millions)

cor(painting2$Number.of.Colors, painting2$estimated_price_millions)

  ### exponential 

painting2model <- lm(estimated_price_millions ~ poly(Entropy.Values, 4, raw = TRUE) + 
                                               poly(Number.of.Colors, 2, raw=TRUE), 
                                               data = painting2)
summary(painting2model)

  # final model

# widehat(estimated_millions) = 785.3 - 1201x + 469.3x^2 - 67.73x^3 + 3.312x^4 + 0.001568x - 9.101e-09x^2
# widehat(estimated_millions) = 785.3 - 1201(Entropy) + 469.3(Entropy)^2 - 67.73(Entropy)^3 + 3.312(Entropy)^4 + 0.001568(Colors) - 9.101e-09(Colors)^2

  # influence/outliers
influencePlot(painting2model,fill=F)

### RMSE

painting2model_RMSE <- sqrt(mean(painting2model$residuals^2))
painting2model_RMSE

  ### helpful links

#http://sthda.com/english/articles/40-regression-analysis/162-nonlinear-regression-essentials-in-r-polynomial-and-spline-regression-models/