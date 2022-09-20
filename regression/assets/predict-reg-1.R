#!/usr/bin/env Rscript

library(jsonlite)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("Insufficient arguments.", call. = FALSE)
}

data <- fromJSON(args[1])

#data <- fromJSON('[[52.3, 6.1, 1.4, 2,"setosa"], [1000, 6.1, 13.4, 0,"setosa"]]')

df <- data.frame(data)

colnames(df) <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width","Species")

df$Sepal.Length <- as.numeric(df$Sepal.Length)
df$Sepal.Width <- as.numeric(df$Sepal.Width)
df$Petal.Length <- as.numeric(df$Petal.Length)
df$Petal.Width <- as.numeric(df$Petal.Width)
df$Species <- as.character(df$Species)

model <- readRDS('iris_lr-1.model')

df$prediction <- predict(model, df)

toJSON(df)

