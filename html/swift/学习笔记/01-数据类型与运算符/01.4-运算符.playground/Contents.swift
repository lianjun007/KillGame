import UIKit

var (num1, num2) = (10, 3)

print("——————— 1.算数运算符 ———————")

num1 + num2 // 加
num1 - num2 // 减
num1 * num2 // 乘
num1 / num2 // 除
num1 % num2 // 取余

// 最基础的算数运算符，用于对两个数进行基础的算数运算；需要注意的是，运算符两边需要保证数据类型的一致 (其他的运算符也亦是如此)

print("——————— 2.赋值运算符 ———————")

var result = 10

result += num1
result -= num1
result *= num1
result /= num1
result %= num1

print(result)

// 赋值运算，上述第一个式子等价于 resule = resule + num，其余的同理

print("——————— 3.比较运算符 ———————")

num1 > num2 // 大于
num1 < num2 // 小于
num1 >= num2 // 不小于
num1 <= num2 // 不大于
num1 == num2 // 等于
num1 != num2 // 不等于

// 比较运算符判断两个数之间的大小关系是否符合二者之间的符号，随后输出一个bool值 (符合则输出 true，否则输出 false)

print("——————— 4.区间和包含运算符 ———————")

1 ... 10
1 ..< 10

// 只有上述两种区间，前者表示闭区间 [1,10]，后者表示左闭右开区间 [1,10)

1 ... 100 ~= 50
1 ... 100 ~= 150

// 包含运算符后置数是否属于前置区间，随后输出一个bool值 (属于则输出 true，否则输出 false)

print("——————— 5.逻辑运算符 ———————")

// 逻辑运算符可以连接多个 bool 值并根据对应的符号进行逻辑判断

true && true
true && false
true && true && false

// “与” 运算符所连接的 bool 值必须都是 true 才会返回 true，否则返回 false

true || true
true || false
false || false

// “或” 运算符所连接的 bool 值只需有一个为 true 就会返回 true，否则返回 false

!true
!false

// “取反” 运算符会将其后接的 bool 值改变 (不论是 “取反“ 运算符的优先级更高还是 “与”、”或“ 运算符的优先级更高，似乎都不会影响结果)
