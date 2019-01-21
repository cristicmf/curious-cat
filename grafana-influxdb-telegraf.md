## 1.Install

### 1.1. influxdb

```
sudo yum install influxdb
sudo systemctl start influxdb
```

判断已经安装完成,输入下面的命令，可以进入influxDB的界面
```
> influx
```

### 1.2. Telegraf 修改版本
```
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.9.1_linux_amd64.tar.gz
        tar xf telegraf-1.9.1_linux_amd64.tar.gz
telegraf -version
```

#### 1.2.3 启动服务 

config: /etc/telegraf/telegraf.conf

```
sudo systemctl start telegraf
sudo systemctl status telegraf 
sudo systemctl enable telegraf
```

###  1.3. Grafana 修改版本
#### 1.3.1 安装grafana
```
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-5.1.2-1.x86_64.rpm 
```
#### 1.3.2 启动服务、添加开机启动：
```
systemctl enable grafana-server
systemctl start grafana-server
```

#### 1.3.3 配置说明
```
# 配置文件 /etc/grafana/grafana.ini
# systemd服务名 grafana-server.service
# 默认日志文件 /var/log/grafana/grafana.log
# 默认数据库文件 /var/lib/grafana/grafana.db
```

#### 1.3.4 add plugin
添加插件

```
sudo grafana-cli plugins install grafana-clock-panel
sudo systemctl restart grafana-server
```



---
## 2. grafana 需要关注的几个点
### 2.1 Metric

For Mode there are three options:

The default option is Time and means the x-axis represents time and that the data is grouped by time (for example, by hour or by minute).

The Series option means that the data is grouped by series and not by time. The y-axis still represents the value.
The Histogram option converts the graph into a histogram. A Histogram is a kind of bar chart that groups numbers into ranges,
often called buckets or bins. 
Taller bars show that more data falls in that range. Histograms and buckets are described in more detail here.



### 2.2 Variables
Variables are shown as dropdown select boxes at the top of the dashboard. These dropdowns make it easy to change the data being displayed in your dashboard.


### 2.3 templating
时间间隔
```
1. 选择 New 按钮新建一个模板变量
2. 选择 Interval 变量类型，我们可以用这种变量表达时间间隔，同时设置 Name 和 Label，Name 是变量名称，实际引用的时候用$变量名称进行引用；Label 本身无实际作用，主要是用来展示在界面，让用户更加容易理解的。
3. 可以看到在 Values 中，已经有大量预置的时间间隔，我们可以在其中增加，诸如 1m（1分钟）,1h（1小时）,1d（1天）等时间间隔变量
在界面，我们可以见到已经生成了名为时间间隔的下拉框列表，列表中包括了我们设置的时间间隔预设值
4. 将时序查询的 interval 设置为 $t (t 为我们设置的变量Name)。此时在下拉框里选择不同的时间间隔，图表将随之进行切换。
```
基于查询结果的下拉列表
```

前置步骤请参考时间间隔变量设置
选择Query 类型
Data source 选择你查询的目标数据源
Query 是查询所有可能值的查询语句，ES/Logdb 的查询方式是{"find": "terms", "field": "status"}，其中status 是我们查询的目标字段，在这里可以替换成你需要的字段。更深入的语法请参考 ES 官方文档。
Regex 可以选择对于返回的状态值进行正则表达式过滤
Sort 选择排序方式
Multi-value 控制下拉框是否可以支持多选，如果不选中则只能单选
Include all value 控制是否可以支持All选项，支持全选所有的值，只在多选的模式下有效果
Preview of values 可以预览这个字段的所有值
```

