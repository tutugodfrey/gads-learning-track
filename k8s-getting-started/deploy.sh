#! /bin/bash

gcloud container clusters create webfrontend --zone MY_ZONE --num-nodes=NUM_NODES

# Launch an instance of nginx container
kubectl create deploy nginx --image=nginx:1.17.10

echo $(kubectl get pods)

# Expose the nginx deployment
kubectl expose deployment nginx --port 80 --type loadBalancer

echo $(kubectl get services)

# scale the deployment
echo "Script paused until you are ready to scale the deployment"
echo "Would you like to scale the deployment now?"
read -s -p "Enter yes to scale  : " answer

if [[ $answer=='yes' ]] then;
  kubectl scale deployment nginx --replicas 3
fi

echo $(kubectl get pods)

echo $(kubectl get services)
