## 1. 中间件定义

中间件是一种独立的系统软件或服务程序，分布式应用软件借助这种软件在不同的技术之间共享资源。中间件位于客户机/ 服务器的操作系统之上，管理计算机资源和网络通讯。是连接两个独立应用程序或独立系统的软件。相连接的系统，即使它们具有不同的接口，但通过中间件相互之间仍能交换信息。执行中间件的一个关键途径是信息传递。通过中间件，应用程序可以工作于多平台或OS环境。


中间件是一类连接软件组件和应用的计算机软件，它包括一组服务。以便于运行在一台或多台机器上的多个软件通过网络进行交互。该技术所提供的互操作性，推动了一致分布式体系架构的演进，该架构通常用于支持并简化那些复杂的分布式应用程序，它包括web服务器、事务监控器和消息队列软件。

---
也许很难给中间件一个严格的定义，但中间件应具有如下一些特点：
> 1. 满足大量应用的需要；
> 2. 运行于多种硬件和OS平台，支持分布计算，提供跨网络、硬件和OS平台的透明性的应用或服务的交互；
> 3. 支持标准的协议和接口；
---

### 2. 技术现状
中间件技术服务复杂网络应用的共性问题中不断发展和壮大起来的，可以归纳为下面几个方面：

1、从计算环境来看：中间件面对的是一个复杂、不断变化的计算环境，要求中间件技术具有足够的灵活性和可成长性；

2、从资源管理的角度来看：操作系统和数据库管理系统管理的是有限资源，资源种类有限，资源量也有限，而中间件需要管理的资源类型（数据、服务、应用）更丰富，且资源扩展的边界是发散的；

3、从应用支撑角度来看：中间件需要提供分布应用开发、集成、部署和运行管理的整个生命周期的总体运行模型，随着分布式商业或者数字商业的发展，需要进一步变革传统的方式；

4、从应用的角度来看：利用中间件完成的往往是复杂、大范围的企业级应用，其关系错综复杂，流程交织。例如客户关系管理系统需要集成多个企业内部应用，而供应链管理则涉及企业之间的应用集成。


因此，由于网络应用的复杂性，特别是分布、异构和自治等特点，决定了中间件技术和产品的形态多样性。但是随着时间的变化。中间件技术已经形成一个丰富的体系，并正在向上（应用框架和普适服务）和向下（融合操作系统、数据库管理系统的功能）两个方向不断延伸，并在向更宽广的应用领域拓展。


---
### 3. 供应商层面




---
### 4. 分类

中间件分类（IDC的分类）：数据访问中间件、远程过程调用中间件、消息中间件、交易中间件、对象中间件。


#### 4.1 分布环境下的通讯服务，我们将这种通讯服务称之为平台。

基于目的和实现机制的不同，我们将平台分为以下主要几类：
远程过程调用中间件（Remote Procedure Call）
面向消息的中间件（MesSAge-Oriented Middleware）
对象请求代理中间件（object RequeST Brokers）

---

## 5. 趋势特征

中间件技术的发展方向，将聚焦于消除信息孤岛，推动无边界信息流，支撑开放、动态、多变的互联网环境中的复杂应用系统，实现对分布于互联网之上的各种自治信息资源（计算资源、数据资源、服务资源、软件资源）的简单、标准、快速、灵活、可信、高效能及低成本的集成、协同和综合利用，提高组织的IT基础设施的业务敏捷性，降低总体运维成本，促进IT与业务之间的匹配。中间件技术正在呈现出业务化、服务化、一体化、虚拟化等诸多新的重要发展趋势。


### 5.1 分布式消息中间件

“Message-oriented middleware (MOM) is software or hardware infrastructure supporting sending and receiving messages between distributed systems.”——维基百科

那么分布式消息中间件其实就是指消息中间件本身也是一个分布式系统。

消息中间件的应用场景大致如下：

业务解耦：交易系统不需要知道短信通知服务的存在，只需要发布消息

**削峰填谷**：比如上游系统的吞吐能力高于下游系统，在流量洪峰时可能会冲垮下游系统，消息中间件可以在峰值时堆积消息，而在峰值过去后下游系统慢慢消费消息解决流量洪峰的问题

**事件驱动**：系统与系统之间可以通过消息传递的形式驱动业务，以流式的模型处理


---

### 5.2 架构可视化

核心点是有意义和有效，要做到这两点，首先需要识别什么是有意义和有效的元素和关系，我们在此领域做的事情归纳起来就是“识别”，识别机器上的每个进程是什么，发生的网络调用远端是什么，唯有知晓了这些元素是什么我们才有理由和依据来判断是否对用户有意义以及其在用户架构中的重要程度。

#### 元素识别
> -  自己的应用服务；
> -  应用对外部的资源依赖；
> -  服务器本身的信息。 

