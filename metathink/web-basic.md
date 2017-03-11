#前端基础
## 事件冒泡
`
function callFuc(e){
	var btn = e.target
	if(!btn.classList.contains('active')){
		btn.classList.add('active')
	}else{
	 btn.classList.remove('active')
	}
}

for(var i = 0;i<btn.length;i++){
	btn.addEventListener('click',callFuc)
}

`
## 闭包
## 前端内存泄漏
## bind call apply
`
function fruits() {}
 
fruits.prototype = {
    color: "red",
    say: function() {
        console.log("My color is " + this.color);
    }
}
 
var apple = new fruits;
apple.say(); 
banana = {
    color: "yellow"
}
apple.say.call(banana);     //My color is yellow
apple.say.apply(banana);    //My color is yellow

`
## Clone
## 科里化
`
function add(x,y){
    if(y==undefined){
        return (z)=>x+z;
    }else{
        return x+y;
    }
}

function curry(func) {
  var fixedArgs = [].slice.call(arguments,1);
  return function() {
    args = fixedArgs.concat([].slice.call(arguments))
    return func.apply(null, args);
  };
}
//
const add = ar => ar.map(x => x + 1);
add([1, 2, 3]);
function hello(){console.log([].slice.call(arguments).join(''))};	
function curry(func) {
	  var fixedArgs = [].slice.call(arguments,1);
	  return function() {
	    args = fixedArgs.concat([].slice.call(arguments))
	    return func.apply(null, args);
	  };
	};var a = curry(hello,'hello');a('world')
	
function init(x) {
  var name = "Mozilla"; // name是被init创建的局部变量
  function displayName(y) { // displayName()是一个内部函数,
    return y+x // 它是一个使用在父函数中声明的变量的闭包
  } 
  return displayName
}
init(4)(3);
//通过柯里化，获取一个拥有记忆功能的函数，简化后续的多种计算操作，这就是闭包。
`
## 原型链 hasOwnProperty
`
Object.prototype.bar = 1;
var foo = {moo:'test'};
for(var i in foo){
    if(foo.hasOwnProperty(i))
    {
        console.log(i)
    }
}

`
