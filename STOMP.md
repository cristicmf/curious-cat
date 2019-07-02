## STOMP 协议总结
STOMP是一种基础Frame的协议，模仿HTTP的Frame。一个Frame由命令、一组可选择的信息头和一个信息体组成。STOMP协议是基于文本的，也可以传递二进制信息。协议默认UTF-8编码，也支持对信息体的其他特定可选择的编码。

STOMP服务器被定义为一组可以接收发送的信息的目标服务。STOMP视目标服务为一个不可读的字符串并且它的特定语义由服务端实现，而且STOMP没有规定传输的目标服务的语法，不同服务之间传递的信息的语义也可以不相同。这使得服务端可以在STOMP支持的语义中自由选择。

- 一个STOMP客户端是一个可以以两种模式运行的用户代理，可能是同时运行两种模式。

    - 作为生产者，通过SEND框架将消息发送给服务器的某个服务
    - 作为消费者，通过SUBSCRIBE制定一个目标服务，通过MESSAGE框架，从服务器接收消息。

### 设计理念
STOMP的主要设计理念就是简易性和可操作性。

STOMP被设计成一个轻量级协议，这样很容易使用众多的开发语言实现客户端及服务器。这意味着，特别是对服务器的结构和特性没有过多的限制，例如命名规则和实现语法的可靠性。



### 协议组成
STOMP是一个基于Frame的协议，它假定在底层存在一个可靠地双向数据流的网络协议，就像TCP协议一样。客户端和服务端通过STOMP协议定义的Frame进行通信，一个Frame的结构大致如下：

 `frame =  a command + a set of optional headers + an optional body`

 ```
COMMAND
header1:value1
header2:value2

Body^@
 ```
 - 这个Frame以一个指令字符串开始，以换行符(EndOfLine EOL,即换行符)结束，指令由一个可选的回车(13字节)紧跟着一个必须添加的换行(10字节)组成。接着是零或者多个以<key>:<value>格式组成的头实体。每一个头实体均以EOL结束。一个空行，即一个额外的EOL表示头部信息结束及Body信息开始。Body后面跟随着一个八进制NULL字符，文档中的例子使用了^@,在ASCII码中的控制符-@，用它来表示NULL。NULL可以跟随多个EOL。更多关于如何解析STOMPFrame的信息，查看本文档的补充反馈章节。

- 文档中提到的所有的指令和头的名字都是对大小写敏感的。

 
### 其他说明
-  SEND, MESSAGE, and ERROR  可以有body,其他的FRAME是没有Body



- SEND, MESSAGE and ERROR frames 应该包含 a content-type header to help the receiver of the frame interpret its body.

- 如果设置了`content-type`, body必须使用 `MIME type` . 否则，接收方必须考虑使用a binary blob的body.
    ```
    accessor.setContentType(new MimeType("text", "plain", StandardCharsets.UTF_8));
    
    ```

    Frame 如下所示
    ```
    MESSAGE
    subscription:0
    message-id:007
    destination:/queue/a
    content-type:text/plain
    
    hello queue a^@
    ```
- 文档中提到的所有的指令和头的名字都是对大小写敏感的。



## FRAME
`STOMP` 基于可靠的双向流（比如：`TCP`）

### CONNECT

- `Client-->Server` 客户端发起TCP连接
```
CONNECT
accept-version:1.2
host:stomp.github.org

^@
```

- `Server--> Client` 服务端返回

CONNECTED或者ERROR

```
CONNECTED
version:1.2

^@
```
服务端拒绝连接出错或者拒绝连接时使用`ERROR`。