应用对外部资源的依赖通常以其它应用和通用中间件或者存储服务两种形式存在。故我们将需要识别的进程分为：应用服务和常见的组件服务（比如Redis、MySQL等），这些组件服务又分为用户自建的服务和使用公有云提供的服务，特别是对于Cloud Native应用来说，云服务的识别显得格外重要。

### 5.3 还可以做什么

> 借助架构感知采集到的架构数据,在识别了用户使用的组件（我们对MySQL、Redis、MQ等的统称)后，我们借助这些组件以及与组件匹配的故障库，可以给用户自动推荐这些组件可能遇到的故障，配合我们提供的评测服务让用户更方便地对组件进行各种故障的模拟与演练，以提高系统的健壮性。

[体验产品](https://www.aliyun.com/product/ahas)

---
### 公司维度
#### 1. TIBCO
##### Spotfire

All-new A(X) Experience
Analytics, Accelerated

```
The all-new TIBCO Spotfire® A(X) Experience makes it fast and easy for everyone to get value out of data —whether you’re just getting started with analytics or an expert trying to uncover deeper insights.
```

##### jaspersoft


Data visualization and reporting in a world of cloud, microservices, and DevOps



#### 2. mulesoft
**Connect anything. Change everything**

Build an application network with secure, reusable integrations and APIs designed, built, and managed on Anypoint Platform™.


#### 3. apigee

API管理
The Cross-Cloud API Management Platform


#### 4. Informatica
在Informatica看来，数据治理包含探查、定义、应用和衡量与监控四方面。数据治理的前提就是要先了解治理，知道治理的目标、治理的主体，探讨分析是数据治理的第一步。其次，将非标准化的东西统一成标准化，制定业务词汇表、业务规则与规定等，对相关内容进行定义标准。第三是应用，制定自动化规则以及确定手动工作流程。最后就是衡量，取决于治理的结果和定义目标达成的情况，然后决定下一步计划。

#### 5. Nastel

中间件管理

Nastel Technologies’ product family is called AutoPilot. AutoPilot is software for real-time monitoring of the availability and performance of business applications. Using complex event processing and business transaction management it provides real-time visibility of applications, middleware and transactions, as well as predictive alerting.

Nastel AutoPilot has been especially effective in the banking industry[4] and in insurance, healthcare and retail.

##### 5.1 Middleware Monitoring & Management


Use the solution employed by the world’s largest middleware environments to ensure the performance and reliability of business-critical enterprise applications.

##### 5.2 Transaction Tracking,Business Tracking


Understand how transaction performance affects your business processes. Nastel tracks and troubleshoots end-to-end business transactions in real-time, from mobile to applications, middleware, brokers, and mainframe.

![image](https://www.nastel.com/wp-content/uploads/Nastel-Infrastructure-graphic-1100.jpg)


#### 6. 阿里云中间件
阿里中间件的范围分为：

```
基础中间件
运维平台
稳定性相关平台
云产品服务
计算平台
存储平台
```


![image](https://blog-100offer.100offer.com/p/f9ca954149414ae8a0a09c6ed7214d931490884646)



往上就是存储层、数据库相关的，包括缓存 Tair、文件系统相关的 TFS、我们的框表 HBase、面向海量数据分析型的列式数据库 HiStore 以及面向于时间序列相关的 HiTSDB，还承接阿里巴巴整个交易平台过程中需要的关系型数据库 MySQL 和金融场景相关的 OceanBase。

再往上是应用层的运行容器，包括 Linux 和 Tomcat。

在往上，属于分布式的数据层，就是如何把海量数据进行分库分表，围绕这些数据库进行数据迁移。

再往上是整个的消息中间件，包括事务消息、顺序消息的中间件 Notify 和 Metaq。还有我们在集团中广泛应用的服务框架 HSF。

在向上，就是整个阿里巴巴应用的接入层了，包括 Tengine、LVS。

从图上再向右看去，我们会看到实时计算平台 JStorm 和之前提到过的分布式日志系统 EagleEye、TLog 和所有服务器上都在部署的日志收集器。

再向右，是资源管理/调度弹性/容器化系统。

整个左半部分，由中间件的这些技术，承接着所有的业务产品，包括淘宝、天猫、1688、AE、B2B以及圈子收购的子公司优酷、高德等等。我们将所有这些技术经验沉淀出了产品，并在云上形成服务。目前已经形成云产品的包括，EDAS、DRDS、MQ、TXC，以及面向监控的 ARMS 和时间分片的 SchedulerX，以及围绕这些服务的云产品中台。




---
还需要研究的公司
- tx
- 微软
- [tervela](http://www.tervela.com/products/data-fabric/)
- [mulesoft](https://www.mulesoft.com/cn/)




---
数据提供公司
- [crunchbase](https://www.crunchbase.com/organization/tervela#section-overview)


---
相关报告
- [The Forrester Wave™: API Management Solutions, Q4 2018](https://reprints.forrester.com/#/assets/2/157/RES141540/reports)

