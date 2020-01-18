## 区块链资料汇总
### 关键术语
- 区块链

区块链是一串通过验证的区块，当中的每一个区块都与上一个相连，一直连到创世区块。 确认当一项交易被区块收录时，我们可以说它有一次确认。矿工们在此区块之后每再产生一个区块，此项交易的确认数就再加一。当确认数达到六及以上时，通常认为这笔交易比较安全并难以逆转。

- 比特币
“比特币”既可以指这种虚拟货币单位，也指比特币网络或者网络节点使用的比特币软件。 区块 一个区块就是若干交易数据的集合，它会被标记上时间戳和之前一个区块的独特标记。区块头经过哈希运算后会生成一份工作量证明，从而验证区块中的交易。有效的区块经过全网络的共识后会被追加到主区块链中。

- 加密算法

数据加密的基本过程就是对原来为明文的文件或数据按某种算法进行处理，使其成为不可读的一段代码，通常称为“密文”，使其只能在输入相应的密钥之后才能显示出本来内容，通过这样的途径来达到保护数据不被非法人窃取、阅读的目的。 该过程的逆过程为解密，即将该编码信息转化为其原来数据的过程。

- 分布式

分布式计算是一门计算机科学，它研究如何把计算能力才能解决的问题分成许多小的部分，然后把这些部分分配给许多计算机进行处理，最后把这些计算结果综合起来得到最终的结果。分布式网络存储技术是将数据分散的存储于多台独立的机器设备上。分布式网络存储系统采用可扩展的系统结构，利用多台存储服务器分担存储负荷，利用位置服务器定位存储信息，不但解决了传统集中式存储系统中单存储服务器的瓶颈问题，还提高了系统的可靠性、可用性和扩展性。

- 地址
比特币地址（例如：1DSrfJdB2AnWaFNgSbv3MZC2m74996JafV）由一串字符和数字组成，以阿拉伯数字“1”开头。就像别人向你的email地址发送电子邮件一样，他可以通过你的比特币地址向你发送比特币。



- 关键概念：[术语表](https://github.com/ethereum/wiki/blob/master/%5B%E4%B8%AD%E6%96%87%5D-%E4%BB%A5%E5%A4%AA%E5%9D%8A%E6%9C%AF%E8%AF%AD%E8%A1%A8.md) 

### 2. 书籍
- [精通比特币](https://github.com/bitcoinbook/bitcoinbook)
- [Bitcoin and Cryptocurrency Technologies](https://lopp.net/pdf/princeton_bitcoin_book.pdf)

### 3. 体验动手搭建一个区块链
- [fisco-bcos](https://github.com/FISCO-BCOS)

### 4. Paper
- [Bitcoin: A Peer-to-Peer Electronic Cash System](https://bitcoin.org/bitcoin.pdf)
- [ethereum-White-Paper](https://github.com/ethereum/wiki/wiki/White-Paper)

### 5. 学习智能合约

- [solidity语法](https://solidity.readthedocs.io/en/v0.4.20/)
- [smart-contract-best-practices](https://github.com/ConsenSys/smart-contract-best-practices)
- [智能合约架构](https://github.com/FISCO-BCOS/Wiki/tree/master/%E6%B5%85%E8%B0%88%E4%BB%A5%E5%A4%AA%E5%9D%8A%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6%E7%9A%84%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F%E4%B8%8E%E5%8D%87%E7%BA%A7%E6%96%B9%E6%B3%95%EF%BB%BF)

#### 5.1 智能合约开发工具
- [在线工具remix](https://remix.ethereum.org/#optimize=false&version=soljson-v0.4.21+commit.dfe3193c.js)
- vscode+solidity

#### 5.2 智能合约框架
- [truffle](https://github.com/trufflesuite/truffle)
- [zeppelin-solidity](https://github.com/OpenZeppelin/zeppelin-solidity)
 
#### 5.3智能合约实践
#### 模拟器开发智能合约
测试开发：[EtherumJS TestRPC](https://github.com/trufflesuite/ganache-cli)
正式开发:[geth](https://github.com/ethereum/go-ethereum)

  - 在自己的私有链条上创建用户
    ```
    geth  --identity "newEth" --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --datadir "cdata"  --port 30303 --rpcapi "personal,db,eth,net,web3" --networkid 999  --rpcport 8549  --targetgaslimit 4712388 console
    ```
  - 创建账号和解锁账号
    ```
    > eth.accounts
    > personal.newAccount("123456")
    > personal.unlockAccount(eth.accounts[0], "123456", 20*(60*1000))
    ```

 更多：智能合约入门到精通，更对见[详细说明](https://segmentfault.com/a/1190000012996636)

#### 使用truffle开发框架 
1.框架说明：
- [框架truffle API](http://truffleframework.com/)
- 实践MetaCoin,具体的步骤参考官网

2.智能合约交互：
- [重点理解合约交互](http://truffleframework.com/docs/getting_started/contracts)

3.solidity API
- [solidity API](https://solidity.readthedocs.io/en/v0.4.20/)


4.智能合约相关规范 
- [使用包管理](http://truffleframework.com/docs/getting_started/packages-npm)





  


