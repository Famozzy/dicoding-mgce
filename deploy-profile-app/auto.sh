#!/bin/bash

read -p "Enter your project id: " PROJECT_ID

BUCKET_NAME=$PROJECT_ID-assets
REGION=asia-southeast1

gcloud config set project $PROJECT_ID

gcloud storage buckets create gs://$BUCKET_NAME --location=$REGION

gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME \
  --member=allUsers \
  --role=roles/storage.objectViewer

gcloud storage cp ./public/assets/* gs://$BUCKET_NAME

sed -i "s/\.\/assets/https:\/\/storage.googleapis.com\/$BUCKET_NAME/g" ./public/index.html

gcloud app create --region=$REGION

sleep 15

sudo apt-get install google-cloud-sdk-app-engine-go -y
gcloud app deploy
