#!/bin/bash -eu


sudo apt -y install keepalived
sudo systemctl enable keepalived
sudo systemctl start keepalived


cat >> /etc/sysctl.conf <<EOD

net.ipv4.ip_forward = 1
net.ipv4.ip_nonlocal_bind=1
EOD
sysctl -p


cat > /etc/keepalived/keepalived.conf <<EOD
virtual_server 192.168.1.200 80 {
  delay_loop 3
  lvs_sched wrr
  lvs_method NAT
  protocol TCP
  sorry_server 192.168.1.13 80

  real_server 192.168.1.11 80 {
    weight 1
    inhibit_on_failure
    TCP_CHECK {
      connect_port 80
      connect_timeout 3
      retry 3
      delay_before_retry 3
    }
  }

  real_server 192.168.1.12 80 {
    weight 1
    inhibit_on_failure
    TCP_CHECK {
      connect_port 80
      connect_timeout 3
      retry 3
      delay_before_retry 3
    }
  }
}

vrrp_instance VI_1 {
  interface enp0s8
  state MASTER
  virtual_router_id 51
  priority 11
  virtual_ipaddress {
    192.168.1.200
  }
}
EOD

/etc/init.d/keepalived restart

