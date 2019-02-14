## 1. 拦截器的使用

- [在springBoot 2里添加拦截器](https://blog.csdn.net/qq_36013216/article/details/79866114)

## 说明
@Configuration  //指明该类为Spring 配置类
@Component //泛指组件，当组件不好归类的时候，我们可以使用这个注解进行标注。 
@EnableWebSocket  //声明该类支持WebSocket


```
@Configuration
@EnableWebSocket
@Component
@Slf4j
public class StompConfig implements WebSocketConfigurer {
 
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new BrokerStomp(), "/test").addInterceptors(intercept()).setAllowedOrigins("*").withSockJS();
    }

    @Bean
    public HandShakeWebSocketInterceptor intercept() {
        HandShakeWebSocketInterceptor intercept = new HandShakeWebSocketInterceptor();
        return intercept;
    }
}

```

```
public class HandShakeInterceptor implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
		Map<String, Object> attributes) throws Exception {
		
		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			HttpSession session = servletRequest.getServletRequest().getSession(false);
		 //TODO:
		}
		return true;
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
		// TODO

	}
}
```
---
## 2. Spring AOP注解失效及解决
基于以上对于动态代理原理的分析，我们来看以下两个常见的问题：

### 同一个类中，方法A调用方法B（方法B上加有注解），注解无效

针对所有的Spring AOP注解，Spring在扫描bean的时候如果发现有此类注解，那么会动态构造一个代理对象。

如果你想要通过类X的对象直接调用其中带注解的A方法，此注解是有效的。因为此时，Spring会判断你将要调用的方法上存在AOP注解，那么会使用类X的代理对象调用A方法。

但是假设类X中的A方法会调用带注解的B方法，而你依然想要通过类X对象调用A方法，那么B方法上的注解是无效的。因为此时Spring判断你调用的A并无注解，所以使用的还是原对象而非代理对象。接下来A再调用B时，在原对象内B方法的注解当然无效了。

#### 解决方法：

最简单的方式当然是可以让方法A和B没有依赖，能够直接通过类X的对象调用B方法。

但是很多时候可能我们的逻辑拆成这样写并不好，那么就还有一种方法：想办法手动拿到代理对象。

AopContext类有一个currentProxy()方法，能够直接拿到当前类的代理对象。那么以上的例子，就可以这样解决：
```
// 在A方法内部调用B方法
// 1.直接调用B，注解失效。
B()
// 2.拿到代理类对象，再调用B。
((X)AopContext.currentProxy()).B()
AOP注解方法里使用@Autowired对象为null
```

在之前的使用中，出现过在加上注解的方法中，使用其他注入的对象时，发现对象并没有被注入进来，为null。

最终发现，导致这种情况的原因是因为方法为private。因为Spring不管使用的是JDK动态代理还是CGLIB动态代理，一个是针对实现接口的类，一个是通过子类实现。无论是接口还是父类，显然都不能出现private方法，否则子类或实现类都不能覆盖到。

如果方法为private，那么在代理过程中，根本找不到这个方法，引起代理对象创建出现问题，也导致了有的对象没有注入进去。

所以如果方法需要使用AOP注解，请把它设置为非private方法。

##### EXAMPLE
```
@SpringBootApplication
public class Application {

    @Autowired
    BookingService bookingService;

    public static void main(String[] args) {
        bookingService.book("Alice", "Bob", "Carol");
    }
}
但可以使用@Bean

@SpringBootApplication
public class Application {

    @Bean
    BookingService bookingService() {
        return new BookingService();
    }

    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(Application.class, args);
        BookingService bookingService = context.getBean(BookingService.class);
        bookingService.book("1", "2", "3");
    }
}
```
#####  解释说明
简而言之：new出来的对象，脱离了Spring的容器

- IoC的一个重点是在系统运行中，动态的向某个对象提供它所需要的其他对象，是通过DI（Dependency Injection，依赖注入）来实现的。
- 创建合作对象B的工作是由Spring来做的，Spring创建好B对象，然后存储到一个容器里面，当A对象需要使用B对象时，Spring就从存放对象的那个容器里面取出A要使用的那个B对象，然后交给A对象使用，至于Spring是如何创建那个对象，以及什么时候创建好对象的，A对象不需要关心这些细节问题(你是什么时候生的，怎么生出来的我可不关心，能帮我干活就行)，A得到Spring给我们的对象之后，两个人一起协作完成要完成的工作即可。
- 控制反转IoC(Inversion of Control)是说创建对象的控制权进行转移，以前创建对象的主动权和创建时机是由自己把控的，而现在这种权力转移到第三方，比如转移交给了IoC容器，它就是一个专门用来创建对象的工厂，你要什么对象，它就给你什么对象，有了IoC容器，依赖关系就变了，原先的依赖关系就没了，它们都依赖IoC容器了，通过IoC容器来建立它们之间的关系。

### 内部类持有外部类的引用,获取Java匿名内部类持有的外部类对象

```
class Outer {
    static class Inner {
        public String publicString = "Inner.publicString";
    }
 
    static Other anonymousOther = new Other() {
        public String publicString = "Anonymous Other.publicString";
    };
 
    public Other getAnonymousOther() {
        return anonymousOther;
    }
 
    Other Other = new Other();
    public Other getOther() {
        return Other;
    }
}
 
class Other {
    public String publicString = "Other.publicString";
}


public static void main(String args[]) {
        printField(new Outer.Inner());
        System.out.println("\t");
        printField(new Outer().getAnonymousOther());
        System.out.println("\t");
        printField(new Outer().getOther());
    }
```

第二部分
```
public interface Callback {
    void callback(String s);
}


public class Main {

    private String mName;

    public Main(String name) {
        mName = name;
    }

    public static void main(String[] args) {
        Main main = new Main("Main");
        main.test();
    }

    private void test() {
        Callback callback = new Callback() {

            @Override
            public void callback(String s) {
                System.out.println(getName());
            }
        };
        callback.callback("");
    }

    private String getName() {
        return mName;
    }
}
```
