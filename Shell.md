# 常用shell命令
## 网络
### 查看网络
```
$ netstat
$ netstat ip port
```
### 抓包

```
$ tcpdump -Xns0 port 9229
```
### 查看端口
```
$ ps -ef|grep port
$ lsof -i:port
```
### 查看外网ip
```
$ curl ifconfig.me/all.xml
```
---
## 文件
### md5sum文件校验
```
$ md5sum file
```
### 在线格式化文件
```
$ python -m json.tool somejson.txt
```

### 打包和压缩文件
#### zip
```
$ zip -r ./xahot.zip ./* -r表示递归
$ zip [参数] [打包后的文件名] [打包的目录路径]

$ zip –q –r xahot.zip /home/wwwroot/xahot
```

#### tar
```
$ tar zcvf FileName.tar.gz DirName
```

### 文件操作
```
$ tail -f 文件
```
---
## 系统相关
### 查看内存
```
$ df -h
$ du -sh *
```
### 分析内存
```
$ top
$ ps
```
### 查看僵尸进程
```
ps -ef|grep defunct
```

### 远程拷贝
scp [参数] [原路径] [目标路径]
```
$ scp -r file.tar.gz path
```

## 进程
### 查看进程所在目录
```
$ ll /proc/pid
```
## 用户分组和权限管理
### 创建用户
```
$ useradd testuser
```
### 给用户设置密码
```
$ passwd testuser 
```
### $PATH
$PATH：决定了shell将到哪些目录中寻找命令或程序，PATH的值是一系列目录，当您运行一个程序时，Linux在这些目录下进行搜寻编译链接。
#### 查看环境变量
```
$ echo $PATH
```
#### 添加环境变量
```
$ export PATH=/opt/STM/STLinux-2.3/devkit/sh4/bin:$PATH
```

###### 相关文件说明

- 与用户（user）相关的配置文件； /etc/passwd 注：用户（user）的配置文件； /etc/shadow 注：用户（user）影子口令文件；
- 与用户组（group）相关的配置文件； /etc/group 注：用户组（group）配置文件； /etc/gshadow 注：用户组（group）的影子文件 

---
## Vim
vim  技巧
- 格式化全文指令　　gg=G
- 自动缩进当前行指令　　==
- 格式化当前光标接下来的8行　　8=
- 格式化选定的行　　v 
- 选中需要格式化的代码段 =
- 
:$ 跳转到最后一行
:1 跳转到第一行
第二种方式

shift+g 跳转到最后一行
gg 跳转到第一行




---
ooooooo
方便日后用，主要是在my.ini文件中，配置skip-grant-tables,略过验证，然后再更新里面的密码设置。
具体步骤：
1、修改my.ini配置文件，添加skip-grant-tables
2、重启mysql服务
3、登录mysql，并设定新的密码
4、删除my.ini配置文件中的skip-grant-tables
5、重启mysql服务并登录

1. 修改my.ini配置文件，添加skip-grant-tables
```
#编辑mysql配置文件
vim /etc/my.cnf

#添加
skip-grant-tables
 ```
 
 2、重启mysql服务
```
service mysql restart

#新的mysql执行这个命令
systemctl restart mysqld.service 
```

3、登录mysql，并设定新的密码
```
#连接mysql，直接回车即可，不需要输入密码
mysql -u root -p

#更新root用户密码
update mysql.user set authentication_string=password('yellowcong') where user='root' and Host = 'localhost';

#刷新权限
flush privileges;

#推出mysql
exit   或者 quit

```
4、删除my.ini配置文件中的skip-grant-tables
```
vim /etc/my.cnf

#注释掉skip-grant-tables
```
5、重启mysql服务并登录

```
 service mysql restart
 mysql -uroot -pyellowcong
 ```

---
crudini
```
crudini --set [--existing] config_file section [param] [value]
crudini --get [--format=sh|ini] config_file [section] [param]
crudini --del [--existing] config_file section [param]
crudini --merge [--existing] config_file [section]
```


## 安装JDK
1.将下载好的安装包 jdk-8u211-linux-x64.tar.gz 上传到服务器指定目录下；

2.解压安装包： tar -zxvf jdk-8u211-linux-x64.tar.gz 

3.复制安装包到 /usr/local/java/ 目录下： cp -r jdk1.8.0_211/ /usr/local/java 

4.添加环境变量：编辑 /etc/profile 文件： vim /etc/profile ，在最后面添加：

JAVA_HOME=/usr/local/java
CLASSPATH=$JAVA_HOME/lib/
PATH=$PATH:$JAVA_HOME/bin
export PATH JAVA_HOME CLASSPATH
5.重新加载 /etc/profile 文件 source /etc/profile 

6.使用 java -version 命令验证jdk是否安装成功:

[root@localhost java]# java -version
java version "1.8.0_211"
Java(TM) SE Runtime Environment (build 1.8.0_211-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.211-b12, mixed mode)
