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
cluster_df = spark.read.csv("./Exercise_Files/Ch03/03_02/clustering_dataset.csv", header = True, inferSchema = True)

# Examining the data frame
print(cluster_df.schema)
cluster_df.printSchema()
print(cluster_df.columns)

# VectorAssembler for transformation
vectorAssembler = VectorAssembler(inputCols = ["col1", "col2", "col3"], outputCol = "features")
vectorized_cluster_df = vectorAssembler.transform(cluster_df)
print(vectorized_cluster_df.select(["features"]).show())
print(vectorized_cluster_df.take(1))

# K-means clustering - not working for some reason!
# kmeans = KMeans().setK(3).setSeed(1)
# kmeans_model = KMeans.fit(vectorized_cluster_df.select("features"), 3, maxIterations = 10, initializationMode = "random")
# km_centers = kmeans_model.clusterCenters()

# Hierarchical clustering (Bisecting K-means) - not working for same reason as KMeans
from pyspark.ml.clustering import BisectingKMeans
bkmeans = BisectingKMeans().setK(3).setSeed(1)
# bk_model = bkmeans.fit(vectorized_cluster_df)
# bk_centers = bk_model.fit(vectorized_cluster_df)