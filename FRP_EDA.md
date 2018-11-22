###### 知识准备
- 🍪[什么是FRP](https://github.com/cristicmf/curious-cat/blob/master/%E8%AE%B2%E8%AE%B2FRP_FP.md)
- 🍪[什么是EDA](https://github.com/cristicmf/curious-cat/blob/master/%E5%BD%93%E6%88%91%E5%9C%A8%E7%9C%8BEDA%E6%97%B6%E5%80%99.md)



## 分析
分析思路，因为我一直纠结于FRP和EDA是什么关系？他们的表现或者特性都是相似，但并非本体。下面我会从下面几个维度分析这个问题。

1. 语言本身的设计层面
2. 架构的设计层面
3. 商业的应用层面
4. 如果从生态架构层面



###  语言本身的设计层面
![image](https://www.researchgate.net/profile/Peter_Van_Roy/publication/241111987/figure/fig1/AS:298670202343424@1448219933039/Languages-paradigms-and-concepts.png)

```
But paradigms that have the power to express observable nondeterminism can be used
to model real-world situations and to program independent activities.
```


The second key property of a paradigm is how strongly it supports state. State is the
ability to remember information, or more precisely, to store a sequence of values in time.



A single feedback loop consists of three concurrent components that interact with
a subsystem (see Figure 6): a monitoring agent, a correcting agent, and an actuating
agent. Realistic systems consist of many feedback loops. Since each subsystem must be
as self-sucient as possible, there must be feedback loops at all levels.



---
There are two popular paradigms for concurrency. The rst is shared-state concur-
rency: threads access shared data items using special control structures called monitors
to manage concurrent access.


The second
paradigm is message-passing concurrency: concurrent agents each running in a single
thread that send each other messages. The languages CSP (Communicating Sequential
Processes) [25] and Erlang [6] use message passing. CSP processes send synchronous
messages (the sending process waits until the receiving process has taken the message)
and Erlang processes send asynchronous messages (the sending process does not wait).

### Computer programming and system design


### 微观


### 宏观



---

Programming Paradigms for Dummies: What Every Programmer Should Know
- [What_Every_Programmer_Should_Know](https://www.info.ucl.ac.be/~pvr/VanRoyChapter.pdf)
- 《SICP》
- [Synchronous programming with events and relations: the SIGNAL language and its semantics](https://core.ac.uk/download/pdf/82752187.pdf)

---
- [pvr](https://www.info.ucl.ac.be/~pvr/cvvanroy.html)


---
1. 如果完全考虑事件这个因素，必然是一个...
2. 能够表达现实当中的一个场景或者一个现象
3. 反馈系统和监控系统


---

The research projects address some of the key technological challenges of our time, mainly but not exclusively: ubiquitous data-intensive applications, scalable distributed systems (including Cloud computing and P2P models), adaptive distributed systems (autonomic computing, green computing, decentralized and voluntary computing), and applied distributed systems (distributed algorithms and systems, working in an inter-disciplinary manner, in existing and emerging fields to address industrial and societal needs in the European and worldwide context.


