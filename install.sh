#!/bin/bash

sudo apt-get update
sudo apt-get install -y unzip 

sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

echo "<h1>Nginx installed and running<h1>" | sudo tee /var/www/html/index.html

sudo apt-get install docker.io -y

sudo gpasswd -a docker ubuntu
newgrp docker

