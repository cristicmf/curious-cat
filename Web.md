
# 前端学习
## 踩过的坑
#### 1. Provisional headers are shown

场景：打开一个页面，发送一个请求，出现`Provisional headers are shown`

查找问题，定位过程：
1. 点击打开 `chrome://net-internals`
```
Net Internals 是一套工具集合，用于帮助诊断网络请求与访问方面的问题，它通过监听和搜集 DNS，Sockets，SPDY，Caches 等事件与数据来向开发者反馈各种网络请求的过程、状态以及可能产生影响的因素。
```
2. 在开始的页面触发请求
3. 在`chrome://net-internals`的event 里面查找，刚刚触发的请求，可以通过关键词查询。可以看到相关`invalid`的信息就可以定位问题。

复现问题：将后端设置成`https`,前端请求并非是`https`的情况，就可以触发这个问题。



---

## 前端基础
- 事件冒泡
- this
- 作用域
- 闭包
- bind call apply
- clone 
- 科里化

### 安全
- XSS原理、场景

### 劫持
- 浏览劫持
- CDN劫持

### 缓存
- CDN 缓存
- 浏览器缓存

### 计算机网络
- 204 304 101 206 502
- https
- http2.0 http1.0 http1.1 

### 跨域
- 同源策略
- cors
- jsonp
- iframe
- img

### 前端框架
- vuejs
- react
- zeptojs

## 数据上报、分析以及服务监控
- 安全监控 sentry
- onerror try...catch
- 重写console,进行错误分析

## 调试技巧
- 重写console
- fidller + willow + Rosin，快速调试移动端

## 算法和数据结构
- 快排序
- 动态规划
- 贪心算法
- [算法导论视频](http://open.163.com/special/opencourse/algorithms.html)

## 设计模式

## nodejs
### nodejs基础
- 异步
- 协程
- promise
- fetch
- io多路复用 epoll

### nodejs直出
- 使用nodejs+vue+vuex直出，应用于

## 有意思的问题
- 当“当浏览器输入一行url”我想到了什么

## 编程思想
### 函数式编程

## 其他
- nginx
- redis

## 书籍【推荐】
- javascript高级编程
- 你不知道的javascript
- http权威指南 
- 高性能mysql
- 操作系统
- 算法导论 
- SICP
