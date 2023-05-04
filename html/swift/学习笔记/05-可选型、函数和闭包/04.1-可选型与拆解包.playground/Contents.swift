import UIKit

print("——————— 1.可选型 ———————")

/* 在 Swift 中空值表示为 nil；默认情况下不允许直接定义空值，只有将其声明为可选型(potional)才可以
 可选型的值有两种可能，有值和空值 */

let str0: Optional<String> = nil
let str1: String? = nil

// 可选型的定义一般使用前者，Optional 后跟随的数据类型为该可选型有值时限定的数据类型，如下列情况

var int0: Optional<Int> = 777
int0 = nil

print("——————— 2.可选型的强制拆包 ———————")

var str2: Optional<String> = "hello world"
//error_0// print(str2)
print(str2!)

/* 直接打印可选型的结果会被 Optional("XXX") 包裹，并且会有个黄色提示，如 error_0 所示
 所以输出可选型时需要在标识符后加上一个 ! 进行强制拆包 (可以理解为与上面可选型定义中的 ? 相对应) */

print("——————— 3.可选型的解包 ———————")

str2 = nil
//error_1// print(str2!)
if str2 != nil {
    print(str2!)
}

/* 如 error_1 所示，如果 str2 的值为 nil，强制解包的输出结果就会出现问题
 我们可以通过 if 语句的条件限制，当 str2 为空值时不让其进入 if 语句，避免出现输出一个拆包后的空值的情况，这就是可选型的解包 */

print("——————— 4.可选绑定 if let (隐式解包) ———————")

if let str2 = str2 {
    print(str2)
}

// 将 str2 赋值给一个同名的 str2，且使用的是 let 赋值，若该值为空值则不赋值，若为可选型则改为一个定值，故达到与第一种方法相同的效果
