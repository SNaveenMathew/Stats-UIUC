# Setting up Spark
with open("setupPySpark.py", "r") as setup_file:
    exec(setup_file.read())

# Spark context
from pyspark.sql.session import SparkSession
spark = SparkSession(sc)

# SQL context
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)

# Loading required packages
from pyspark.sql.functions import *
from pyspark.ml.feature import VectorAssembler, StringIndexer

iris_df = spark.read.csv("iris.data", inferSchema = True)
# Assigning column names (long way)
iris_df = iris_df.select(col("_c0").alias("sepal_length"),
col("_c1").alias("sepal_width"),
col("_c2").alias("petal_length"),
col("_c3").alias("petal_width"),
col("_c4").alias("species")
)
print(iris_df.take(1))

# Creating feature vectors
vectorAssembler = VectorAssembler(inputCols = ["sepal_length", "sepal_width", "petal_length", "petal_width"], outputCol = "features")
vectorized_iris_df = vectorAssembler.transform(iris_df)
print(vectorized_iris_df.take(1))

# StringIndexer is not working for some reason
indexer = StringIndexer(inputCol = "species", outputCol = "label")
# indexed_vectorized_iris_df = indexer.fit(vectorized_iris_df).transform(vectorized_iris_df)
# print(indexed_vectorized_iris_df.take(1))

# Naive Bayes model
from pyspark.ml.classification import NaiveBayes
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

splits = indexed_vectorized_iris_df.randomSplit([0.6, 0.4], 1)
train_df = splits[0]
test_df = splits[1]

nb = NaiveBayes(modelType = "multinomial")
nb_model = nb.fit(train_df)
nb_predictions_df = nb_model.transform(test_df)
nb_predictions_df.take(1)

nb_evaluator = MulticlassClassificationEvaluator(labelCol = "label", predictionCol = "prediction", metricName = "accuracy")
nb_accuracy = nb_evaluator.evaluate(nb_predictions_df)
print(nb_accuracy)

# Multi layer perceptron
from pyspark.ml.classification import MultilayerPerceptronClassifier
layers = [4, 5, 5, 3] # 4 layer MLP -> 2 excluding input and output

mlp = MultilayerPerceptronClassifier(layers = layers, seed = 1)
mlp_model = mlp.fit(train_df)
mlp_predictions = mlp_model.transform(test_df)
mlp_evaluator = MulticlassClassificationEvaluator(metricName = "accuracy")
mlp_accuracy = mlp_evaluator.evaluate(mlp_predictions)
print(mlp_accuracy)

# Decision trees
from pyspark.ml.classification import DecisionTreeClassifier

dt = DecisionTreeClassifier(labelCol = "label", featuresCol = "features")
dt_model = dt.fit(train_df)
dt_predictions = dt_model.transform(test_df)
dt_evaluator = MulticlassClassificationEvaluator(metricName = "accuracy", labelCol = "label", predictionCol = "prediction")
dt_accuracy = dt_evaluator.evaluate(dt_predictions)
print(dt_accuracy)