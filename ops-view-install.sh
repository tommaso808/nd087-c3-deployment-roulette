#!/bin/bash
helm repo add stable https://charts.helm.sh/stable
helm install kube-ops-view stable/kube-ops-view --set service.type=LoadBalancer --set rbac.create=True
kubectl get svc kube-ops-view | tail -n 1 | awk '{ print "Kube-ops-view URL = http://"$4 }'