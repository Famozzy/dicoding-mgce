#!/bin/bash

sudo apt update -y

sudo apt install -y lsb-release ca-certificates apt-transport-https software-properties-common gnupg2
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/sury-php.list
curl -fsSL  https://packages.sury.org/php/apt.gpg| sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg

sudo apt update -y

sudo apt install -y git php8.1 php8.1-mysql

exit 1 # comment or remove this line to continue

FE_BASE_URL=http://<FE_IP>
BE_BASE_URL=http://<BE_IP>

git clone -b money-tracker https://github.com/dicodingacademy/a133-gcp-labs.git app

sudo chmod 777 app/*

sed -i "s/\/\/ \$config\['base_url'\] = 'base_url_frontend_Anda';/\$config\['base_url'\] = '$FE_BASE_URL';/g" app/application/config/config.php
sed -i "s/base_url_backend_Anda/$BE_BASE_URL/g" app/application/models/Record_model.php

cd app

sudo php -S 0.0.0.0:80
