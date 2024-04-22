#!/usr/bin/env bash
aws --endpoint-url=http://localhost:4566 sqs list-queues

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name QueueTestName