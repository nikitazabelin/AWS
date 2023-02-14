import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job


args = getResolvedOptions(sys.argv, ['YOUR_JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['YOUR_JOB_NAME'], args)

# Load the first CSV file from S3
table1 = glueContext.create_dynamic_frame.from_options(
    "s3",
    {
        "paths": ["s3://<bucket_name>/<folder_name>/<table1>.csv"],
        "format": "csv",
        "header": "true"
    },
    format="csv"
)

# Load the second CSV file from S3
table2 = glueContext.create_dynamic_frame.from_options(
    "s3",
    {
        "paths": ["s3://<bucket_name>/<folder_name>/<table2>.csv"],
        "format": "csv",
        "header": "true"
    },
    format="csv"
)

# Convert the dynamic frames to Spark data frames
table1_df = table1.toDF()
table2_df = table2.toDF()

# Merge the two Spark data frames
merged_table_df = table1_df.join(table2_df, table1_df.id == table2_df.id, "inner")

# Write the merged data frame back to S3 as a single CSV file
merged_table_df.write.format("csv").option("header", "true").mode("overwrite").save("s3://<bucket_name>/merged_table.csv")

# Load the merged table into Redshift
redshift_url = "jdbc:redshift://<redshift_cluster_endpoint>:5439/<database_name>"
redshift_user = "<user>"
redshift_password = "<password>"

merged_table_df.write.format("jdbc").option("url", redshift_url).option("dbtable", "merged_table").option("user", redshift_user).option("password", redshift_password).mode("overwrite").save()

job.commit()