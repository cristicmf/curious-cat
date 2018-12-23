## 1. websocket
web的技术大概可以分为3类：轮询/streaming/websocket

相对于传统的HTTP长连接，WebSocket的优点在于：
```
真正的双向通信。而HTTP只能由客户端发起请求。
HTTP请求中带有大量的header，很多冗余信息，其实很多流量被浪费掉了，WebSocket则没有这个问题。
WebSocket协议支持各种Extension，可以实现多路复用等功能。
```
WebSocket虽然是独立于HTTP的另一种协议，但建立连接时却需要借助HTTP协议进行握手，这也是WebSocket的一个特色，利用了HTTP协议中一个特殊的header：Upgrade。在双方握手成功后，就跟HTTP没什么关系了，会直接在底层的TCP Socket基础上进行通信。


### 1.1 Frame


## 3. STOMP

STOMP is a simple text-orientated messaging protocol. 
It defines an interoperable wire format so that any of the available STOMP clients can communicate with 
any STOMP message broker to provide easy and widespread messaging interoperability among languages and 
platforms (the STOMP web site has a list of STOMP client and server implementations.

STOMP中的消息都被抽象为“帧”（有点类似AMQP中message的概念），帧的格式和HTTP非常类似，分为command、header、body三部份。其中比较重要的就是SUBSCRIBE/SEND/MESSAGE帧。SUBSCIRBE帧用于订阅某个destination，SEND帧用于发送数据，MESSAGE帧用于从服务端接收数据。尤其注意下其中的destination header，有点像传统mq中的topic。STOMP不限定destination的格式，可以是任意格式字符串，由服务端去解释，不过一般都是/a/b这种类似路径的格式。

### 3.1 Frame

### 3.2 kata
- connect
- publish 
  - topic
  - send message
  
- subscribe
  - topic

---
## 4. Spring Stomp 源码解析
### 4.1 kata
[spring demo](https://github.com/spring-guides/gs-messaging-stomp-websocket)


### 4.2 架构解析

### 4.3 自定义STOMP


## 5. STOMPJS
- StompHandler
```
- _serverFrameHandlers: CONNECTED/MESSAGE/RECEIPT
- configure
- start
- dispose
- publish
- watchForReceipt
- subscribe
- unsubscribe
- begin
- commit
- abort
- ack
- nack
```

- Client-defineProperty
```
- webSocket
- webSocket
- connected
- connectedVersion
- active

```
- Client-function
```
- configure
- activate
- deactivate
- forceDisconnect
- publish
- watchForReceipt
- subscribe
- unsubscribe
- begin
- commit
- abort
- ack
- nack

```
- HeartbeatInfocc

- Stomp
```
- Stomp.client 
- Stomp.over
```

- FrameImpl function
```
- toString
- serialize
- serializeCmdAndHeaders
- isBodyEmpty
- bodyLength
- FrameImpl.sizeOfUTF8
- FrameImpl.toUnit8Array
- FrameImpl.marshall
- FrameImpl.hdrValueEscape
- FrameImpl.hdrValueUnEscape
```
- FrameImpl defineProperty
```
- body
- binaryBody
```

---
更多

- [stomp](https://stomp.github.io/)
- [stomp.js v4](https://github.com/jmesnil/stomp-websocket) 这个是旧版本，可以考虑使用新版本
- [stomp.js v5](https://github.com/stomp-js/stompjs)
- [sockjs](https://github.com/sockjs/sockjs-client)
- [rfc](https://tools.ietf.org/html/rfc6455)

---
推荐阅读
- [BBF_USP_webinar]（https://www.broadband-forum.org/downloads/webinars/BBF_USP_webinar_2018-02-28.pdf）

协议标准

- [stomp-specification-1.0](https://stomp.github.io/stomp-specification-1.0.html)
- [stomp-specification-1.1](https://stomp.github.io/stomp-specification-1.1.html)
- [stomp-specification-1.2](https://stomp.github.io/stomp-specification-1.2.html)


