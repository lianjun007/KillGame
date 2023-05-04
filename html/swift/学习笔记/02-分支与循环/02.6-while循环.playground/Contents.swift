import UIKit

print("——————— 1.while 循环 ———————")

var num = (0, 10, 0)

while num.0 < 4 {
    print("这是数字", num.0)
    num.0 += 1
}
print("循环执行了", num.0, "次，输出了", num.0, "个数字")

// while 循环与 for in 循环不同，while 是通过判断其后跟随的 boor 值是否为 true，来决定是否进入循环的 (所以需要注意，不要写出死循环)

print("——————— 2.while 后置 ———————")

repeat {
    print("这是数字", num.1)
    num.1 += 1
    num.2 += 1
} while num.1 < 7
print("循环执行了", num.2, "次，输出了", num.2, "个数字")

// repeat while 可以将条件后置以达到让循环至少执行一次再结束的效果
