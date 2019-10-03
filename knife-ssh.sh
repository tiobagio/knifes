#!/bin/sh

knife ssh "name:bca1_rhel75" -x ec2-user -i ~/.ssh/bagio-training.pem "sudo chef-client"
