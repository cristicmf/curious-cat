# FRP && FP   

## 1. Meta-Thinking
### 1.1 什么是范式(oriented)呢？   
> 所谓编程范式：指的是计算机编程的一种基本风格和典范格式。借用哲学的术语，如果说每一个编程者都去创造虚拟世界，那么编程范式就是他们置身其中自觉不自觉采用的世界观和方法论   

#### 编程范式
托马斯.库恩提出“科学的革命”的范式论之后，Robert Floyd在1979年图灵奖的颁奖演说中使用了编程范式一词。编程范式一般包括三个方面，以OOP为例：
1. 学科的逻辑体系——规则范式：如类/对象、继承、动态绑定、方法改写、对象替换等等机制。
2. 心理认知因素——心理范式：按照面向对象编程之父Alan Kay的观点，“计算就是模拟”。OO范式极其重视隐喻（metaphor）的价值，通过拟人化，按照自然的方式模拟自然。
3. 自然观/世界观——观念范式：强调程序的组织技术，视程序为松散耦合的对象/类的集合，以继承机制将类组织成一个层次结构，把程序运行视为相互服务的对象们之间的对话。
![image](http://vipkshttp0.wiz.cn/ks/share/resources/ac553236-ddd2-46ef-87ff-06ffbdb7863c/4260bd49-b50a-4785-a79f-1efc653487ac/index_files/6ca1c79a-b51b-484f-a283-10d6c106e4bd.png)

#### 计算机模型分析
1. 基于图灵机（Turing Machine）的命令式编程 （Imperative Programming）
2. 基于图灵机（Turing Machine）的面向对象 Object-oriented Programming
3. 基于lamada-caculate（lamada的演算）函数式编程functional Programming
4. 基于First-order login(一阶逻辑)的逻辑编程范式

![image](http://vipkshttp0.wiz.cn/ks/share/resources/ac553236-ddd2-46ef-87ff-06ffbdb7863c/4260bd49-b50a-4785-a79f-1efc653487ac/index_files/f4c149c6-a75d-4b1b-91bc-31714c9dfbb1.png)


## 2. FRP定义
响应式编程就是异步数据流编程

解释1：是一种和事件流有关的编程方式，其角度类似于EventSourceing,关注导致状态值改变的行为事件，一系列事件组成了事件流FRP是更加有效地处理事件流，而无需要显式去管理状态
1.事件流，离散事件序列
2.属性properties，代表模型连续的值

### 2.1 简单实例

> var a = function(b,c) {return b+c}

理解：
b、c是被`观察者`，a是`观察者`，如果随着`时间推移`，b和c的值`不断变化`
b、c发生的变化的一系列`事件组成事件流`，可以用集合表示`事件流`，FRP做的事情，就是`遍历`这个事件流的`集合`，将导致b和c的变化的时间重新播放，然后a就获取了一系列的值。

##### [functional-reactive-programming](https://www.infoq.cn/article/functional-reactive-programming)

### 2.2 解释
事件总线(Event buses)或咱们常见的单击事件就是一个异步事件流，你可以观察这个流，也可以基于这个流做一些自定义操作（原文：side effects，副作用，本文皆翻译为自定义操作）。响应式就是基于这种想法。你能够创建所有事物的数据流，而不仅仅只是单击和悬停事件数据流。 流廉价且无处不在，任何事物都可以当作一个流：变量、用户输入、属性、缓存、数据结构等等。比如，假设你的微博评论就是一个跟单击事件一样的数据流，你能够监听这个流，并做出响应。


最重要的是，有一堆的函数能够创建（create）任何流，也能将任何流进行组合（combine）和过滤（filter）。 这正是“函数式”的魔力所在。一个流能作为另一个流的输入(input)，甚至多个流也可以作为其它流的输入。你能合并（merge）两个流。你还能通过过滤（filter）一个流得到那些你感兴趣的事件。你能将一个流中的数据映射（map）到一个新的流中。


###### 更多函数式
- [javascriptallongesix](https://leanpub.com/javascriptallongesix/read)
- [functors_monads_applicatives](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html#monads)
- [haskell](https://www.haskell.org/tutorial/monads.html)


但是我的理解是：
> f(a)=x(b)+g(c)=>  a = f(x(b)g(x))   
说明： 函数映射关系，代表的是一种映射关系

---
## 3. FP

### 3.1 函数式编程历史：
函数式编程思想的源头可以追溯到 20 世纪 30 年代，数学家阿隆左 . 丘奇在进行一项关于问题的可计算性的研究，也就是后来的 lambda 演算。lambda 演算的本质为 一切皆函数，函数可以作为另外一个函数的输出或者 / 和输入，一系列的函数使用最终会形成一个表达式链，这个表达式链可以最终求得一个值，而这个过程，即为计算的本质。

然而，这种思想在当时的硬件基础上很难实现，历史最终选择了同丘奇的 lambda 理论平行的另一种数学理论：图灵机作为计算理论，而采取另一位科学家冯 . 诺依曼的计算机结构，并最终被实现为硬件。由于第一台计算机即为冯 . 诺依曼的程序存储结构，因此运行在此平台的程序也继承了这种基因，程序设计语言如 C/Pascal 等都在一定程度上依赖于此体系。

到了 20 世纪 50 年代，一位 MIT 的教授 John McCarthy 在冯 . 诺依曼体系的机器上成功的实现了 lambda 理论，取名为 LISP(LISt Processor), 至此函数式编程语言便开始活跃于计算机科学领域。


### 3.2 命令式编程 && 函数式编程

1. 编程风格
```
命令式：一步一步地执行，并且要管理状态的变化
函数式：描述问题和所需的数据变化以解决问题
```

2. 状态变化
```
命令式：很重要
函数式：不存在
```

3. 执行顺序
```
命令式：很重要
函数式：不太重要
```

4. 主要的控制流
```
命令式：循环、条件、函数调用
函数式：函数调用和递归
```

5. 主要的操作元
```
命令式 : 结构体和类对象
函数式：函数作为一等公民的对象进行数据集
```

函数式语言的语法必须要顾及到特定的设计模式，比如类型推断系统和匿名函数。大体上，这个语言必须实现lambda演算。 并且解释器的求值策略必须是非严格、按需调用的（也叫做延迟执行），它允许不变数据结构和非严格、惰性求值。


### 3.3 js中FP中的应用
OOP（面向对象编程）在占主要的范式在js中，最近，这有一个增长兴趣的编程范式，FP(函数性编程)是一种编程范式，它主要是强调成极小化编程状态的数量。在这个方面，它鼓励的是不可变的数据和纯函数。它也偏向于描述性的风格并且鼓励用好的命名规范的函数，这个允许你清楚的程序当你写逻辑的时候，和可实现细节封装。

```
// A function with a side effect
var x = 10;
const myFunc = function ( y ) {
x = x + y;
}
myFunc( 3 );
console.log( x ); // 13myFunc( 3 ); 
console.log( x ); // 16
```
 
```
减少副作用:一个副作用是变化的，它不是局部函数带来的影响，一个函数或许做一些事情，像操作DOM,修改一个变量值在更大的作用域内或者写数据到数据库中。这些结果就是副作用这个副作用不是天然的恶魔，一个程序能够产生没有副作用的程序这样就不会影响其他的逻辑， and so there would be no point to it (other than perhaps as a theoretical curiousity). 因此，危险或许应该是可以避免的，所以无论如何是必须严格规范书写。

当一个程序产生副作用时，你不得不知道更多关于它的输入和输出，以此来理解这个函数的作用 你必须知道这个程序的上下文和历史的状态，这就使得程序变得难以理解，副作用的带来的bug相互作用造成的在一个不可预测的情况下。并且这个方法产生的副作用是很难被测试出来，但辛亏是它们依赖于上下文和程序的历史状态

减少副作用是函数式编程的一个基本原则，大多数情况根据这些因素作为基本准则来理解是可以去避免这些问题。
数据是不可变化的
```

#### 3.3.1 应用

##### 自调函数和闭包

var ValueAccumulator = function() {var values = [];var accumulate = function(obj) {if (obj) {
      values.push(obj.value);return values;} else {return values;}};return accumulate;};//This allows us to do this:var accumulator = ValueAccumulator();accumulator(obj1);accumulator(obj2);
console.log(accumulator());// Output: [obj1.value, obj2.value]


正确的使用闭包
```
 var outter = []; 
 function clouseTest2(){ 
  var array = ["one", "two", "three", "four"]; 
  for ( var i = 0; i < array.length;i++){ 
  var x = {}; 
		 x.no = i; 
		 x.text = array[i]; 
 x.invoke =  function (no){ 
  return 
				 function (){ 
 print(no); 
			 } 
		 }(i); 
		 outter.push(x); 
	 } 	
 }
```

通过将函数 柯里化，我们这次为 outter 的每个元素注册的其实是这样的函数：
```
 //x == 0 
 x.invoke =  function (){print(0);} 
 //x == 1 
 x.invoke =  function (){print(1);} 
 //x == 2 
 x.invoke =  function (){print(2);} 
 //x == 3 
 x.invoke =  function (){print(3);}
```
这样，就可以得到正确的结果了。

##### 高阶函数
自调用函数实际上是高阶函数的一种形式。高阶函数就是以其它函数为输入，或者返回一个函数为输出的函数。

高阶函数在传统的编程中并不常见。当命令式程序员使用循环来迭代数组的时候，函数式程序员会采用完全不同的一种实现方式。 通过高阶函数，数组中的每一个元素可以被应用到一个函数上，并返回新的数组。

这是函数式编程的中心思想。高阶函数具有把逻辑像对象一样传递给函数的能力。

```
// 使用forEach()来遍历一个数组，并对其每个元素调用回调函数accumulator2
var accumulator2 = ValueAccumulator();
var objects = [obj1, obj2, obj3]; // 这个数组可以很大
objects.forEach(accumulator2);
console.log(accumulator2());
```

##### 纯函数
纯函数返回的计算结果仅与传入的参数相关，不会使用外部的函数和全局的状态，并且没有副作用。换句话说就是不能改变作为传入的变量，所以程序里智能使用纯函数返回的值。
```
// 把信息打印到屏幕中央的函数var printCenter = function(str) {var elem = document.createElement("div");
  elem.textContent = str;
  elem.style.position = 'absolute';
  elem.style.top = window.innerHeight / 2 + "px";
  elem.style.left = window.innerWidth / 2 + "px";
  document.body.appendChild(elem);};printCenter('hello world');// 纯函数完成相同的事情var printSomewhere = function(str, height, width) {var elem = document.createElement("div");
  elem.textContent = str;
  elem.style.position = 'absolute';
  elem.style.top = height;
  elem.style.left = width;return elem;};
document.body.appendChild(printSomewhere('hello world',
window.innerHeight / 2) + 10 + "px",
window.innerWidth / 2) + 10 + "px")￼);
```

##### 匿名函数
在函数式编程语言中，函数是可以没有名字的，匿名函数通常表示：“可以完成某件事的一块代码”。这种表达在很多场合是有用的，因为我们有时需要用函数完成某件事，但是这个函数可能只是临时性的，那就没有理由专门为其生成一个顶层的函数对象。

它允许了在现场定义临时逻辑能力。通常这里带来的好处，就是某一个函数只用一次，就没有必要给它良妃一个变量名
匿名函数不仅仅是语法糖，他们是lambda演算的化身。请听我说下去…… lambda演算早在计算机和计算机语言被发明的很久以前就出现了。它只是个研究函数的数学概念。 非同寻常的是，尽管它只定义了三种表达式：变量引用，函数调用和匿名函数，但它被发现是图灵完整的。 如今，lambda演算处于所有函数式语言的核心，包括javascript。由于这个原因，匿名函数往往被称作lambda表达式。

##### 柯里化
柯里化是把接受多个参数的函数变换成接受一个单一参数（最初函数的第一个参数）的函数，并且返回接受余下的参数而且返回结果的新函数的技术。



---
###### 思考
- 电路时序和FRP有什么关联呢？
- FRP和EDA是什么关系呢？

---
###### 更多学习
- [raym0ndkwan](http://blog.csdn.net/raym0ndkwan/article/details/8195592)
- [nowamagic1](http://www.nowamagic.net/librarys/veda/detail/2488)
- [nowamagic2](http://www.nowamagic.net/librarys/veda/detail/245)
