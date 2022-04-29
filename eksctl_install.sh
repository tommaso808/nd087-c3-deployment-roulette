#!/bin/bash

#aws eks --region us-east-2 update-kubeconfig --name udacity-cluster
#kubectl config use-context <cluster_name>
#kubectl config view | grep '\- name'| awk '{  print $3 }'
#arn:aws:eks:us-east-2:139802095464:cluster/udacity-cluster
#kubectl create namespace udacity

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /home/cloudshell-user/bin
eksctl utils associate-iam-oidc-provider --cluster udacity-cluster --approve --region=us-east-2

eksctl create iamserviceaccount --name cluster-autoscaler --namespace kube-system --cluster udacity-cluster --attach-policy-arn "arn:aws:iam::757851765448:policy/udacity-k8s-autoscale" --approve --region us-east-2
