import UIKit

var str = ("12345 ABCDE", "12345 ABCDE")

print("——————— 1.起始与结尾字符 ———————")

let start_0 = str.0.startIndex
let end_0 = str.0.endIndex
str.0.insert("!", at: start_0)
str.0.insert("!", at: end_0) // 中文编码会返回一个乱码
print(str.0)

/* .startIndex 或 .endIndex 会定位目标字符串的第一个字符和最后一个字符的位置，旧版的 xcode 是定位倒数第二个字符的位置
 .insert 可以在目标字符串的某一位置插入一个字符，该位置为 at 后的 String.Index 值 */

print("——————— 2.取用字符串的起始或结尾子串 ———————")

print(str.1.prefix(3))
print(str.1.suffix(4))
print(str.1)

// str.prefix 或 str.suffix 会返回一个由原字符串前 Y 个字符或后 Y 个字符构成的新字符或字符串所形成的值 (Y 为 XXXfix 后括号内的 int 值)

print("——————— 3.取用字符串的中间子串 ———————")

let start_1 = str.1.index(str.1.startIndex, offsetBy: 3)
let end_1 = str.1.index(str.1.endIndex, offsetBy: -4)
print(str.1[start_1 ... end_1])

/* “str.index(str.XXXIndex, offsetBy: XX)” 可以简单理解为 “str.位置(从str.开始或结尾处, 数: XX个位置)”
 可以通过后接区间的形式，将定位的位置标识符(String.Index)接在字符串后以达到取出中间子串的目的 */
