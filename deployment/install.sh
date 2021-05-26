#!/bin/bash

./deployment/webhook-create-signed-cert.sh --service lxcfs-webhook --namespace lxcfs --secret lxcfs-webhook
kubectl get secret lxcfs-webhook -n lxcfs

kubectl create -f deployment/deployment.yaml
kubectl create -f deployment/service.yaml
cat ./deployment/mutatingwebhook.yaml | ./deployment/webhook-patch-ca-bundle.sh > ./deployment/mutatingwebhook-ca-bundle.yaml
kubectl create -f deployment/mutatingwebhook-ca-bundle.yaml

