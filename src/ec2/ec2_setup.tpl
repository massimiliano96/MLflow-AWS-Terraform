#!/bin/bash

S3_BUCKET_NAME="${s3_bucket}"
DB_ENDPOINT="${db_endpoint}"
DB_NAME="${db_name}"
DB_USERNAME="${db_username}"
DB_PASSWORD="${db_password}"

touch /home/ubuntu/log-mlflow.txt
echo "mlflow server -h 0.0.0.0 -p 5000 --backend-store-uri postgresql://$DB_USERNAME:$DB_PASSWORD@$DB_ENDPOINT/$DB_NAME --default-artifact-root s3://$S3_BUCKET_NAME" > /home/ubuntu/log-mlflow.txt

sudo apt-get update
sudo apt-get install -y python3-pip
pip3 install mlflow psycopg2-binary
mlflow server -h 0.0.0.0 -p 5000 --backend-store-uri postgresql://$DB_USERNAME:$DB_PASSWORD@$DB_ENDPOINT/$DB_NAME --default-artifact-root s3://$S3_BUCKET_NAME




