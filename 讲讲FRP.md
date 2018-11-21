# FRP   

## 1. FRP定义
响应式编程就是异步数据流编程

解释1：是一种和事件流有关的编程方式，其角度类似于EventSourceing,关注导致状态值改变的行为事件，一系列事件组成了事件流FRP是更加有效地处理事件流，而无需要显式去管理状态
1.事件流，离散事件序列
2.属性properties，代表模型连续的值

### 简单实例

> var a = function(b,c) {return b+c}

理解：
b、c是被`观察者`，a是`观察者`，如果随着`时间推移`，b和c的值`不断变化`
b、c发生的变化的一系列`事件组成事件流`，可以用集合表示`事件流`，FRP做的事情，就是`遍历`这个事件流的`集合`，将导致b和c的变化的时间重新播放，然后a就获取了一系列的值。这里面的b和c可以被称之为`Monads`

###### 更多Monads
- [functors_monads_applicatives](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html#monads)
- [haskell](https://www.haskell.org/tutorial/monads.html)


但是我的理解是：
> f(a)=x(b)+g(c)=>  a = f(x(b)g(x))   
说明： 函数映射关系，代表的是一种映射关系
