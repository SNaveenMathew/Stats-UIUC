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
from pyspark.ml.linalg import Vectors
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.clustering import KMeans

# Reading the data set
cluster_df = spark.read.csv("./Exercise Files/Ch03/03_02/clustering_dataset.txt", header = True, inferSchema = True)

# Examining the data frame
print(cluster_df.schema)
cluster_df.printSchema()
print(cluster_df.columns)

# VectorAssembler for transformation
vectorAssembler = VectorAssembler(inputCols = ["col1", "col2", "col3"], outputCol = "features")
vectorized_cluster_df = vectorAssembler.transform(cluster_df)

# K-means clustering
kmeans = KMeans().setK(3).setSeed(1)
kmeans_model = kmeans.