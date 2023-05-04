import UIKit

//重载函数

func numAdd(num1: Int, num2: Int) -> Int {
    return num1 + num2
}
numAdd(num1: 1, num2: 2)

func numAdd(num1: Int, num2: Int, num3: Int) -> Int {
    return num1 + num2 + num3
}
numAdd(num1: 1, num2: 2, num3: 4)

func numAdd(num1: Double, num2: Double) -> Double {
    return num1 + num2
}
numAdd(num1: 1.5, num2: 3.2)

func numAdd(a num1: Int, b num2: Int) -> Int {
    return num1 - num2
}
numAdd(a: 3, b: 3)
