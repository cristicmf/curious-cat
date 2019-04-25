### 参考文档 
https://buzheng.org/linux/how-to-install-and-use-docker-on-centos-7.html
http://rdc.hundsun.com/portal/article/576.html
https://www.itcodemonkey.com/article/914.html


Start DEMO

https://nodejs.org/en/docs/guides/nodejs-docker-webapp/



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
