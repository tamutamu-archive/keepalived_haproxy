#!/bin/bash -eu


sudo apt -y install haproxy


# Configure haproxy
cat > /etc/default/haproxy <<EOD
# Set ENABLED to 1 if you want the init script to start haproxy.
ENABLED=1
# Add extra flags here.
#EXTRAOPTS="-de -m 16"
EOD


cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.orig

cat > /etc/haproxy/haproxy.cfg <<EOD
global
    log 127.0.0.1   local0
    log 127.0.0.1   local1 notice
    daemon
    maxconn 256

defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    retries 3
    option redispatch
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms

frontend http-in
    bind *:80
    default_backend webservers

backend webservers
    mode http
    stats enable
    # stats auth admin:admin
    stats uri /haproxy?stats
    balance roundrobin
    balance roundrobin
    # Poor-man's sticky
    # balance source
    # JSP SessionID Sticky
    # appsession JSESSIONID len 52 timeout 3h
    option httpchk
    option forwardfor
    option http-server-close
    server web1 192.168.1.11:80 maxconn 32 check
    server web2 192.168.1.12:80 maxconn 32 check
EOD

/usr/sbin/service haproxy restart
