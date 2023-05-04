import UIKit

print("——————— 1.字符串的删除 ———————")

var str = ("AAA_BBBB_CCCCC", "AAA_BBBB_CCCCC")

str.0.removeFirst(3)
str.0.removeLast(5)
print(str.0)

//前者删除原字符串起始处的 n 个字符，后者删除原字符串结尾处的 n 个字符，n 为括号内的 int 值

str.0.removeAll()
print(str.0, "mark")

// 删除字符串内的所有字符 (removeXXX 的删除会改变原字符串内容)

str.1.dropFirst(3)
str.1.dropLast(5)
print(str.1)
print(str.1.dropFirst(3).dropLast(5)) // str.dropXXX 可以直接打印和被标识符接收，str.removeXXX 则不可以

/* 前者返回原字符串去掉起始处的n个字符的新字符串，后者返回原字符串去掉结尾处的n个字符的新字符串，n 为括号内的 int 值
 与 removeXXX 不同，dropXXX 并不会改变原字符串本身的内容 */

print("——————— 2.大小写修改 ———————")

str.1.lowercased()
str.1.uppercased()
str.1.capitalized
print(str.1)

/* str.lowercased() 将字符串内的所有英文字符都改为小写
 str.uppercased() 将字符串内的所有英文字符都改为大写
 str.capitalized 将字符串内的所有英文字符进行分组，每组的第一个字符改为大写，其余字符则改为小写
 这三种关键字都不会改变字符串本身的内容，而且可以直接打印和被标识符接收 */
