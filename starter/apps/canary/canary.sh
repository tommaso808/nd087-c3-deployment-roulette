#!/bin/bash



function do_canary_deploy {

    NUM_OF_V1_PODS=$(kubectl get pods -n udacity | grep -c canary-v1)
    kubectl apply -f canary-v2.yml

    sleep 1
    kubectl scale deployment canary-v2 --replicas=$NUM_OF_V1_PODS
    # Check deployment rollout status every 1 second until complete.
    ATTEMPTS=0
    ROLLOUT_STATUS_CMD="kubectl rollout status deployment/canary-v2 -n udacity"
    until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
       $ROLLOUT_STATUS_CMD
       ATTEMPTS=$((attempts + 1))
        sleep 1
    done

    NUM_OF_V1_PODS=$(kubectl get pods -n udacity | grep -c canary-v1)
    echo "V1 PODS: $NUM_OF_V1_PODS"
    NUM_OF_V2_PODS=$(kubectl get pods -n udacity | grep -c canary-v2)
    echo "V2 PODS: $NUM_OF_V2_PODS"

}

function ask_canary_deploy {
  read -p "Start 50% canary deployment? (y/n) " answer

    if [[ $answer =~ ^[Yy]$ ]] ;
    then
        echo "starting deployment"
        do_canary_deploy
    else
        exit
    fi
}

ask_canary_deploy

echo "Canary deployment of v2 successful"
