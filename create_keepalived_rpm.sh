#!/bin/bash

sudo yum clean all
sudo yum -y install \
  rpm-build openssl-devel libnl3-devel ipset-devel iptables-devel libnfnetlink-devel file-devel net-snmp-devel glib2-devel json-c-devel pcre2-devel libnftnl-devel libmnl-devel automake


mkdir -p ~/rpmbuild/SOURCES


./build_setup
./configure
sed -i.bak \
  -e 's/^\(Requires: iptables-libs\)$/##\1/' \
  -e 's/^\(Release: 1\)$/\1_hydra/' \
  ./keepalived.spec

make rpm

echo
echo
echo "Ther is rpm below path."
echo "  ${HOME}/rpmbuild/RPMS/x86_64/"
echo "Install."
echo "  sudo yum -y localinstall keepalived-2.0.12-1_hydra.x86_64.rpm"