[代码详见](https://github.com/WeBankFinTech/WeEvent/blob/8726eea3ec828c25691666196c0c2ace9cb584a0/weevent-broker/src/main/java/com/webank/weevent/protocol/stomp/BrokerStomp.java#L151)

- 必要参数
    - COMMAND:CONNECT
    - version 版本
- 推荐参数
    - login : 客户端登陆名
    - passcode : 客户端登陆密码
    - heart-beat : The Heart-beating settings.
- 说明：1.2 版本有所不同，比如`host`.

### 协商
#### Version
1. 客户端可以支持的版本`1.0,1.1,2.0`
```
CONNECT
accept-version:1.0,1.1,2.0
host:stomp.github.org

^@
```
2. 服务端返回支持的协议
```
CONNECTED
version:1.1

^@
```

```
ERROR
version:1.2,2.1
content-type:text/plain

Supported protocol versions are 1.2 2.1^@
```

#### heart-beat

TCP链接的健康性
- 第一个数值表示发送Frame者能做什么（接收心跳）

0意味着它不能发出心跳。
否则该数值就是它确认可以发出的最小毫秒数心跳的间隔。

- 第二个数值表示发送Frame者希望收到的（接收心跳）

0意味着它不希望接受到心跳。
否则该数值就是它希望收到收到的心跳间隔毫秒数。

```
CONNECT
heart-beat:<cx>,<cy>

CONNECTED:
heart-beat:<sx>,<sy>
```


对于从客户端到服务端的心跳：

如果<cx>是0或者<sy>是0，那么就不会有心跳发生。
否则就会每MAX(<cx>,<sy>)毫秒接发生一次心跳。
从另一方面来说，<sx><cy>也是同样的道理。

对于心跳来说，从网络连接上接收到的任何数据都表示远端是正常运行的。在给定的方向上，如果希望心跳每<n>毫秒秒跳动一次，需要确保如下几点：

发送者必须至少每<n>毫秒通过建立的网络连接发送一次新的数据。
如果发送者没有STOMP帧要发送时，它需要发送一个EOL。
如果在至少<n>毫秒内接收者没有接收到任何数据，那么可以认为链接已经断开。
由于定时是不一定准确的，接受者应该容忍并且考虑一个误差范围。


## Client FRAME
客户端如果发送了一个不在如下列表范围内的帧，对于1.2协议的服务器可能会返回一个ERROR，然后关闭连接。

客户端帧列表包括：

```SEND、SUBSCRIBE、UNSUBSCRIBE、ACK、NACK、BEGIN、COMMIT、ABORT、DISCONNECT。```

我们`Client`目前实现了：


```SEND、SUBSCRIBE、UNSUBSCRIBE、DISCONNECT。```



### SEND
SEND帧发送一个消息到消息系统中的某个目标服务。它有一个必须包含的头“destination”，表示应该把消息发送到的目的服务。SEND帧的body包含需要发送的消息内容。

- `Client-->Server` 

    ```
    SEND
    destination:/queue/a
    content-type:text/plain
    
    hello queue a
    ^@
    ```
    - 用户可以向SEND帧中添加任意用户自定义的头信息。用户自定义头一般来说用来允许用户通过SUBSCRIBE帧中的一个标示用户自定义的头信息的内容去过滤消息。用户自定义的头信息必须通过MESSAGE帧传递。

    - 如果服务端因为任何原因不能成功的处理SEND帧内容，需要返回一个ERROR并且断开连接。
    - 必要参数
        - COMMAND:SEND
        - content-length 
        - body
    
- 推荐参数

- `Server--> Client` 
```
RECEIPT
```


    
- 说明：1.2 版本

[代码详见](https://github.com/WeBankFinTech/WeEvent/blob/8726eea3ec828c25691666196c0c2ace9cb584a0/weevent-broker/src/main/java/com/webank/weevent/protocol/stomp/BrokerStomp.java#L169)

#### SUBSCRIBE
`SUBSCRIBE`帧被用于注册对一个目标服务的监听。跟`SEND`一样，`SUBSCRIBE`需要`destination`头标示需要订阅的目标服务。被订阅的目标服务收到的任何信息以后都会被以MESSAGE帧的形式发送给客户端。

```
SUBSCRIBE
id:0
destination:/queue/foo
ack:client

^@
```

- 如果服务端不能成功生成订阅，应该返回一个ERROR并且断开连接。

- STOMP服务端可以支持额外的服务端特定的头去定制目标服务的传递语义。比如我们扩展的`event-id`。

- id说明：由于一个打开的连接可以订阅服务端上的多个目标服务，所以包含在一个帧中的id头的值必须是唯一标示一个订阅。这个id用来客户端和服务端处理与订阅消息和取消订阅相关的动作。在同一个链接中，不同的订阅必须使用不同的标示符。




### UNSUBSCRIBE
`UNSUBSCRIBE`用来移除一个已经存在订阅，一旦一个订阅被从连接中取消，那么客户端就再也不会收到来自这个订阅的消息。由于一个连接可以添加多个服务端的订阅，所以`id`头是`UNSUBSCRIBE`必须包含的，用来唯一标示要取消的是哪一个订阅。`id`的值必须是一个已经存在的订阅的标识。



- `Client-->Server` 

```
UNSUBSCRIBE
id:0

^@
```


- `Server--> Client` 
```
RECEIPT
```

#### DISCONNECT
客户端可以通过关闭Socket而随时与服务端断开链接，但是这样不能确认先前发出的帧是否已经到达服务器。如果想要实现正常断开，即客户端已经知道之前的帧都已经成功被服务端接收，客户端应该做如下内容：


- `Client-->Server` 

```
DISCONNECT
receipt:77
^@
```


- `Server--> Client` 
```
RECEIPT
receipt-id:77
^@
```

## Server
服务端有时会发送除CONNECTED帧之外的下列帧到客户端：MESSAGE、RECEIPT及ERROR。



### MESSAGE

MESSAGE用于传输从服务端订阅的消息到客户端。

MESSAGE中必须包含destionation头，用以表示这个消息应该发送的目标。如果这个消息被使用STOMP发送，那么这个destionation应该与相应的SEND帧中的目标一样。

MESSAGE中必须包含message-id头，用来唯一表示发送的是哪一个消息，以及subscription头用来表示接受这个消息的订阅的唯一标示。
MESSAGE如果有body内容，则必须包含content-length和content-type头。


```
MESSAGE
subscription:0
message-id:007
destination:/queue/a
content-type:text/plain

hello queue a^@
```
- MESSAGE中还可以包含所有用户定义的头以服务端额外特别添加的头。但是用户一定要将信息写入到`NativeHeader`
    - `accessor.setNativeHeader("event-id", EventId);`

### RECEIPT

RECEIPT是服务端对于相应客户端需要回执的Frame的确认。

```
RECEIPT
receipt-id:message-12345

^@
```

### ERROR
如果连接过程中出现什么错误，服务端就会发送ERROR。在这种情况下，服务端发出ERROR之后必须马上断开连接。

---
## JAVA Server 
### setNativeHeader
所有的`Frame` 的值，建议使用`setNativeHeader`，写入所有的值自定义值或者非必要参数。
```
accessor.setNativeHeader("receipt-id", headerIdStr);
```
说明：因为java库的bug，采用该方案进行容错。

### Server维护id值对应的关系
连接层-->协议层-->应用层
```
    // session id <-> [header subscription id in stomp <-> (subscription id in consumer, topic)]
    private static Map<String, Map<String, Pair<String, String>>> sessionContext;
```


==思考题==：
- 从订阅的角度，订阅者订阅成功后，服务端给监听到信息，并且响应给到Client，怎么保证是订阅者订阅的信息，正确且信息唯一？

----
##### 其他需要关注的问题
- Client重连的问题
- heartBeat
- 协议编码说明
- Server端和Client的ID对应关系


---
## 笔记

### 1. websocket
web的技术大概可以分为3类：轮询/streaming/websocket

相对于传统的HTTP长连接，WebSocket的优点在于：
```
真正的双向通信。而HTTP只能由客户端发起请求。
HTTP请求中带有大量的header，很多冗余信息，其实很多流量被浪费掉了，WebSocket则没有这个问题。
WebSocket协议支持各种Extension，可以实现多路复用等功能。
```
WebSocket虽然是独立于HTTP的另一种协议，但建立连接时却需要借助HTTP协议进行握手，这也是WebSocket的一个特色，利用了HTTP协议中一个特殊的header：Upgrade。在双方握手成功后，就跟HTTP没什么关系了，会直接在底层的TCP Socket基础上进行通信。


### 2. STOMP

STOMP is a simple text-orientated messaging protocol. 
It defines an interoperable wire format so that any of the available STOMP clients can communicate with 
any STOMP message broker to provide easy and widespread messaging interoperability among languages and 
platforms (the STOMP web site has a list of STOMP client and server implementations.

STOMP中的消息都被抽象为“帧”（有点类似AMQP中message的概念），帧的格式和HTTP非常类似，分为command、header、body三部份。其中比较重要的就是SUBSCRIBE/SEND/MESSAGE帧。SUBSCIRBE帧用于订阅某个destination，SEND帧用于发送数据，MESSAGE帧用于从服务端接收数据。尤其注意下其中的destination header，有点像传统mq中的topic。STOMP不限定destination的格式，可以是任意格式字符串，由服务端去解释，不过一般都是/a/b这种类似路径的格式。

![image](https://ask.qcloudimg.com/http-save/1651485/czssxt74a6.png?imageView2/2/w/1620)

### 3. WebSocket、SockJs、STOMP三者关系

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


