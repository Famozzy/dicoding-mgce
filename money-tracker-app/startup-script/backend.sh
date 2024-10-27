#!/bin/bash

sudo apt update -y
sudo apt install -y nginx nodejs npm git

exit 1 # comment or remove this line to continue

git clone -b money-tracker-api https://github.com/dicodingacademy/a133-gcp-labs.git app

PROJECT_ID=<PROJECT_ID>
BUCKET_NAME=<BUCKET_NAME>

PUBLIC_IP_SQL=<PUBLIC_IP_SQL>
DB_NAME=mt_db
DB_PASS=password

sed -i "s/project_id_Anda/$PROJECT_ID/g" app/modules/imgUpload.js
sed -i "s/nama_GCS_bucket_Anda/$BUCKET_NAME/g" app/modules/imgUpload.js

sed -i "s/public_ip_sql_instance_Anda/$PUBLIC_IP_SQL/g" app/routes/record.js
sed -i "s/nama_database_Anda/$DB_NAME/g" app/routes/record.js
sed -i "s/password_sql_Anda/$DB_PASS/g" app/routes/record.js

sudo chmod 777 /etc/nginx/sites-available/default

cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    server_name _;

    location / {
        proxy_pass http://localhost:8000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
    }
}
EOF

sudo systemctl restart nginx

npm install -g pm2

mv /tmp/serviceaccountkey.json app/serviceaccountkey.json

cd app

pm2 start -i max npm -- start

