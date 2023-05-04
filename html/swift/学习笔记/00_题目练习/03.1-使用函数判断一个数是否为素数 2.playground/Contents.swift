import UIKit
 
//1.用函数判断一个整数是否为素数。
func prime(number: Int) -> String{//定义一个函数，因为我想让这个函数可以直接返回告诉我们结果，加上才学了插入法，所以这里让他返回一个字符串
    if number <= 1 {//小于等于 1 的数都不是素数
        var result = "\(number)不是素数"//插入法将半径插入到字符串中，返回值会是一段设计好的字符串
        return result
    }
    var judge = 2
    for i in 2 ..< number {
        if number % i == 0 {
            break//如果出现等于 0 的情况 ，显而易见，这个 number 不是素数。故利用break跳出循环，进行后面的步骤
        }
        else {
            judge += 1
        }
    }
    if judge == number {//如果一个数是素数，循环运行结束后这个数对应的 judge 肯定与其本身相等（初始值为2）。故进入此处会返回一个表明该数是素数的字符串，否则会进入 else 返回一个表面该数不是素数的字符串
        var result = "\(number)是素数"
        return result
    }
    else {
        var result = "\(number)不是素数"
        return result
    }
}
print(prime(number: -2))//【在 number 后输入您要判断的整数，打印结果会告诉您这个数是否为素数】

print(prime(number: -7))
