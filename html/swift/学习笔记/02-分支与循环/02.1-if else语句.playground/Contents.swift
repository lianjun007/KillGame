import UIKit

print("——————— 1.if else 语句 ———————")

let bool = (true, false)

if bool.0 {
    print("正确")
}
else{
    print("错误")
}

if bool.1 {
    print("正确")
}
else{
    print("错误")
}

/* if else 可以理解为”如果、否则“的意思
 if 后跟一个 bool 值，该 bool 值若为 true 则运行 if 后花括号的内容，否则运行 else 后花括号的内容
 如果直接在 if 后面跟随一个确定的 bool 值，Swift 会出现黄色报错，提示有代码从来都不会被使用 (显然，bool 值如果被确定了，那么一定有一种可能是无效的) */

print("——————— 2.else if ———————")

let scores = -10

if scores == 100, scores <= 100 {
    print("满分")
}
// 在此处，”,“ 与 “&&” 都可表示 ”与“ 运算符，如需使用 ”或“ 运算符，则只有用 “||”
else if scores >= 90, scores <= 100 {
    print("优秀")
}
else if scores >= 80, scores <= 100 {
    print("良好")
}
else if scores >= 60, scores <= 100 {
    print("及格")
}
else if scores > 100 || scores < 0 {
    print("异常")
}
else{
    print("不及格")
}

/* 这段代码有更好的写法，不过这样方便同时融入 “与” 运算符和 ”或“ 运算符
 if 可以添加任意数量个 else if，相当于 ”否则如果“ 的意思；else if 后仍然需要跟随 bool 值；
 整个语句会根据限定条件逐步执行，如果前置 if 后的 bool 值不为 true，且该 if 后的 bool 值为 true，则执行该 if 后的内容 (所以要注意前后条件是否矛盾，比如上述代码就有矛盾之处，矛盾的话并不会报错，但是没有必要)
 if 可以单独存在，else 不是必要的 */
