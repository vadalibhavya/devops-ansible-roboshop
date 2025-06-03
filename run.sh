#!/bin/bash

PASSWORD="DevOps321"
USER="ec2-user"
DOMAIN="doubtfree.online"

services=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")

for service in "${services[@]}"; do
  echo "Connecting to $service"

  sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no "$USER@$service.$DOMAIN" 'bash -s' <<EOF
  cd /home/ec2-user
  sudo dnf install ansible -y
  if [ ! -d "devops-ansible-roboshop" ]; then
    git clone https://github.com/vadalibhavya/devops-ansible-roboshop.git
  fi
  cd devops-ansible-roboshop
  git pull
  ansible-playbook -i inventory.ini -e ansible_user=ec2-user -e ansible_password=DevOps321 $service.yaml
EOF

done