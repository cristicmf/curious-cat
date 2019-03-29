## 1. websocket
web的技术大概可以分为3类：轮询/streaming/websocket

相对于传统的HTTP长连接，WebSocket的优点在于：
```
真正的双向通信。而HTTP只能由客户端发起请求。
HTTP请求中带有大量的header，很多冗余信息，其实很多流量被浪费掉了，WebSocket则没有这个问题。
WebSocket协议支持各种Extension，可以实现多路复用等功能。
```
WebSocket虽然是独立于HTTP的另一种协议，但建立连接时却需要借助HTTP协议进行握手，这也是WebSocket的一个特色，利用了HTTP协议中一个特殊的header：Upgrade。在双方握手成功后，就跟HTTP没什么关系了，会直接在底层的TCP Socket基础上进行通信。


## 2. STOMP

STOMP is a simple text-orientated messaging protocol. 
It defines an interoperable wire format so that any of the available STOMP clients can communicate with 
any STOMP message broker to provide easy and widespread messaging interoperability among languages and 
platforms (the STOMP web site has a list of STOMP client and server implementations.

STOMP中的消息都被抽象为“帧”（有点类似AMQP中message的概念），帧的格式和HTTP非常类似，分为command、header、body三部份。其中比较重要的就是SUBSCRIBE/SEND/MESSAGE帧。SUBSCIRBE帧用于订阅某个destination，SEND帧用于发送数据，MESSAGE帧用于从服务端接收数据。尤其注意下其中的destination header，有点像传统mq中的topic。STOMP不限定destination的格式，可以是任意格式字符串，由服务端去解释，不过一般都是/a/b这种类似路径的格式。

![image](https://ask.qcloudimg.com/http-save/1651485/czssxt74a6.png?imageView2/2/w/1620)

## 3. WebSocket、SockJs、STOMP三者关系

简而言之，WebSocket 是底层协议，SockJS 是WebSocket 的备选方案，也是底层协议，而 STOMP 是基于 WebSocket（SockJS）的上层协议。

1、HTTP协议解决了 web 浏览器发起请求以及 web 服务器响应请求的细节，假设 HTTP 协议 并不存在，只能使用 TCP 套接字来 编写 web 应用。

2、直接使用 WebSocket（SockJS） 就很类似于 使用 TCP 套接字来编写 web 应用，因为没有高层协议，就需要我们定义应用间所发送消息的语义，
还需要确保连接的两端都能遵循这些语义；

3、同HTTP在TCP 套接字上添加请求-响应模型层一样，STOMP在WebSocket 之上提供了一个基于帧的线路格式层，用来定义消息语义；

## 4. 应用场景说明
- 后端系统内部的消息队列
---
## 5. Client
### 5.1 快速理解
[spring demo](https://github.com/spring-guides/gs-messaging-stomp-websocket)
该例子可以帮助用户搭建一个简易的服务端，并且包含一个web端，可以帮助用户快速理解协议Server端和Client端。

### 5.2 python client端
[stomp.py](https://github.com/jasonrbriggs/stomp.py)

---
更多

- [stomp](https://stomp.github.io/)
- [stomp.js v4](https://github.com/jmesnil/stomp-websocket) 这个是旧版本，可以考虑使用新版本
- [stomp.js v5](https://github.com/stomp-js/stompjs)
- [sockjs](https://github.com/sockjs/sockjs-client)
- [rfc](https://tools.ietf.org/html/rfc6455)

---
推荐阅读
- [BBF_USP_webinar](https://www.broadband-forum.org/downloads/webinars/BBF_USP_webinar_2018-02-28.pdf)
- [mqtt协议](https://www.ibm.com/developerworks/cn/iot/iot-mqtt-why-good-for-iot/index.html)
协议标准

- [stomp-specification-1.0](https://stomp.github.io/stomp-specification-1.0.html)
- [stomp-specification-1.1](https://stomp.github.io/stomp-specification-1.1.html)
- [stomp-specification-1.2](https://stomp.github.io/stomp-specification-1.2.html)


