import UIKit

print("——————— 1.for in 循环 ———————")
var i = 777
var num_0 = 0

for i in (0 ..< 4).reversed() {
    print("第", i + 1, "个数是", i)
    num_0 += 1
}
// .reversed() 将区间的运行顺序倒置

print("一共有", num_0, "个数字")
print(i)

/* for in 循环中，for 后面的一般跟随的 i 似乎是 index 的意思，表示索引；
 i 从 in 后的区间的第一个整数开始，每进入一次 for 循环，i 的值就会变为区间内的下一个整数 ，直到区间最后一个整数为止，然后终止循环；
 如果不需要用到 i，可以使用 _ 替代之 (如 for _ in (0 ..< 7) {})；
 需要注意的是，这个 for in 中的索引值 i 不会与循环外的内容产生任何交互 */

print("——————— 2.序列函数 stride ———————")

var num = (0, 0)

for _ in stride(from: 1, to: 50, by:2) {
    num.0 += 1
}
print(num.0)

for _ in stride(from: 1, through: 50, by:1) {
    num.1 += 1
}
print(num.1)

/* stride 可以看成是一个功能更多的区间，其中 by 后的数值表示相邻两数的差值 (默认为后者减去前者，可以为负数)；
 from to 表示左开右闭闭区间，form through 则表示开区间 */
