#!/usr/bin/env bash
# list buckets
aws --endpoint-url=http://localhost:4566 s3 ls

# create bucket
aws --endpoint-url=http://localhost:4566 s3 mb s3://static-data-bucket

# make it public and add policy
aws --endpoint-url=http://localhost:4566 s3api put-public-access-block \
  --bucket static-data-bucket \
  --public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

aws --endpoint-url=http://localhost:4566 s3api put-bucket-policy --bucket static-data-bucket --policy "{
  \"Version\": \"2012-10-17\",
  \"Statement\": [
      {
          \"Sid\": \"PublicReadGetObject\",
          \"Effect\": \"Allow\",
          \"Principal\": \"*\",
          \"Action\": \"s3:GetObject\",
          \"Resource\": \"arn:aws:s3:::static-bucket-test/*\"
      }
  ]
}"

# send file to s3
aws --endpoint-url=http://localhost:4566 \
  s3api put-object \
  --bucket static-data-bucket \
  --key dummyfile.txt --body=dummyfile.txt

#check specific bucket 
aws --endpoint-url=http://localhost:4566 s3 ls s3://static-data-bucket