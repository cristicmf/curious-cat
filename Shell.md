# 常用shell命令
## 网络
### 查看网络
```
netstat
netstat ip port
```
### 抓包

```
tcpdump -Xns0 port 9229
```
### 查看端口
- ps -ef|grep port 
- losf -i:port

---
## 文件
### 打包和压缩文件
```
zip -r ./xahot.zip ./* -r表示递归
zip [参数] [打包后的文件名] [打包的目录路径]

zip –q –r xahot.zip /home/wwwroot/xahot
```
### 文件操作
```
tail -f 文件
```
---
## 系统相关
### 查看内存
```
df -h
du -sh *
```
---
## Vim
vim  技巧
- 格式化全文指令　　gg=G
- 自动缩进当前行指令　　==
- 格式化当前光标接下来的8行　　8=
- 格式化选定的行　　v 
- 选中需要格式化的代码段 =
- 
:$ 跳转到最后一行
:1 跳转到第一行
第二种方式

shift+g 跳转到最后一行
gg 跳转到第一行
