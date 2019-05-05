## 脚本化一键部署
### Docker
- install Docker

参照官网

- install kubernetes

安装kubernetes的时候，需要安装kubelet, kubeadm等包，但k8s官网给的yum源是packages.cloud.google.com，国内访问不了，此时我们可以使用阿里云的yum仓库镜像。

阿里云上没有附Help说明连接，简单摸索了下，如下设置可用（centos）。注意不要开启check。
```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
```


---
###  开发思路
```
1 寻找基础镜像
2 基于基础镜像编写Dockerfile脚本
3 根据Dockerfile脚本创建项目镜像
4 将创建的镜像推送到docker仓库 (根据自身需要，可做可不做)
5 基于项目镜像创建并运行docker容器 (实现最终部署)
```

思路：使用 centos 容器安装对应的软件环境，最后将环境导出。

#### 操作步骤

- 创建容器
```
$ docker pull centos    
$ sudo docker run --privileged --cap-add SYS_ADMIN -e container=docker -it --name my_centos -p 80:8080  -d  --restart=always centos:7 /usr/sbin/init 
```

- 启动容器
```
$ docker exec -it my_centos /bin/bash
```

- 导出和导入
```
$ docker export my_centos > /data/app/meifen/my_centos-export-0428.tar

$ docker import  /data/app/meifen/my_centos-export-0428.tar

```

- 保存save 

格式：docker save IMAGE(镜像)

使用 docker images 查看本机已有的镜像（也可以使用 docker commit <CONTAIN-ID> <IMAGE-NAME>命令把一个正在运行的容器保存为镜像）
        
```
$ docker save 9610cfc68e8d > /data/app/meifen/my_centos-export-0428.tar
```
- 加载 load
有点慢，稍微等待一下，没有任何warn信息就表示保存OK。9610cfc68e8d 是镜像ID
 

现在就可以在任何装 docker 的地方加载 刚保存的镜像了

```
$ docker load < /home/my_centos-export-0428.tar
```


镜像和容器 导出和导入的区别

1 容器导入 是将当前容器变成一个新的镜像
2 镜像导入 是复制的过程

save 和 export区别

1 save 保存镜像所有的信息-包含历史
2 export 只导出当前的信息

说明： export导出的镜像文件大小  小于 save保存的镜像。export 导出（import导入）是根据容器拿到的镜像，再导入时会丢失镜像所有的历史，所以无法进行回滚操作（docker tag <LAYER ID> <IMAGE NAME>）；而save保存（load加载）的镜像，没有丢失镜像的历史，可以回滚到之前的层（layer）。（查看方式：docker images --tree） 。export 只导出当前的信息

---
### docker 常用命令

---
### docker 架构说明
![image](https://www.hi-linux.com/img/linux/docker-arch1.jpg)

[更多架构说明](https://www.hi-linux.com/posts/13732.html)

---
### ISSUE
- install kubernetes

安装kubernetes的时候，需要安装kubelet, kubeadm等包，但k8s官网给的yum源是packages.cloud.google.com，国内访问不了，此时我们可以使用阿里云的yum仓库镜像。

阿里云上没有附Help说明连接，简单摸索了下，如下设置可用（centos）。注意不要开启check。
```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```
