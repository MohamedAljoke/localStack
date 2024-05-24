npm init -y
npm i typescript --save-dev
npx tsc --init
npm install @types/node --save-dev
npm i ts-node-dev --save-dev
npm i serverless --save-dev
npx serverless plugin install -n serverless-localstack
npx serverless plugin install -n serverless-offline

aws --endpoint-url=http://localhost:4566 lambda list-functions \
    --query "Functions[*].FunctionName" \
    --output text
    
aws --endpoint-url=http://localhost:4566 s3 ls

aws --endpoint-url=http://localhost:4566 \
  s3api put-object \
  --bucket test-bucket-name \
  --key dummyfile.pdf --body=dummyfile.pdf

sls logs -t -f nodeLambdaHandler --stage local