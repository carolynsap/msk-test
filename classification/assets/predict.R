library(xgboost)
library(jsonlite)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("Insufficient arguments.", call. = FALSE)
}

data <- fromJSON(args[1])
df <- data.frame(data)
colnames(df) <- c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")

classes <- c("setosa", "versicolor", "virginica")
model <- xgb.load("iris_xgb-4.model")
pred <- predict(model, as.matrix(df), reshape=T)

pred <- as.data.frame(pred)
colnames(pred) <- classes

df <- cbind(df, pred)

df$probability <- apply(pred, 1, function(x) max(x))
df$prediction <- apply(pred, 1, function(x) colnames(pred)[which.max(x)])

toJSON(df)