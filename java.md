## 拦截器

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
