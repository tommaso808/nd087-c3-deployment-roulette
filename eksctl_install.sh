#!/bin/bash

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /home/cloudshell-user/bin
eksctl utils associate-iam-oidc-provider --cluster udacity-cluster --approve --region=us-east-2