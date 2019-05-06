# 脚本化一键部署
## Docker
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



##  开发思路
```
1 寻找基础镜像
2 基于基础镜像编写Dockerfile脚本
3 根据Dockerfile脚本创建项目镜像
4 将创建的镜像推送到docker仓库 (根据自身需要，可做可不做)
5 基于项目镜像创建并运行docker容器 (实现最终部署)
```

思路：使用 centos 容器安装对应的软件环境，最后将环境导出。

### 操作步骤

1.  创建容器
```
$ docker pull centos    
$ sudo docker run --privileged --cap-add SYS_ADMIN -e container=docker -it --name my_centos -p 80:8080  -d  --restart=always centos:7 /usr/sbin/init 
```

2.  启动容器
```
$ docker exec -it my_centos /bin/bash
```

3.  导出和导入
```
$ docker export my_centos > /data/app/meifen/my_centos-export-0428.tar

$ docker import  /data/app/meifen/my_centos-export-0428.tar

```

4.  保存save 

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


**其他说明**
镜像和容器 导出和导入的区别

1 容器导入 是将当前容器变成一个新的镜像
2 镜像导入 是复制的过程

save 和 export区别

1 save 保存镜像所有的信息-包含历史
2 export 只导出当前的信息

export导出的镜像文件大小  小于 save保存的镜像。export 导出（import导入）是根据容器拿到的镜像，再导入时会丢失镜像所有的历史，所以无法进行回滚操作（docker tag <LAYER ID> <IMAGE NAME>）；而save保存（load加载）的镜像，没有丢失镜像的历史，可以回滚到之前的层（layer）。（查看方式：docker images --tree） 。export 只导出当前的信息

## 提交Docker-hub
1. 提交镜像
```
$ docker commit -a "cristic" -m "commit content"  801a40ffa673  cristicmei/name:v1.0.0
```

2. 查看镜像
```
$ docker images
```
3. 登录docker-hub
```
$ docker image
```
前提是用户有docker-hub的账号

4. 提交远程仓库
```
$ docker push cristicmei/name:v1.0.0
```
## 精简Docker镜像大小的必要性

Docker镜像由很多镜像层（Layers）组成（最多127层），镜像层依赖于一系列的底层技术，比如文件系统（filesystems）、写时复制（copy-on-write）、联合挂载（union mounts）等技术，可以查看Docker社区文档以了解更多有关Docker存储驱动的内容，这里不再赘述。总的来说，Dockerfile中的每条指令都会创建一个镜像层，继而会增加整体镜像的尺寸。

下面是精简Docker镜像尺寸的好处：
```
减少构建时间
减少磁盘使用量
减少下载时间
因为包含文件少，攻击面减小，提高了安全性
提高部署速度
```

- 最重要的因素是减少镜像的层数，这样能大大减小镜像的大小；

使用链式代码“&&”把多行指令结合成一行

- 清除 yum 缓存
```
$ yum clean headers
$ yum clean packages
$ yum clean all
```

- 清除无用的tar.gz安装包
- 选择更小的基础镜像

## docker 架构说明
![image](https://www.hi-linux.com/img/linux/docker-arch1.jpg)

[更多架构说明](https://www.hi-linux.com/posts/13732.html)




##  ISSUE

#### /var/lib/docker/overlay2 占用很大，清理Docker占用的磁盘空间，迁移 /var/lib/docker 目录

1.命令查看磁盘使用情况
```
$ du -hs /var/lib/docker/ 
```

用于查看Docker的磁盘使用情况
```
$ docker system df

```


2. 清理磁盘

```
$ docker system prune 
```
可以用于清理磁盘，删除关闭的容器、无用的数据卷和网络，以及dangling镜像(即无tag的镜像)。

```
$ docker system prune -a
```

3. 迁移 /var/lib/docker 目录


