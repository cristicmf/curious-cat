# Complex_Event_Processing_and_Streaming_Data_Analytics

## 背景

- Streaming Data Analytics

[Forrester](https://reprints.forrester.com/#/assets/2/202/'RES136545'/reports) defines Streaming Analytics as:

> Software that provides analytical operators to **orchestrate data flow**, **calculate analytics**, and **detect patterns** on event data **from multiple, disparate live data sources** to allow developers to build applications that **sense, think, and act in real time**.



- Complex Event Processing (CEP)

[Gartner’s IT Glossary](https://www.gartner.com/it-glossary/complex-event-processing) defines CEP as follows:

> "CEP is a kind of computing in which **incoming data about events is distilled into more useful, higher level “complex” event data** that provides insight into what is happening."
>
> "**CEP is event-driven** because the computation is triggered by the receipt of event data. CEP is used for highly demanding, continuous-intelligence applications that enhance situation awareness and support real-time decisions."



Factor：主要包含Complex Event Processing (CEP)和Streaming Data Analytics。




### 说明

#### 定义

总体而言规则引擎是一种简单的推理机，应用上可以将规则引擎作为一种组件潜入到系统中（例如工作流引擎），从而将**业务决策**从**应用程序代**码中分离出来，并使用预定义的规则语言编写业务决策。使用规则引擎带来的好处是：

- 避免业务规则变化带来的重新编译和重新部署的问题；
- 使用声明性编程方法，提高业务规则代码的可读性；
- 开发人员不需要过多关注业务逻辑（根据各种情况判断发生了什么事情），可以专注于应用逻辑（在发生了什么事情时进行什么样的处理），很多场景下可以提供给非专业开发人员使用；

#### 组成

- 规则定义组件： 使用该组件提供的处理语言 定义特定规则，订阅topic，完成后存储入规则库。

- 规则库组件： 存储已经定义好的规则

- 复杂事件检测组件：核心模块对输入的数据流序列进行过滤、结合、聚集、关联等操作。匹配成功后生成新的事物序列执行输出操作

  ​

  #### 框架分析和选型

| 类型        | 简述                                       | 常用组件               |
| --------- | ---------------------------------------- | ------------------ |
| 组合操作表达式   | 通过使用不同组合操作符将单个事件进行组合并在此基础上进行表达式嵌套来描述复杂事件 | Aviator、easy-rules |
| 数据流查询语言   | 对SQL结构化查询语言的拓展，将输入流中的时间转换为数据库中关系，然后在这些关系上执行查询，最后将查询结果转换为数据流（CEP引擎） | Esper              |
| 产生式规则     | 指定当特定状态到达时应该执行的相应活动，推理过程与CEP处理过程相似       | Drools             |
| CEP+事实数据流 | native Streaming 、Complex Event Processing engine that understands Streaming SQL queries in order to capture events from diverse data sources | Siddhi、Flink       |

| 名称         | 语言、协议、质量                 | 特点                                       |
| ---------- | ------------------------ | ---------------------------------------- |
| Aviator    | java、*、低                 |                                          |
| easy rules | java、apache 2.0、中        | 简单容易上手                                   |
| Esper      | java、net、GUN2.0、中        | 轻量级解决方案、可以方便嵌入服务中心，提供CEP功能 。**单机全内存方案，需要整合其他分布式和存储。**   以内存实现时间窗功能，无法支持较长跨度的时间窗。  无法有效支持定时触达（如用户在浏览发生后30分钟触达支付条件判断）。 |
| Drools     | java、apache2.0、中         | 老牌、稳定。   功能较为完善，具有如系统监控、操作平台等功能。  **学习曲线陡峭，其引入的DRL语言较复杂，独立的系统很难进行二次开发。**   以内存实现时间窗功能，无法支持较长跨度的时间窗。  无法有效支持定时触达（如用户在浏览发生后30分钟触达支付条件判断）。 |
| Siddhi     | java、Python 、apache2.0、高 | 容易上手、HA、Gartner                          |
| Flink      | java、apache2.0、高         | 云服务、apache、大厂商、HA                        |
|            |                          |                                          |
|            |                          |                                          |
|            |                          |                                          |



#### Siddhi  Vs  Flink

| Factor | Siddhi                                   | Flink                                    |
| ------ | ---------------------------------------- | ---------------------------------------- |
| 依赖     | Zookeeper, Kubernetes (NATS, gRPC, Prometheus),messaging systems (NATS, Kafka, JMS), Databases (RDBMS, NoSQL), Services (HTTP, gRPC), File systems and others | clusters（Optional Hadoop YARN、 Apache Mesos 、Kubernetes） 、Zookeeper、Kafka Connector |
| 核心仓库   | siddhi-core, siddhi-query-api, siddhi-query-compiler, and siddhi-annotations. | flink-java、flink-streaming-java_2.11、flink-clients_2.11、flink-connector-wikiedits_2.11、flink-connector-kafka-0.11_2.11 |
| 扩展     | 配置组件                                     | 插件化扩展                                    |
| 运维     |                                          | 1. 7*24 小时稳定运行；2. 检查点的一致性、高效的检查点、端到端的精确一次、集成多中级群管理服务、内存高可用；3. Flink能够方便地升级、迁移、暂停、恢复应用服务；4. 监控和控制应用服务 |
| 端口占用   | 可配置 8280                                 | high-availability.zookeeper.quorum: localhost:2181 , server.0=localhost:2888:3888 |
| 内存资源占用 | Memory（128 MB ~500 MB）, Cores( 2 cores recommended) ,JDK(8、11）,Maven (3.0.4、later) | Java 8、HA(zookeeper)、checkpoints (HDFS / S3 / NFS / SAN / GFS / Kosmos / Ceph / …) |
|        |                                          | 资源耗费量大                                   |
|        |                              |                                          |

