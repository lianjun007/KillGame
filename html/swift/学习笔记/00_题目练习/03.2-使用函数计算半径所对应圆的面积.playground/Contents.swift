import UIKit



print("——————————————")

//2.给定一个半径，判断圆的面积
func area(radius: Double) -> String {//返回一个字符串，道理同上一题
    var Pi = 3.141592653//单独将π声明出来，为了方便修改π的精度
    var result = radius * radius * Pi//半径计算公式
    if radius > 0 {//搜了一下，大部分人说 0 不可以做一个有效半径，所以这里将 0 也归进去了
        var result = "以\(radius)为半径的圆的面积为\(result)"//将计算好的半径值和面积值用插值法插入字符串中，方便打印
        return result
    }
    else {
        let result = "\(radius)不是一个有效半径"//如果输入的半径值不大于 0，则显而易见没有面积，函数会返回一个表明该半径不是有效半径的字符串
        return result
    }
}
print(area(radius: 2))//【在 radius 后输入您要判断的半径值，打印结果会其所对应的圆的面积】
