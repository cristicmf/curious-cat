# 快速排序
## 
- 快速排序使用分治法策略，把一个序列分别两个子序列
- 从数列中挑出一个子元素，称之为基准
- 重新排序数列，所有小于基准的元素，都移到基准的左边；所有大于基准的元素都移到基准的邮编。这个分区之后，改基准处于数列的中间，称为分区操作
- 对基准左边和右边的两个子集，进行递归操作，即不断的重复第一步和第二步，知道所有的子集剩下一个元素为止
```
var quicksort = function(arr){
    if(arr.length<=1){
        return arr;
    }
    var pivotIndex = Math.floor(arr.length/2)
    var pivot = arr.splice(pivotIndex,1)[0]
    var left = []
    var right = []
    for(var i=0;i<arr.length;i++){
        if(arr[i]<pivot){
            left.push(arr[i])
        }else{
            right.push(arr[i])
        }
    }
    return quicksort(left).concat([pivot],quicksort(right))
}
var array = [8,5,4,3,2134,567]
quicksort(array)
```
