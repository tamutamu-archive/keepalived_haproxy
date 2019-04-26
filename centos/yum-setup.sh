#!/bin/bash

sudo sed -i.bak -e 's/^mirrorlist=/#mirrorlist=/' -e 's/^#baseurl=/baseurl=/' /etc/yum.repos.d/CentOS-Base.repo
sudo yum clean all
