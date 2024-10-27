# Money Tracker App

> still in development

## enable necessary services

```sh
PROJECT_ID=<project_id>
```

```sh
gcloud config set project $PROJECT_ID
gcloud config set compute/zone us-central1-a
```

```sh
gcloud services enable \
  compute.googleapis.com \
  iam.googleapis.com \
  cloudresourcemanager.googleapis.com \
  sqladmin.googleapis.com
```

## create service account for terraform

> NOTE: skip this step if you run terraform in cloud shell

```sh
gcloud iam service-accounts create terraform --description="Terraform service account"
gcloud projects add-iam-policy-binding $PROJECT_ID  \
  --member="serviceAccount:terraform@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/owner"
```

download the key file and place it in same directory as `main.tf`

```sh
gcloud iam service-accounts keys create credentials.json \
  --iam-account=terraform@$PROJECT_ID.iam.gserviceaccount.com
```

## run terraform

> NOTE: if you are running terraform in cloud shell, you need to comment out the `credentials` in line 2 of `main.tf`.

run the following command to initialize terraform.

```sh
terraform init
```

run the following command to create the resources, it will prompt you to enter the project id.

```sh
terraform apply
```

## post terraform setup

go to cloud shell.

run the following command to create the database table.

```sh
sudo apt update -y && sudo apt install mysql-client -y
mysql -h <sql_instance_ip> -u root -p
```

```sql
CREATE TABLE records (
    id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(25) NOT NULL,
    amount DOUBLE NOT NULL,
    date DATETIME NOT NULL,
    notes TEXT,
    attachment VARCHAR(255)
);
```

```sh
gcloud iam service-accounts keys create serviceaccountkey.json \
  --iam-account=gcs-sa@$DEVSHELL_PROJECT_ID.iam.gserviceaccount.com
```

copy the key file to the backend server

```sh
gcloud compute scp serviceaccountkey.json backend:/tmp/serviceaccountkey.json
```
