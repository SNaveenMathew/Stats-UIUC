# Setting up Spark
with open("setupPySpark.py", "r") as setup_file:
    exec(setup_file.read())

# Spark context
from pyspark.sql.session import SparkSession
spark = SparkSession(sc)

# SQL context
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)

pp_df = spark.read.csv("Folds5x2_pp.csv", inferSchema = True, header = True)

# Creating feature vectors
from pyspark.ml.feature import VectorAssembler
vectorAssembler = VectorAssembler(inputCols = ["AT", "V", "AP", "RH"], outputCol = "features")
vectorized_pp_df = vectorAssembler.transform(pp_df)
print(vectorized_pp_df.take(1))

# Linear regression
from pyspark.ml.regression import LinearRegression

lr = LinearRegression(featuresCol = "features", labelCol = "PE")
lr_model = lr.fit(vectorized_pp_df)
# lr_predictions = lr_model.transform()
print(lr_model.coefficients)
print(lr_model.intercept)
print(lr_model.summary.rootMeanSquaredError)

# Decision tree regressor
from pyspark.ml.regression import DecisionTreeRegressor
from pyspark.ml.evaluation import RegressionEvaluator

splits = vectorized_pp_df.randomSplit([0.7, 0.3], seed = 1)
train_df = splits[0]
test_df = splits[1]

dt = DecisionTreeRegressor(featuresCol = "features", labelCol = "PE")
dt_model = dt.fit(train_df)
dt_predictions = dt_model.transform(test_df)
dt_evaluator = RegressionEvaluator(labelCol = "PE", predictionCol = "prediction", metricName = "rmse")
print(dt_evaluator.evaluate(dt_predictions))

# Gradient boosting tree regressor
from pyspark.ml.regression import GBTRegressor

gbt = GBTRegressor(featuresCol = "features", labelCol = "PE")
gbt_model = gbt.fit(train_df)
gbt_predictions = gbt_model.transform(test_df)
gbt_evaluator = RegressionEvaluator(labelCol = "PE", predictionCol = "prediction", metricName = "rmse")
print(gbt_evaluator.evaluate(gbt_predictions))
