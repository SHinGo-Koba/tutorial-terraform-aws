#!/bin/bash
sudo amazon-linux-extras install nginx1
sudo systemctl enable nginx
sudo systemctl start nginx.service
