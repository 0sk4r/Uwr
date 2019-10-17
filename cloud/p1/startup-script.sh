#!/bin/bash

sudo apt-get update && sudo apt-get install apache2 -y
echo '<!doctype html><html><body><h1>Testowa strona</h1></body></html>' | sudo tee /var/www/html/index.html
sudo service apache2 start
