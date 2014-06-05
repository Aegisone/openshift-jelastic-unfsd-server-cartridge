#!/bin/bash -e

function _deploy(){

  rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt
  rpm -Uvh http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
  
  yum -y install rpcbind unfs3
  chkconfig unfsd on
  chkconfig rpcbind on
  
  service rpcbind start
  service unfsd start

  cat << EOF > /etc/exports
  # Place your shares here
  # Format:
  # /path/to/share	1.2.3.4(rw,no_root_squash)
  EOF

  cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF

  yum -y install nginx

  mkdir -p /var/www/webroot

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/generic.conf.sample
  
  cat << EOF > /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  localhost;

    charset utf-8;

    location / {
        root   /var/www/webroot;
        index  index.html index.htm;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    location ~ /\.ht {
        deny  all;
    }
}
EOF

  service nginx restart
}

function _undeploy(){
}
