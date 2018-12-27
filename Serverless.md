## 1. Event brokering 

### 1.1 Event brokers
**Event brokers** are middleware products that are used to facilitate, mediate and enrich the interactions of sources and handlers in event-driven computing.

### 1.2 Event-driven architecture
**Event-driven architecture** (EDA) is inherently intermediated. Therefore, the intermediating role of event brokering is a definitional part of EDA. All implementations of event-driven applications must use some technology in the role of an event broker.


The strategic role of event-driven computing in **digital business**, that strives for continuous awareness, intelligence and agility, creates a demand for event broker technology that is designed specifically for event-driven use cases.


### 1.4 Recommendations
Application leaders engaged in modernizing their application architecture and infrastructure should:
> 1. Build skills and technology for event-driven design to enable application designers to freely draw on traditional request-driven SOA or EDA capabilities as the business requires.

> 2. Choose advanced event brokers for digital business innovation initiatives because of their specialized support for event processing, even if the previous-generation alternative pub-sub technology, such as MOMs or ESBs, is already used elsewhere in your organization.

> 3. Include advanced event brokers when assembling your hybrid integration platform suite to support strategic event-driven solutions in your multiarchitecture application environment.

> 4. Adopt event brokers with the understanding that the increasing maturity and standardization of technology over time will likely lead you to make changes to technology and its use patterns.

### 1.4 Benefits and Uses
```
IoT applications
Data Integration and reconciliation
Application-as-product extensibility
Continuous intelligence
Serverless functions
Stream analytics
```

### 1.5 Event Brokers in Context
Every Event Brokers play a different role in different context。

**Many middleware products can play the role of an event broker.** ESBs, MOMs, business process management (BPM) suites and Java EE application servers (via the embedded JMS) all typically have pub-sub capability and, therefore, can perform at least the minimum function of facilitating EDA interactions. However, few of these products were designed for event processing as their primary objective. ESBs center on integration and MOMs on delivering messages, while BPM suites manage workflows and application servers are a general-purpose application platform.

