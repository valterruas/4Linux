#!/bin/bash
mkdir -p /root/.ssh
cp /vagrant/files/key.pub /root/.ssh/authorized_keys
yum install -y curl vim device-mapper-persistent-data lvm2 epel-release wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct docker-1.13.1-75.git8633870.el7.centos
HOSTS="$(head -n3 /etc/hosts)"
echo -e "$HOSTS" > /etc/hosts
echo -e '192.168.1.10 master.kubernetes.os\n192.168.1.20 node1.kubernetes.os\n192.168.1.30 node2.kubernetes.os' > /etc/hosts
systemctl start docker
docker pull docker.io/cockpit/kubernetes
docker pull docker.io/openshift/origin-deployer:v3.11
docker pull docker.io/openshift/origin-docker-registry:v3.11
docker pull docker.io/openshift/origin-haproxy-router:v3.11
docker pull docker.io/openshift/origin-pod:v3.11
if [ "$HOSTNAME" == "master.kubernetes.os" ]; then
    sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
    yum -y --enablerepo=epel install ansible pyOpenSSL
    cp /vagrant/files/hosts /etc/ansible/hosts
    cp /vagrant/files/key /root/.ssh/id_rsa; chmod 400 /root/.ssh/id_rsa 
    cp /vagrant/files/key.pub /root/.ssh/id_rsa.pub
    sed -i -e "s/#host_key_checking/host_key_checking/" /etc/ansible/ansible.cfg
    sed -i -e "s@#private_key_file = /path/to/file@private_key_file = /root/.ssh/id_rsa@" /etc/ansible/ansible.cfg
fi
