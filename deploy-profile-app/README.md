# Deploy Profile App

## setup gcloud

set project id and region as variables.

```sh
PROJECT_ID=<project-id>
REGION=asia-southeast1
```

set project id as default project.

```sh
gcloud config set project $PROJECT_ID
```

## create a storage bucket and upload assets

set `BUCKET_NAME` variable and create a storage bucket with specified region.

```sh
BUCKET_NAME=$PROJECT_ID-assets
gcloud storage buckets create gs://$BUCKET_NAME --location=$REGION

```

make the bucket accessible to public.

```sh
gcloud storage buckets add-iam-policy-binding gs://$BUCKET_NAME \
  --member=allUsers \
  --role=roles/storage.objectViewer
```

copy all assets to bucket.

```sh
gcloud storage cp ./public/assets/*.{(jp|p)g,svg} gs://$BUCKET_NAME
```

## create and deploy the app

create app engine with specified region.

```sh
gcloud app create --region=$REGION
```

before deploy the app, make sure to update url of the assets with the bucket url in `index.html`.

```sh
sudo apt-get install google-cloud-sdk-app-engine-go -y
gcloud app deploy
```
