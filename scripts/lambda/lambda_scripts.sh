#!/usr/bin/env bash
aws --endpoint-url=http://localhost:4566 lambda list-functions

aws --endpoint-url=http://localhost:4566 lambda list-functions \
    --query "Functions[*].FunctionName" \
    --output text


aws --endpoint-url=http://localhost:4566 lambda create-function \
  --function-name nodejs-test-lambda \
  --code S3Bucket="hot-reload",S3Key="$(pwd)/src/" \
  --handler index.handler \
  --runtime nodejs18.x \
  --timeout 10 \
  --role arn:aws:iam::000000000000:role/lambda-role 

aws --endpoint-url=http://localhost:4566 lambda get-function --function-name nodejs-test-lambda


aws --endpoint-url=http://localhost:4566 --debug  lambda invoke --cli-read-timeout 0 --cli-connect-timeout 0 \
  --cli-binary-format raw-in-base64-out \
  --function-name arn:aws:lambda:us-east-1:000000000000:function:nodejs-test-lambda \
  --invocation-type RequestResponse \
  --payload '{"hello":"world"}' \
  response.json
# bucket name = static-data-bucket
# lambda name = nodejs-test-lambda
aws --endpoint-url=http://localhost:4566 s3api put-bucket-notification-configuration \
  --bucket static-data-bucket \
  --notification-configuration '{"LambdaFunctionConfigurations":[{"LambdaFunctionArn":"arn:aws:lambda:us-east-1:000000000000:function:nodejs-test-lambda","Events":["s3:ObjectCreated:*"]}]}'


aws --endpoint-url http://localhost:4566 cloudformation create-stack \
    --stack-name my-ec2-stack \
    --template-body file://template.yml 
