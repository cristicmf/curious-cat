## git tag
### 轻量级标签
轻量级标签实际上就是一个保存着对应提交对象的校验和信息的文件。要创建这样的标签，一个 -a，-s 或 -m 选项都不用，直接给出标签名字即可：

```
$ git tag v1.4-lw
```

### 含附注的标签

```
$ git tag -a v1.4 -m 'my version 1.4'
```

### 分享标签
默认情况下，git push 并不会把标签传送到远端服务器上，只有通过显式命令才能分享标签到远端仓库。其命令格式如同推送分支，运行 git push origin [tagname] 即可：

```
$ git push origin v1.5
```

### release 参考
[spring-boot](https://github.com/spring-projects/spring-boot/releases)
