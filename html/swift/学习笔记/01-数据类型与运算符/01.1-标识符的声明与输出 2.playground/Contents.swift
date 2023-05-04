import UIKit

print("——————— 1.var 与 let ———————")

var str_0 = "variable_0"
str_0 = "variable_1"
str_0 = "variable_2"
//error_0// str_0 = 0101010

let str_1 = "let_0"
//error_1// let str_1 = "let 1"

/* var 和 let 都是用来定义一个标识符的具体值，前者定义的是变量，后者是常量；
 变量可以修改，但是修改时只能将其改为同类型的值，如 error_0 中将原先的 String 类型修改为 Int 类型后会报错；
 常量不可修改，如 error_1 */

var `var` = 111

print(`var`)

//在 xcode 中想要使用系统引用的标识符，需要使用反引号包裹 (不建议使用)

print("——————— 2.print ———————")

print("String_0")
print(0101010.1)

print(str_0)
print(str_1)

print(str_0, str_1, "Hello World")

/* print 输出将括号内的内容输出至控制台；
 数字与已经定义过的标识符可以直接输出，普通的字符串需要加上双引号；
 print 输出后默认接换行符(\n)，想通过一个 print 输出多个值，则使用逗号隔开即可 */
