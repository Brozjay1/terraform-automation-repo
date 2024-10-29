### A simple Terraform Configuration File for Load balancing & Auto Scaling for a Static Web.

#This configuration file perform an automation:
- Creating a AWS EC2 Instances
- a key pair to connect to the instances
- attach it to internet gateway and security group
- install apache2 in the instance to host the static web app
- clone a static web app from github repo using `user data`
- remove and adjust the `index.html` file
- add a target group and a load balancer
- add an auto scaling group and create instances template
- it makes sure all services are attached together as neccessary for effective performance


