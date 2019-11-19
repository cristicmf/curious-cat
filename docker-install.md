

### 安装 Docker

1、卸载老版本：
```
#清理docker
$ yum remove docker \
docker-client \
docker-client-latest \
docker-common \
docker-latest \
docker-latest-logrotate \
docker-logrotate \
docker-selinux \
docker-engine-selinux \
docker-engine

$ rm -rf /usr/lib/systemd/system/docker.service.d \
  /home/lib/docker \
  /var/run/docker

#清理flanneld
$ rm -rf /usr/lib/systemd/system/flanneld.service \
  /usr/bin/flanneld \
  /etc/sysconfig/flanneld

#清理kube*
$ rm -rf /usr/lib/systemd/system/kube* \
  /etc/sysconfig/kube* \
  /usr/bin/kube* \
  /usr/local/bin/kube* \
  /var/lib/kubelet
```

2、安装新版本：
```
$ yum install -y container-selinux-2.74-1.el7.noarch.rpm
$ yum install -y pigz-2.3.3-1.el7.centos.x86_64.rpm
$ yum install -y containerd.io-1.2.0-3.el7.x86_64.rpm
$ yum install -y docker-ce-cli-18.09.0-3.el7.x86_64.rpm
$ yum install -y docker-ce-18.09.0-3.el7.x86_64.rpm
```

3、配置
```
$ vi /usr/lib/systemd/system/docker.service

# 修改前
ExecStart=/usr/bin/dockerd -H unix://

# 修改后
EnvironmentFile=-/run/flannel/docker
ExecStart=/usr/bin/dockerd --selinux-enabled --graph=/home/lib/docker -H unix:// $DOCKER_NETWORK_OPTIONS
 ```

4、启动docker服务并查看docker版本
```
$ systemctl enable docker && systemctl daemon-reload
$ systemctl start docker


$ docker -v
Docker version 18.09.0, build 4d60db4
```

