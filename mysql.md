#### mysql 5.7 sql_mode

1、查看sql_mode

```
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
```

查询出来的值为：

```
ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
```

2、去掉ONLY_FULL_GROUP_BY，重新设置值。

```
set   @@GLOBAL.sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
```

3、上面是改变了全局sql_mode，对于新建的数据库有效。对于已存在的数据库，则需要在对应的数据下执行：

```
set  @@SESSION.sql_mode ='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
或者：
```

```
在my.cnf 里面设置
sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
在sql_mode 中去掉only_full_group_by 
```
----

## 数据库安装和找回密码

### 1.配置 yum 源
去 MySQL 官网下载 YUM 的 RPM 安装包，http://dev.mysql.com/downloads/repo/yum/
下载 mysql 源安装包
> $ curl -LO http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm

安装 mysql 源
> $ sudo yum localinstall mysql57-community-release-el7-11.noarch.rpm

检查 yum 源是否安装成功
> $ sudo yum repolist enabled | grep "mysql.*-community.*"
mysql-connectors-community           MySQL Connectors Community              21
mysql-tools-community                MySQL Tools Community                   38
mysql57-community                    MySQL 5.7 Community Server             130

如上所示，找到了 mysql 的安装包

### 2.安装
$ sudo yum install mysql-community-server

### 3.启动
安装服务
$ sudo systemctl enable mysqld

启动服务
$ sudo systemctl start mysqld

查看服务状态
$ sudo systemctl status mysqld

### 4.修改 root 默认密码
MySQL 5.7 启动后，在 /var/log/mysqld.log 文件中给 root 生成了一个默认密码。通过下面的方式找到 root 默认密码，然后登录 mysql 进行修改：
```
$ grep 'temporary password' /var/log/mysqld.log
[Note] A temporary password is generated for root@localhost: **********
```

登录 MySQL 并修改密码
```
$ mysql -u root -p
Enter password: 
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
```
注意：MySQL 5.7 默认安装了密码安全检查插件（validate_password），默认密码检查策略要求密码必须包含：大小写字母、数字和特殊符号，并且长度不能少于 8 位。
通过 MySQL 环境变量可以查看密码策略的相关信息：
```
mysql> SHOW VARIABLES LIKE 'validate_password%';
+--------------------------------------+--------+
| Variable_name                        | Value  |
+--------------------------------------+--------+
| validate_password_check_user_name    | OFF    |
| validate_password_dictionary_file    |        |
| validate_password_length             | 8      |
| validate_password_mixed_case_count   | 1      |
| validate_password_number_count       | 1      |
| validate_password_policy             | MEDIUM |
| validate_password_special_char_count | 1      |
+--------------------------------------+--------+
7 rows in set (0.01 sec)
```

具体修改，参见 http://dev.mysql.com/doc/refman/5.7/en/validate-password-options-variables.html#sysvar_validate_password_policy
指定密码校验策略
```
$ sudo vi /etc/my.cnf

[mysqld]
```
###### 添加如下键值对, 0=LOW, 1=MEDIUM, 2=STRONG
validate_password_policy=0

禁用密码策略
```
$ sudo vi /etc/my.cnf
	
[mysqld]
```
###### 禁用密码校验策略
validate_password = off

重启 MySQL 服务，使配置生效
$ sudo systemctl restart mysqld

### 5.添加远程登录用户
MySQL 默认只允许 root 帐户在本地登录，如果要在其它机器上连接 MySQL，必须修改 root 允许远程连接，或者添加一个允许远程连接的帐户，为了安全起见，本例添加一个新的帐户：
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'secret' WITH GRANT OPTION;
```
### 6.配置默认编码为 utf8
MySQL 默认为 latin1, 一般修改为 UTF-8
$ vi /etc/my.cnf
[mysqld]
######  在myslqd下添加如下键值对
```
character_set_server=utf8
init_connect='SET NAMES utf8'
```
重启 MySQL 服务，使配置生效
```
$ sudo systemctl restart mysqld
```
查看字符集

mysql> SHOW VARIABLES LIKE 'character%';
```
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+
8 rows in set (0.00 sec
```

### 7.开启端口
```
$ sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
$ sudo firewall-cmd --reload
```


---
##### 查询用户权限
```
SELECT DISTINCT CONCAT('User: ''',user,'''@''',host,''';') AS query FROM mysql.user;
```

##### 将数据库授权

```
grant rights on database.* to user@host identified by "pass"; 
```


This is the set root password that you will perform inside mysql if you have MySQL 5.6 or below:

mysql> update user set Password=PASSWORD('new-password') where user='root';
flush privileges;
In MySQL 5.7 or above

mysql> update user set authentication_string=PASSWORD('new-password') where user='root';
flush privileges;
