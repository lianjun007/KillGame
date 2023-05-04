import UIKit

//函数计算一个数的平方
func square(number: Double) -> Double {
    return number * number
}

var num1 = 12.32
print(num1, "的平方为", square(number: num1))
