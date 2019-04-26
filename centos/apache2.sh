#!/bin/bash -eu

sudo yum clean all
sudo yum -y install httpd
echo $1 | sudo tee /var/www/html/index.html

sudo systemctl enable httpd
sudo systemctl start httpd
