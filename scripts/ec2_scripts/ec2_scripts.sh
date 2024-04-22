#!/usr/bin/env bash
aws --endpoint-url=http://localhost:4566 ec2 run-instances \
 --image-id ami-12345678 \
 --instance-type t2.micro \
 --associate-public-ip-address

aws --endpoint-url=http://localhost:4566 ec2 describe-instances