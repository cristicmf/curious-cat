1.下载mysql-8.0.13-linux-glibc2.12-x86_64.tar.xz的安装包

```

```
2.解压mysql-8.0.13-linux-glibc2.12-x86_64.tar.xz
```
# tar -xvf mysql-8.0.13-linux-glibc2.12-x86_64.tar.xz
```
3.将解压的文件重命名mysql，并移动到/usr/local目录下

```
# mv mysql-8.0.13-linux-glibc2.12-x86_64 mysql
# mv mysql /usr/local/
```

4.进入到/usr/local目录下，创建用户和用户组并授权
```
# cd /usr/local/
# groupadd mysql
# useradd -r -g mysql mysql
# cd mysql/ #注意：进入mysql文件下授权所有的文件
# chown -R mysql:mysql ./
```

5.再/usr/local/mysql目录下，创建data文件夹
```
# mkdir data
```

6.初始化数据库，并会自动生成随机密码，记下等下登陆要用 
```
# bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
```
7.修改/usr/local/mysql当前目录得用户 
```

如果出现 `error while loading shared libraries: libaio.so.1: cannot open shared object file: No such file or directory`。解决问题具体操作如下。
yum -y install libnuma.so.1
yum -y install numactl
```



```

# chown -R root:root ./
# chown -R mysql:mysql data
```
8.复制文件my.cnf，开始是没有my-default.cnf这个文件，需要手动创建。可以用# touch my-default.cnf命令创建一个，并配置权限。 
```
# cd support-files/
# touch my-default.cnf
# chmod 777 ./my-default.cnf 
# cd ../
# cp support-files/my-default.cnf /etc/my.cnf
```
配置my.cnf 

```
# vim /etc/my.cnf 
[mysqld]
 
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
 
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
 
# These are commonly set, remove the # and set as required.
basedir = /usr/local/mysql
datadir = /usr/local/mysql/data
socket = /tmp/mysql.sock
log-error = /usr/local/mysql/data/error.log
pid-file = /usr/local/mysql/data/mysql.pid
tmpdir = /tmp
port = 3306
#lower_case_table_names = 1
# server_id = .....
# socket = .....
#lower_case_table_names = 1
max_allowed_packet=32M
default-authentication-plugin = mysql_native_password
#lower_case_file_system = on
#lower_case_table_names = 1
log_bin_trust_function_creators = ON
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M 
 
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
```
如果后期mysql运行报错，可以直接到log-error = /usr/local/mysql/data/error.log目录下直接查看错误日志

命令:cat /usr/local/mysql/data/error.log


10.开机自启，进入/usr/local/mysql/support-files进行设置
```
# cd support-files/
# cp mysql.server /etc/init.d/mysql 
# chmod +x /etc/init.d/mysql
```
11.注册服务 
```
# chkconfig --add mysql
```

12.etc/ld.so.conf要配置路径，不然报错 

```
# vim /etc/ld.so.conf
 
添加如下内容:
/usr/local/mysql/lib
```

13.配置环境变量

```
# vim /etc/profile
# source /etc/profile
 
添加如下内容：
#MYSQL ENVIRONMENT
export PATH=$PATH:/usr/local/mysql/bin:/usr/local/mysql/lib
```
如果每次退出容器，需要`source /etc/profile`

14. 启动服务
```
# cp -a ./support-files/mysql.server /etc/init.d/mysqld
# cd bin/
# ./mysqld_safe --user=mysql &
# /etc/init.d/mysqld restart
```

15.登陆，这里输入上面第6步随机生成得密码，细心点输入，没有显示的，登陆成功如图所示 
```
# mysql -uroot -p
... 
密码
...
```

如果失败，出现`/tmp/mysql.sock`。 首先删除`/tmp/mysql.sock`，然后给目录授权 `chown -R mysql.mysql /tmp/* ` 。

```
# rm -rf /tmp/mysql.sock
# chown -R mysql.mysql /tmp/*
```
如果出现，无法登陆的情况修改my.cnf文件。`[mysqld]`后面任意一行添加“skip-grant-tables”用来跳过密码验证的过程。

```
# vim /etc/my.cnf
...
...
```

重启服务
```
# /etc/init.d/mysqld restart
```

重新设置密码
```
# mysql
mysql> use mysql;
mysql> alter user user() identified by "123456";

mysql> flush privileges;
mysql> quit
```



