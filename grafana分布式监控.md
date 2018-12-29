## grafana
### Metric

For Mode there are three options:

The default option is Time and means the x-axis represents time and that the data is grouped by time (for example, by hour or by minute).

The Series option means that the data is grouped by series and not by time. The y-axis still represents the value.
The Histogram option converts the graph into a histogram. A Histogram is a kind of bar chart that groups numbers into ranges,
often called buckets or bins. 
Taller bars show that more data falls in that range. Histograms and buckets are described in more detail here.


### how to get the parameter from the url

###### like

Use  Url http://servername:3000/dashboard/db/dashboard?refresh=10s&var-node=hanoi

In Query: use where clause as shown below:

```
WHERE "system_id" =~ /^$node$/
```

### Variables
Variables are shown as dropdown select boxes at the top of the dashboard. These dropdowns make it easy to change the data being displayed in your dashboard.


### templating
[templating](http://docs.grafana.org/reference/templating/)

---

## influxDB+telegraf 

![image](https://www.influxdata.com/wp-content/uploads/Tick-Stack-Telegraf-2.png)

```
- cpu[units: percent (out of 100)]
    - usage_guest      float
    - usage_guest_nice float
    - usage_idle       float
    - usage_iowait     float
    - usage_irq        float
    - usage_nice       float
    - usage_softirq    float
    - usage_steal      float
    - usage_system     float
    - usage_user       float
- disk
    - free         integer
    - inodes_free  integer
    - inodes_total integer
    - inodes_used  integer
    - total        integer
    - used         integer
    - used_percent float
- diskio
    - io_time          integer
    - iops_in_progress integer
    - read_bytes       integer
    - read_time        integer
    - reads            integer
    - weighted_io_time integer
    - write_bytes      integer
    - write_time       integer
    - writes           integer
- kernel
    - boot_time        integer
    - context_switches integer
    - entropy_avail    integer
    - interrupts       integer
    - processes_forked integer
- mem
    - active            integer
    - available         integer
    - available_percent float
    - buffered          integer
    - cached            integer
    - free              integer
    - inactive          integer
    - slab              integer
    - total             integer
    - used              integer
    - used_percent      float
    - wired             integer
- processes
    - blocked       integer
    - dead          integer
    - idle          integer
    - paging        integer
    - running       integer
    - sleeping      integer
    - stopped       integer
    - total         integer
    - total_threads integer
    - unknown       integer
    - zombies       integer
- swap
    - free         integer
    - in           integer
    - out          integer
    - total        integer
    - used         integer
    - used_percent float
- system
    - load1         float
    - load15        float
    - load5         float
    - n_cpus        integer
    - n_users       integer
    - uptime        integer
    - uptime_format string

```

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

#### COMMAND
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