With the increasing emphasis on event-driven computing in digital business, new middleware products are emerging with the primary purpose of supporting event processing. Two main categories of technology, offered together or separately, are part of this market: **the event brokers and the stream analytics engines** (Stream analytics is a modern evolution of complex event processing [CEP] technology and the two names sometimes are used interchangeably.) Stream analytics may act as either a source or a handler of event notifications (see Figure 2).
![image](https://www.gartner.com/resources/362900/362911/362911_0002.png?reprintKey=1-5D8UG66)

All Event Notifications Arrive as Streams, Though Only Some Are Subject to Stream Analytics

[more details](https://www.gartner.com/doc/reprints?id=1-5D8UG66&ct=180820&st=sb&first_name=mei&last_name=fen&work_email=269811655%40qq.com&company=we&job_title=CC&country=Canada&Email_OptIn=true&utm_medium=&utm_source=&utm_campaign=&utm_keyword=)


###  1.5 Serverless functions && EDA

**Serverless functions** are principally designed to be **triggered by events and state changes** in data, apps, applications and other resources. The increasingly demanding use of serverless functions requires an elevated level of management, and **event broker technology** is where central management oversight is implemented.

**Stream analytics** does not require the use of an event broker, However, a combination of event stream processing and an event broker elevates the use cases and design options for both. An event stream can be directed by an event broker to multiple subscribing analytics engines. Once the analytics work identifies a notable complex event, a notification is sent to an event broker to target the subscribing event handlers for all the necessary response work.






## 2. Serverless


> Serverless architectures are application designs that incorporate third-party “Backend as a Service” (BaaS) services, and/or that include custom code run in managed, ephemeral containers on a “Functions as a Service” (FaaS) platform. By using these ideas, and related ones like single-page applications, such architectures remove much of the need for a traditional always-on server component. Serverless architectures may benefit from significantly reduced operational cost, complexity, and engineering lead time, at a cost of increased reliance on vendor dependencies and comparatively immature supporting services.



Serverless（无服务器架构）指的是由开发者实现的服务端逻辑运行在无状态的计算容器中，它由事件触发， 完全被第三方管理，其业务层面的状态则被开发者使用的数据库和存储资源所记录。


![image](https://ws4.sinaimg.cn/large/006tNbRwgy1fv8y3128tfj30ja0dywf3.jpg)


[无服务架构](https://aws.amazon.com/cn/blogs/china/iaas-faas-serverless/)



 

---


### 2.1 Serverless架构的优点

- 降低运营成本：

Serverless是非常简单的外包解决方案。它可以让您委托服务提供商管理服务器、数据库和应用程序甚至逻辑，否则您就不得不自己来维护。由于这个服务使用者的数量会非常庞大，于是就会产生规模经济效应。在降低成本上包含了两个方面，即基础设施的成本和人员（运营/开发）的成本。

- 降低开发成本：

IaaS和PaaS存在的前提是，服务器和操作系统管理可以商品化。Serverless作为另一种服务的结果是整个应用程序组件被商品化。


- 扩展能力：

Serverless架构一个显而易见的优点即“横向扩展是完全自动的、有弹性的、且由服务提供者所管理”。从基本的基础设施方面受益最大的好处是，您只需支付您所需要的计算能力。

- 更简单的管理：

Serverless架构明显比其他架构更简单。更少的组件，就意味着您的管理开销会更少。

- “绿色”的计算：

按照《福布斯》杂志的统计，在商业和企业数据中心的典型服务器仅提供5%～15%的平均最大处理能力的输出。这无疑是一种资源的巨大浪费。随着Serverless架构的出现，让服务提供商提供我们的计算能力最大限度满足实时需求。这将使我们更有效地利用计算资源。



### 2.2 Serverless的架构范式
移动应用后台Serverless参考架构

![image](https://s3.cn-north-1.amazonaws.com.cn/images-bjs/0118-faas-02.png)


实时文件处理Serverless参考架构


![image](https://s3.cn-north-1.amazonaws.com.cn/images-bjs/0118-faas-03.png)


Web应用Serverless参考架构

![image](https://s3.cn-north-1.amazonaws.com.cn/images-bjs/0118-faas-04.png)


物联网应用后台参考架构

![image](https://s3.cn-north-1.amazonaws.com.cn/images-bjs/0118-faas-05.png)

实时流处理Serverless参考架构

![image](https://s3.cn-north-1.amazonaws.com.cn/images-bjs/0118-faas-06.png)

##  3. FAAS

FaaS（Functions as a Service）函数即服务，FaaS是无服务器计算的一种形式，当前使用最广泛的是AWS的Lambada。

现在当大家讨论Serverless的时候首先想到的就是FaaS。FaaS本质上是一种事件驱动的由消息触发的服务，FaaS供应商一般会集成各种同步和异步的事件源，通过订阅这些事件源，可以突发或者定期的触发函数运行。

![image](https://ws3.sinaimg.cn/large/006tNbRwgy1fv8y3p7v04j30n60bowff.jpg)


传统的服务器端软件不同是经应用程序部署到拥有操作系统的虚拟机或者容器中，一般需要长时间驻留在操作系统中运行，而FaaS是直接将程序部署上到平台上即可，当有事件到来时触发执行，执行完了就可以卸载掉。



![image](https://ws1.sinaimg.cn/large/006tNbRwly1fv8y41b37rj30860bo74s.jpg)


---
## 3.1 Serverless && FaaS 

Function 可以理解为一个代码功能块，这个功能块具体包含多少功能，无法明确给出定义，但有一个明确的指标：冷启动时间需要在毫秒数量级。因为 FaaS 的本质上是以程序的快速启动来实现正真的按需运行，按需伸缩，以及高可用。Function 配合调度系统，就可以完全做到开发者对服务运行的实例无感，真 Serverless。


Serverless 比 FaaS 的外延要广，FaaS 主要解决的是用户自定义的代码逻辑如何做到 Serverless，可以叫做 Serverless Compute，同时它也是事件驱动架构的一种，从一张图可以看出二者区别。

 ![image](https://www.phodal.com/static/media/uploads/serverless/mono-ms-sls.jpg)
 


![image](http://jolestar.com/images/faas/serverless-faas.png)

### 3.2 从云的发展来看 FaaS

第一阶段的云主要解决硬件资源（网络，计算，存储）的运维和供给问题，也就是 IaaS 云，可以理解成基于硬件资源的共享经济。IaaS 云的交付的主要是资源，接口以及控制台也是面向资源的，尽量以模拟物理机房环境来降低应用的迁移成本。而云发展到当前阶段来看，出现了两种需求：

###### 正真的按需计算 
>原来云的按需计算只是虚拟机维度的，按时间计费以及弹性伸缩，并不能正真做到按需计算，计算和内存资源都是预申请规划的，和服务的请求并发数并没有明确的关系，哪怕一段时间一个请求没有，资源还是依然占用。而 FaaS 可以做到按请求计费，不需要为等待付费，可以做到更高效的资源利用率。

###### 面向应用

> 本质上用户对云的期望是应用的运行环境，并且最好是只让用户关心业务逻辑，而不需要关心，或者尽量少关心技术逻辑（比如监控，性能，弹性，高可用，日志追踪等）。这也是云原生应用（Cloud Native Application）这个概念提出的背景。


##### 云原生应用就是让渡一部分功能给云，以实现弹性，高可用，故障恢复，降低研发运维成本的应用


但 FaaS 给出来一个方案。就是应用只需要把包含自己业务逻辑的 Function 提交给云，其他的事情由云来完成。这样，云相当于直接接管了业务逻辑模块，然后其他的技术功能直接由云来提供，不依赖开发者在自己应用中引入标准化框架来实现。



---

## 4. Event Mesh && Service Mesh
### 4.1 Service Mesh

Service Mesh被用作微服务的基础设施层，使通信变得更加灵活，可靠和快速。 它得到了谷歌、微软、IBM、红帽和 Pivotal 等行业巨头的推动，并且正在推出 Kubernetes、OpenShift 和 Pivotal Container Service（PKS）等平台和服务。

虽然 Service Mesh （服务网格）可以很好地支持同步 RESTful 和一般的<请求-回复>交互，但它不支持异步、事件驱动的交互，不适合将云原生微服务与遗留应用程序连接，也不适用于 IoT。


现代企业正在将事件驱动架构作为其数字化转型的一部分，每个事件驱动型的企业都需要一个中枢神经系统来快速、可靠和安全地将事件从它们发生的地方发送到它们需要去的地方。

这个中枢神经系统可以被视为 Event Mesh（事件网格）

事件网格作为服务网格的补充，可以做为应用程序的连接层，以提供企业实现其数字化转型目标所需的全套应用程序间通信模式。

![image](https://ws4.sinaimg.cn/large/006tNbRwly1fxmu7vq7crj30kh0cajsy.jpg)

### 4.2 Event Mesh

事件网格对于事件驱动的应用程序，就好比是服务网格对于 RESTful 应用程序：一个架构层，无论在哪里部署这些应用程序（非云、公有云或者私有云），都可以动态路由某个应用程序的事件并使其被其他应用程序所接收。 事件网格由内部连通的 Event broker(事件代理)网络来创建和启用。


### 4.3 Event Mesh vs. Service Mesh

事件网格可以做为服务网格的补充。 事件网格和服务网格类似，它们可以在应用程序之间实现更好的通信，并允许应用程序通过将某些功能放在网络层和应用程序层之间，这样我们可以更多地关注业务逻辑。 但是，相比之下，也有一些重要的区别：

服务网格连接云环境中的微服务，例如 Kubernetes，Amazon ECS、Google Kubernetes Engine、IBM Cloud 和 Alibaba；
事件网格不仅连接微服务（容器化或其他），还连接遗留的应用程序、云原生服务以及可在云和非云环境中运行的各种设备和数据源/接收端。 事件网格可以将任何事件源连接到任何事件处理程序，无论它们在何处部署。



### 4.4 Event Mesh 的特点
事件网格的定义有三个显著特征。 事件网格是：

> 1. 由内部连通的 Event Broker 形成的组合
> 2. 与相关环境无关
> 3. 动态性

事件网格的`动态性`可能是其最重要的属性。 所谓动态，指的是它能够动态地了解哪些事件将被路由到哪些消费者应用程序，然后在事件发生时实时路由这些事件，无论生产者和消费者在哪里被附加到网格， 而且无需配置事件路由。 我们应该让事件网格负责这些，而不是开发人员。


### 4.5 为什么企业需要 Event Mesh?
简而言之，事件网格支持以下使用场景：

> - 连接和编排微服务
> - 将事件从内部部署推送到云应用程序或服务（混合云）
> - 跨 LOB(line-of-business)启用“数据即服务”
> - 实现与后端系统的物联网连接

### 4.6 事件网格

使企业能够支持事件驱动的体系结构，从最小的微服务部署，到以易管理、健壮、安全和架构良好的方式将应用程序扩展到混合云。 它提供了动态和全部实时地集成遗留应用程序、数据存储、现代微服务、SaaS、物联网和移动设备的能力。 事件网格为应用程序开发人员和架构师提供了构建和部署分布式事件驱动应用程序的基础，无论他们需要在何处构建和部署。



---
KeyWord

---
参考：

- [从IaaS到FaaS—— Serverless架构的前世今生
](https://aws.amazon.com/cn/blogs/china/iaas-faas-serverless/)
- [martinfowler](https://martinfowler.com/articles/serverless.html)
- [Evolution of Server Computing: VMs to Containers to Serverless — Which to Use When?
](https://www.gartner.com/doc/3749163/evolution-server-computing-vms-containers)
- [Snafu: Function-as-a-Service (FaaS) Runtime
Design and Implementation](https://arxiv.org/pdf/1703.07562.pdf)
- [FaaS，未来的后端服务开发之道
](https://www.jianshu.com/p/6e86c42f85bd)
- [thread-goroutine-actor](http://jolestar.com/parallel-programming-model-thread-goroutine-actor/)
- [microservice-with-service-mesh-at-ant-financial](http://www.servicemesher.com/blog/microservice-with-service-mesh-at-ant-financial/)
- [solace-event-mesh](https://solace.com/blog/event-mesh)
- [gartner](https://www.gartner.com/doc/reprints?id=1-5D8UG66&ct=180820&st=sb&first_name=mei&last_name=fen&work_email=269811655%40qq.com&company=we&job_title=CC&country=Canada&Email_OptIn=true&utm_medium=&utm_source=&utm_campaign=&utm_keyword=)


---
### WOSC18 
- [NumPyWren](https://www.serverlesscomputing.org/wosc3/presentations/eric-jonas-IEEE-Cloud-Serverless-Workshop-July-2018-Jonas.pdf)
- [How Microservices and Serverless Computing
Enable the Next Gen of Machine Intelligence](https://www.serverlesscomputing.org/wosc3/presentations/algorithmia-OS-for-AI-WoSC.pdf)
- [Conquering Serverless](https://www.serverlesscomputing.org/wosc3/presentations/stackery-ConqueringServerless.pdf)
- [Building and Teaching a Complete Serverless Solution](https://www.serverlesscomputing.org/wosc3/presentations/sparqtv-wosc2018-draft.pdf)
- [Challenges for Serverless Native
Cloud Applications](https://www.serverlesscomputing.org/wosc3/presentations/ben-kehoe-2018_wosc.pdf)
- [Evaluation of Production Serverless
Computing Environments](https://www.serverlesscomputing.org/wosc3/presentations/p1-wosc-july02-hlee.pdf)
- [Serverless Data Analytics with Flint](https://www.serverlesscomputing.org/wosc3/presentations/p2-flint_slides_v2.pdf)
- [Making Serverless
Computing More Serverless](https://www.serverlesscomputing.org/wosc3/presentations/p3-wosc3-rozner.pdf)
- [Challenges for Scheduling Scientific
Workflows on Cloud Functions](https://www.serverlesscomputing.org/wosc3/presentations/p4-cloud-functions-scheduling-wosc-v3.pdf)


Build skills and technology for event-driven design
 event brokers
 assembling your hybrid integration platform
 
 standardization of technology
 
 
 ## Benefits and Uses

 The role of an event broker is central to facilitating event-driven computing in digital business. 
 
 - IoT applications
 - Data Integration and reconciliation
 - Application-as-product extensibility
 - Continuous intelligence
 - Serverless functions
 - Stream analytics


---

Serverless architectures are application designs that incorporate third-party “Backend as a Service” (BaaS) services, and/or that include custom code run in managed, ephemeral containers on a “Functions as a Service” (FaaS) platform. By using these ideas, and related ones like single-page applications, such architectures remove much of the need for a traditional always-on server component.Serverless architectures may benefit from significantly reduced operational cost, complexity, and engineering lead time, at a cost of increased reliance on vendor dependencies and comparatively immature supporting services.

– Amazon Lambda
– Microsoft Azure Functions
– Google Functions
– IBM Functions powered by Apache OpenWhisk
– w.r.t CPU, File I/O and network intensive workloads

---
### martinfowler

- [Serverless](https://martinfowler.com/articles/serverless.html)


---
### WOSC18 
- [NumPyWren](https://www.serverlesscomputing.org/wosc3/presentations/eric-jonas-IEEE-Cloud-Serverless-Workshop-July-2018-Jonas.pdf)
- [How Microservices and Serverless Computing
Enable the Next Gen of Machine Intelligence](https://www.serverlesscomputing.org/wosc3/presentations/algorithmia-OS-for-AI-WoSC.pdf)
- [Conquering Serverless](https://www.serverlesscomputing.org/wosc3/presentations/stackery-ConqueringServerless.pdf)
- [Building and Teaching a Complete Serverless Solution](https://www.serverlesscomputing.org/wosc3/presentations/sparqtv-wosc2018-draft.pdf)
- [Challenges for Serverless Native
Cloud Applications](https://www.serverlesscomputing.org/wosc3/presentations/ben-kehoe-2018_wosc.pdf)
- [Evaluation of Production Serverless
Computing Environments](https://www.serverlesscomputing.org/wosc3/presentations/p1-wosc-july02-hlee.pdf)
- [Serverless Data Analytics with Flint](https://www.serverlesscomputing.org/wosc3/presentations/p2-flint_slides_v2.pdf)
- [Making Serverless
Computing More Serverless](https://www.serverlesscomputing.org/wosc3/presentations/p3-wosc3-rozner.pdf)
- [Challenges for Scheduling Scientific
Workflows on Cloud Functions](https://www.serverlesscomputing.org/wosc3/presentations/p4-cloud-functions-scheduling-wosc-v3.pdf)
