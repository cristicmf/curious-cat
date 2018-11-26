Lamport Clock如何启发人们在分布式系统中开始使用新的的思维方式, 并介绍了Sequential Consistency和Linearizability


- Fault: 在系统中某一个步骤偏离正确的执行叫做一个fault, 比如内存写入错误, 但是如果内存是ECC的那么这个fault可以立刻被修复, 就不会导致error.
- Error: 如果一个fault没能在结果影响到整个系统状态之前被修复, 结果导致系统的状态错误, 那么这就是一个error, 比如不带ECC的内存导致一个计算结果错误.
- Failure: 如果一个系统的error没能在错误状态传递给其它节点之前被修复, 换句话说error被扩散出去了, 这就是一个failure.


### 分布式系统故障模型
在分布式系统中, 故障可能发生在节点或者通信链路上, 下面我们按照从最广泛最难的到最特定最简单的顺序列出故障类型:

```
byzantine failures: 这是最难处理的情况, 一个节点压根就不按照程序逻辑执行, 对它的调用会返回给你随意或者混乱的结果. 要解决拜占庭式故障需要有同步网络, 并且故障节点必须小于1/3, 通常只有某些特定领域才会考虑这种情况通过高冗余来消除故障. 关于拜占庭式故障你现在只要知道这是最难的情况, 稍后我们会更详细的介绍它.
crash-recovery failures: 它比byzantine类故障加了一个限制, 那就是节点总是按照程序逻辑执行, 结果是正确的. 但是不保证消息返回的时间. 原因可能是crash后重启了, 网络中断了, 异步网络中的高延迟. 对于crash的情况还要分健忘(amnesia)和非健忘的两种情况. 对于健忘的情况, 是指这个crash的节点重启后没有完整的保存crash之前的状态信息, 非健忘是指这个节点crash之前能把状态完整的保存在持久存储上, 启动之后可以再次按照以前的状态继续执行和通信, 比如最基本版本的Paxos要求节点必须把ballot number记录到持久存储中, 一旦crash, 修复之后必须继续记住之前的ballot number.
omission failures: 这种故障比crash-recovery多一个限制，就是发生故障后，消息不会恢复。比如网络故障造成某条消息在传输中丢失(而不是延迟).
crash-stop failures: 也叫做crash failure或者fail-stop failures, 它比omission failure容易处理, 因为这种模型下故障就是crash, 并且这些故障不会恢复. 比如一个节点出现故障后立即停止接受和发送所有消息. 简单讲, 一旦发生故障, 这个节点就不会再和其它节点有任何交互. 就像他的名字描述的那样, crash and stop.
```

### Consensus问题

之所以要介绍Consensus问题是因为Consensus问题是分布式系统中最基础最重要的问题之一, 也是应用最为广泛的问题, 他比其他的分布式系统的经典问题比如self-stabilization的实际应用要多, 我们可以通过介绍Consensus问题来更加深入得介绍一下之前提到的Linearizability和Sequential Consistency.

Consensus所解决的最重要的典型应用是容错处理(fault tolerannce). 比如在原子广播(Atomic Broadcast)和状态机复制(State Machine Replication)的时候, 我们都要在某一个步骤中让一个系统中所有的节点对一个值达成一致, 这些都可以归纳为Consensus问题. 但是如果系统中存在故障, 我们要忽略掉这些故障节点的噪音让整个系统继续正确运行, 这就是fault tolerance. Consensus问题的难点就在于在异步网络中如何处理容错.

Consensus问题的定义包含了三个方面, 一般的Consensus问题定义为:
```
termination: 所有进程最终会在有限步数中结束并选取一个值, 算法不会无尽执行下去.
agreement: 所有非故障进程必须同意同一个值.
validity: 最终达成一致的值必须是V1到Vn其中一个, 如果所有初始值都是vx, 那么最终结果也必须是vx.
```

### FLP Impossibility, 1985


---
参考的paper
- [One Hop Lookups for Peer-to-Peer Overlays](http://www.well.ox.ac.uk/~anjali/onehop.pdf)
- [Pastry: Scalable, Decentralized Object Location, and
Routing for Large-Scale Peer-to-Peer Systems](https://link.springer.com/content/pdf/10.1007%2F3-540-45518-3_18.pdf)
- [pbft](https://www.usenix.org/legacy/events/osdi99/full_papers/castro/castro_html/node4.html#SECTION00040000000000000000)
- [历史发展](http://danielw.cn/history-of-distributed-systems-2)
- [time-clocks](https://lamport.azurewebsites.net/pubs/time-clocks.pdf)
