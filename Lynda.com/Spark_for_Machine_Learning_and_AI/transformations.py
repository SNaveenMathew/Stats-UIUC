# Setting up Spark
with open("setupPySpark.py", "r") as setup_file:
    exec(setup_file.read())

# Spark context
from pyspark.sql.session import SparkSession
spark = SparkSession(sc)

# SQL context
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)

# Creating a new data frame
from pyspark.ml.linalg import Vectors

features_df = spark.createDataFrame([
    (1, Vectors.dense([10.0, 10000.0, 1.0]),),
    (2, Vectors.dense([20.0, 30000.0, 2.0]),),
    (3, Vectors.dense([30.0, 40000.0, 3.0]),)
], ["id", "features"])
print(features_df.take(1))

# Reading the data set
emp_df = spark.read.csv("./Exercise Files/Ch01/01_04/employee.txt", header=True)

# Examining the data frame
print(emp_df.schema)
emp_df.printSchema()
print(emp_df.columns)

# Choosing first 5 employees
print(emp_df.take(5))

# Number of rows
print(emp_df.count())

# Sampling
sample_df = emp_df.sample(False, 0.1) # Takes approx 10% sample

# Filtering
emp_mgr_df = emp_df.filter("salary >= 100000")
print(emp_mgr_df.count())

# Choosing one column
print(emp_mgr_df.select("salary").show())

# Data transformations

# Normalization
from pyspark.ml.feature import MinMaxScaler

feature_scaler = MinMaxScaler(inputCol = "features", outputCol = "normalized_features")
normalized_model = feature_scaler.fit(dataset = features_df)
normalized_features_df = normalized_model.transform(features_df)
print(normalized_features_df.take(1))

# Standardization
from pyspark.ml.feature import StandardScaler

feature_scaler = StandardScaler(inputCol = "features", outputCol = "scaled_features", withStd = True, withMean = True)
std_model = feature_scale.fit(features_df)
scaled_feature_df = std_model.transform(features_df)
print(scaled_feature_df.take(1))

# Bucketing
from pyspark.ml.feature import Bucketizer
splits = [-float("inf"), -10.0, 0.0, 10.0, float("inf")]
b_data = [(900.0,), (-100.0,), (132.0,)]
b_df = spark.createDataFrame(b_data, ["features"])
b_df.show()

bucketizer = Bucketizer(splits = splits, inputcompile = "features", outputCol = "bucketized_features")
bucketed_df = bucketizer.transform(features_df)

# Text tokenization
from pyspark.ml.feature import Tokenizer

sentence_df = spark.createDataFrame([
    (1, "Introduction to Spark MLlib"),
    (2, "MLlib includes libraries for classification and regression"),
    (3, "Also supports pipelines")
], ["id", "sentence"])

sent_tokenizer = Tokenizer(intpuCol = "sentneces", outputCol = "words")
sent_tokenized_df = sent_tokenizer.transform(sentence_df)

print(sent_tokenized_df.show())

# TF-IDF
from pyspark.ml.feature import HashingTF, IDF

# TF
hashingTF = HashingTF(inputCol = "words", outputCol = "raw_features", numFeatures = 20)
sent_hf_tf_df = hashingTF.transform(sent_tokenized_df)
print(sent_hf_tf_df.take(1))

# IDF
idf = IDF(inputCol = "raw_features", outputCol = "idf_features")
idf_model = idf.fit(sent_hf_tf_df)
tf_idf_df = idf_model.transform(sent_hf_tf_df)