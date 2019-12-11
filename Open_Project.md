### 代码准备
- 核心代码
- 快速部署和运维代码
- 快速入门项目
- 项目脚手架（一键生成核心项目框架）
- 热门语言SDK
- 周边特性学习项目
- 测试或者压测项目

### 文档准备
- 项目产品文档（WiKi，readme）
- 项目技术架构和概要文档
- 用户快速入门文档
- 生产部署合运维文档
- 进阶文档，如：项目架构，模块解析文档，特性介绍文档
- RoadMap规划
- 贡献者说明文档
- 周边产品配合使用说明文档

### 确定开源协议
用户可以根据自己的业务场景，确定需要选择的开源协议。

![image](https://image.520mwx.com/static/e1bd732c84754973e601745f6e68b019.jpg)

GPL、BSD、MIT、Mozilla、Apache和LGPL

### 增加徽章
用户可以根据需要增加适用的徽章。
#### 常用动态徽章
``` 
持续集成状态 (Travis CI)
项目版本信息
开源协议
代码测试覆盖率
项目下载量
贡献者统计
```
#### 自定义徽章
徽标图标格式
```
https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg
```

带链接的徽标

[![](https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg)]({linkUrl})

徽标标题：徽标左边的文字
徽标内容：徽标右边的文字
徽标颜色：徽标右边的背景颜色，可以是颜色的16进制值，也可以是颜色英文。支持的颜色英文如下：

可以根据自己的需要定制一些自己的徽章,通过控制，增加更多样式。
```
https://img.shields.io/badge/{徽标标题}-{徽标内容}-{徽标颜色}.svg?{参数名1}={参数值1}&{参数名2}={参数值2}
```
常用的 query string 参数有：
```
style：控制徽标主题样式，style的值可以是： plastic | flat | flat-square | social 。
label：用来强制覆盖原有徽标的标题文字。
colorA：控制左半部分背景颜色，只能用16进制颜色值作为参数，不能使用颜色英文。
colorB：控制右半部分背景颜色。
```

- [更多信息，请查阅GitHub Badge](https://shields.io)

### 常用的工具
Travis-CI   
Codacy  代码质量检查
CodeFactor  代码质量检查

### 测试覆盖率

- C++项目:
make test + codecov

- Java项目:
gradle test + jacoco + codecov

- Rust项目:
cargo test + codecov
使用codecov便于ci集成，报告都是以行和方法为单位生成覆盖率。

```
apply plugin: 'jacoco'

jacocoTestReport {
    reports {
        xml.enabled true
        html.enabled true
    }
    afterEvaluate {
        classDirectories = files(classDirectories.files.collect {
            fileTree(dir: it,
                    exclude: ['**/test/**','**/proto/**', '**/example/**'])
        })
    }
}
```
