#### 编写合约常见问题和注意事项

##### 合约写日志

- 在合约代码中
```solidity
contract SimpleDemo {
    int256 storedData;
    event AddMsg(address indexed sender, bytes32 msg);
    ...

    function setData(int256 x) public{
        storedData = x;
        AddMsg(msg.sender, "[in the set method]");
    }
    ...
}

```

- 在脚本

```javascript
    var event = instance.AddMsg({}, function(error, result) {
        if (!error) {
            var msg = "AddMsg: " + utils.hex2a(result.args.msg) + " from "
            console.log(msg);
            return;
        } else {
            console.log('it error')
        }
    });

    function hex2a(hex) {
    var str = '';
    for (var i = 0; i < hex.length; i += 2) {
        var v = parseInt(hex.substr(i, 2), 16);
        if (v) str += String.fromCharCode(v);
    }
    return str;
}
```
##### 重载方法
- 兼容后期扩展
##### mapping的使用
- 大量的使用mapping,导致性能变差
##### 调用合约注意事项

- 合约调用合约，不能使用不定长字符串作为参数
```
 string 是不可以，bytes32 可以
```

- memory 定义的内存字段
```
1.不能超过16个
2.一般使用数组进行存储
3. 合约之间调用，参数传递，不能使用String类型
4. 合约查找数据时，减少遍历，可以使用mapping替代
```
##### 智能合约架构设计

##### 设计智能合约日志

##### 技巧
- [合约灰度部署](https://gist.github.com/cristicmf/b48e309763e39a5a531cc7513c56f164)

##### 学习资料

