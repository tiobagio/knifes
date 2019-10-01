#!/bin/sh

knife ssh "name:*oracle76" -x ec2-user -i ~/.ssh/bagio-training.pem "sudo chef-client"
