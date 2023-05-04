import UIKit

print("——————— 1.三目运算符 ———————")

// 三目运算符是 if else 的一种简化写法

let bool = true

bool ? true : false
bool ? "正确" : "错误"
bool ? print("正确") : print("错误")
print(bool ? "正确" : "错误")

// 如果问号前的 bool 值为 true，则返回冒号前的内容，否则返回冒号后的内容；可以简单的理解为 ”(条件)是否正确 ? 如果正确() : 如果不正确()“

let num = (7, 10)
var result = num.0 > num.1 ? num.1 : num.0
print(result)

// 三目运算符的优先级大于等号，所以上述代码先运算三目运算符，其运算所得出的结果将赋值给 result
