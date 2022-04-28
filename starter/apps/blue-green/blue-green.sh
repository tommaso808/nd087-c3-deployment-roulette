#!/bin/bash

function deploy_app {
    kubectl apply -f index_$1_html.yml --namespace udacity
    
    ATTEMPTS=0
    ROLLOUT_STATUS_CMD="kubectl apply -f $1.yml --namespace udacity"
    until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
    $ROLLOUT_STATUS_CMD
    ATTEMPTS=$((attempts + 1))
    sleep 1
    done
    echo "$1 deployent successful!"

}


deploy_app green
deploy_app blue