[templating](http://docs.grafana.org/reference/templating/)

#### 2.4 provisioning
1. edit the config grafana.ini
```
# folder that contains provisioning config files that grafana will apply on startup and while running.
;provisioning = conf/provisioning
```
2. add the dashborads.yaml and db.yaml file, location in `/etc/grafana/provisioning/dashborads` and `/etc/grafana/provisioning/databases`


## 3. 常见问题
### 3.1 how to get the parameter from the url
for example, nodename
1. set `Custom Variables` ,name as `nodename`
2. add the parameter `var-nodename=“test”`,such as
```
Use  Url http://servername:3000/dashboard/db/dashboard?refresh=10s&var-nodename=“test”
```


3. In Query: use where clause as shown below:
```
WHERE nodename =$nodename
```
you can see the output

```
select * 
from table
where nodename ="test"
```



### 3.2 nginx 反向代理到 grafana

grafana配置nginx反向代理 

将grafana配到www.myserver.com域名的/grafana/的location下

1. nginx配置
```
location /grafana/ {
                proxy_pass http://grafana_server:3000/;
                proxy_set_header   Host $host;
        }
```

2. grafana配置文件修改

```
#在/etc/grafana/grafana.ini配置文件中修改
domain = www.myserver.com
root_url = %(protocol)s://%(domain)s/grafana
````

### 3.3 进行授权
进用户授权行授权，比如说，部分用户可以进行匿名进行访问页面。

1. 修改`grafana.ini`的配置
```
[auth.anonymous]
# 设置允许匿名
enabled = true

# 设置允许匿名的组织
org_name = Main Org.

# 设置允许匿名的组织角色
org_role = Viewer
```
2. 重启
```
systemctl restart grafana-server
```


---

## 4. influxDB+telegraf 

![image](https://www.influxdata.com/wp-content/uploads/Tick-Stack-Telegraf-2.png)

POLICY

```
> CREATE RETENTION POLICY "2h0m0s" ON "telegraf" DURATION 2h REPLICATION 1 DEFAULT
> SHOW RETENTION POLICIES ON telegraf
name    duration shardGroupDuration replicaN default
----    -------- ------------------ -------- -------
autogen 0s       168h0m0s           1        false
2h0m0s  2h0m0s   1h0m0s             1        true
```

```
SELECT time,host,usage_system FROM "autogen".cpu limit 2
name: cpu
time                host             usage_system
----                ----             ------------
1526008670000000000 VM_42_233_centos 1.7262947210419817
1526008670000000000 VM_42_233_centos 1.30130130130254
```

```
SELECT 100 - usage_idel FROM "autogen"."cpu" WHERE time > now() - 1m and "cpu"='cpu0'
```

### 4.1 监听多台服务

1. 在需要监控的机器上面安装对应的telegraf
2. 并且配置上报的influxdb的机器和数据库
```
#Configuration for influxdb server to send metrics to 

[[outputs.influxdb]] 

urls = [“http://1x.xxx:8086”] #influxdb地址 

database = “telegraf_ali” # required #influxdb数据库 

retention_policy = “”#数据保留策略 

write_consistency = “any” #数据写入策略，仅适用于集群模式 

timeout = “5s” #写入超时策略 

username = “telegraf_ali” #数据库用户名 

password = “gPHhbeh” #数据库密码 

#user_agent = “telegraf” #采集器代理名称
```

练习

1. A机器部署`influxdb+telegraf` 
```
> influx
> use telegraf;
> SHOW TAG VALUES FROM system WITH KEY=host
# 可以看到一台主机的信息
```

2. B机器部署`telegraf` 
3. 在B机器，修改`telegraf` `influxdb`地址，使用默认telegraf
4. 重启机器B 的`telegraf`机器
进入A机器
```
> influx
> use telegraf;
> SHOW TAG VALUES FROM system WITH KEY=host

```
- 上面查询主机的信息1条--> 两条主机信息，说明操作成功


#### 4.1.1 COMMAND
```
SHOW MEASUREMENTS  --查询当前数据库中含有的表
SHOW FIELD KEYS --查看当前数据库所有表的字段
SHOW series from pay --查看key数据
SHOW TAG KEYS FROM "pay" --查看key中tag key值
SHOW TAG VALUES FROM "pay" WITH KEY = "merId" --查看key中tag 指定key值对应的值
SHOW TAG VALUES FROM cpu WITH KEY IN ("region", "host") WHERE service = 'redis'
DROP SERIES FROM <measurement_name[,measurement_name]> WHERE <tag_key>='<tag_value>' --删除key
SHOW CONTINUOUS QUERIES   --查看连续执行命令
SHOW QUERIES  --查看最后执行命令
KILL QUERY <qid> --结束命令
SHOW RETENTION POLICIES ON mydb  --查看保留数据
查询数据
SELECT * FROM /.*/ LIMIT 1  --查询当前数据库下所有表的第一行记录
select * from pay  order by time desc limit 2
select * from  db_name."POLICIES name".measurement_name --指定查询数据库下数据保留中的表数据 POLICIES name数据保留
删除数据
delete from "query" --删除表所有数据，则表就不存在了
drop MEASUREMENT "query"   --删除表（注意会把数据保留删除使用delete不会）
DELETE FROM cpu
DELETE FROM cpu WHERE time < '2000-01-01T00:00:00Z'
DELETE WHERE time < '2000-01-01T00:00:00Z'
DROP DATABASE “testDB” --删除数据库
DROP RETENTION POLICY "dbbak" ON mydb --删除保留数据为dbbak数据
DROP SERIES from pay where tag_key='' --删除key中的tag

SHOW SHARDS  --查看数据存储文件
DROP SHARD 1
SHOW SHARD GROUPS
SHOW SUBSCRIPTIONS

```

---
### 4.2 grafana tools


```
- [Puppet](https://forge.puppet.com/puppet/grafana)
- [Ansible](https://github.com/cloudalchemy/ansible-grafana)
- [Chef](https://github.com/JonathanTron/chef-grafana)
- [Saltstack](https://github.com/salt-formulas/salt-formula-grafana)
- [Jsonnet](https://github.com/grafana/grafonnet-lib/)
- [quick install](https://github.com/samuelebistoletti/docker-statsd-influxdb-grafana)

```

#### 4.2.1 [quick install](https://github.com/samuelebistoletti/docker-statsd-influxdb-grafana)

Centos 7 docker 启动grafana容器报"iptables No chain/target/match by that name"

```
docker run -d -p 3000:3000  grafana/grafana:5.1.0  
Error response from daemon: Cannot start container 565c06efde6cd4411e2596ef3d726817c58dd777bc5fd13762e0c34d86076b9e: iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport 3888 -j DNAT --to-destination 192.168.42.11:3888 ! -i docker0: iptables: No chain/target/match by that name
```

#### 4.2.2 解决方法：

vim /etc/sysconfig/iptables

```
*nat
:PREROUTING ACCEPT [27:11935]
:INPUT ACCEPT [0:0]
:OUTPUT ACCEPT [598:57368]
:POSTROUTING ACCEPT [591:57092]
:DOCKER - [0:0]
-A PREROUTING -m addrtype --dst-type LOCAL -j DOCKER
-A OUTPUT ! -d 127.0.0.0/8 -m addrtype --dst-type LOCAL -j DOCKER
-A POSTROUTING -s 172.17.0.0/16 ! -o docker0 -j MASQUERADE
COMMIT
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:DOCKER - [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -s 10.0.0.0/8 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 10050 -j ACCEPT
-A INPUT -s 172.16.0.0/12 -j ACCEPT
-A INPUT -s 192.168.0.0/16 -j ACCEPT
-A INPUT -p icmp -m icmp --icmp-type 8 -j DROP
-A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 3000 -j ACCEPT
-A INPUT -p tcp -m tcp --dport 36091 -j ACCEPT
-A INPUT -j DROP
-A FORWARD -j DROP
-A OUTPUT -j ACCEPT
COMMIT
```


## 5. remove 

### 5.1 remove influxdb
卸载命令：

```
[root@localhost shared]# rpm -q influxdb 
influxdb-0.8.7-1.x86_64 
[root@localhost shared]# rpm -e influxdb 
[root@localhost shared]# rpm -q influxdb 
package influxdb is not installed
```

参数说明：

首先通过  rpm -q <关键字> 可以查询到rpm包的名字
然后 调用 rpm -e <包的名字> 删除特定rpm包
如果遇到依赖，无法删除，使用 rpm -e --nodeps <包的名字> 不检查依赖，直接删除rpm包
如果恰好有多个包叫同样的名字，使用 rpm -e --allmatches --nodeps <包的名字> 删除所有相同名字的包， 并忽略依赖
删除完后，清除已有文件：

```
[root@localhost opt]# ls 
influxdb 
[root@localhost opt]# rm -rf influxdb 
[root@localhost opt]# ls
````
处理端口占用

```
name=$(lsof -i:8086|tail -1|awk '"$1"!=""{print $2}')
if [ -z $name ]
then
	echo "No process can be used to killed!"
	exit 0
fi
id=$(lsof -i:8086|tail -1|awk '"$1"!=""{print $2}')
kill -9 $id
 
echo "Process name=$name($id) kill!"
exit 0
```
###  5.2remove grafana
移除命令
```
sudo yum remove grafana
```
###  5.3remove telegraf
```
sudo yum remove telegraf
```
