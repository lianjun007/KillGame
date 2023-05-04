import UIKit

var num = (0, 0, 0)

print("——————— 1.break ———————")

while num.0 < 7 {
    print("这是数字", num.0)
    num.0 += 1
    if num.0 == 4 {
        num.0 -= 1
        break //break 会令循环立即终止，随即跳出循环
    }
}
print("循环完整的运行了", num.0, "次")

print("——————— 2.continue ———————")

while num.1 < 7 {
    if num.2 == 4 {
        num.1 += 1
        num.2 += 1
        continue // 当循环运行到 continue 时会终止该循环后续代码的运行，转而跳到循环开始处继续运行
    }
    print("这是数字", num.1)
    num.1 += 1
    num.2 += 1
}
print("循环运行了", num.2, "次")

// break 和 continue 不仅仅可以用在 while 循环中，还可以运用在 for in 循环中
