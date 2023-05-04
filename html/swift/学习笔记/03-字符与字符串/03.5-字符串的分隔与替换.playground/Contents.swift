import UIKit

let str = (" a第一段aa第二段a第三段aaa第四段a aa第五段aaa")

print("——————— 1.单字符分隔符 ———————")

let str_0 = str.components(separatedBy: "a")
print(str_0, "  >>>  共有", str_0.count, "组字符或字符串")
let str_1 = str.split(separator: "a")
print(str_1, "  >>>  共有", str_1.count, "组字符或字符串")
let str_2 = str.split(separator: "a", omittingEmptySubsequences: false)
print(str_2, "  >>>  共有", str_2.count, "组字符或字符串")

/* 不准确的说 .components(separatedBy: "XXX") 或 .split(separator: "XXX") 会以引号中的内容为分隔符，将原有字符串分割为零散的字符或字符串
 实际上 .components 和 .split 都是以返回内容的形式达成效果，不会改变原有字符串的内容
 以上述代码为例 .component 可以简单的理解为将 a 替换为 ", "，而 .split 则可以理解为在此基础上去掉了所有的空字符串
 字符串组成的数组也可以用 .count 去统计数组内有多少个元素 (注意：数组不是元组)
 .split 内的 omittingEmptySubsequences 默认为 true，如果其为 false 则 .split 与 .components 一样 */

print("——————— 2.多字符分隔符 ———————")

let str_3 = str.components(separatedBy: "aa")
print(str_3, "  >>>  共有", str_3.count, "组字符或字符串")
let str_4 = str.split(separator: "aa")  // iOS16 之前的版本 .split 只能以单个字符为分隔符
print(str_4, "  >>>  共有", str_4.count, "组字符或字符串")

// 当出现 aa 字符被分隔符 aa 分隔的类似情况时，按顺序识别字符，即前两个 aa 被识别为分隔符

print("——————— 3.限定分隔符的分隔次数 ———————")

let str_5 = str.split(separator: "a", maxSplits: 3)
print(str_5, "  >>>  共有", str_5.count, "组字符或字符串")

// maxSplits 限定 .split 最多可以分隔几次

print("——————— 4.限定分隔符的分隔次数 ———————")

let str_6 = str.replacingOccurrences(of: "a", with: "b")
print(str, "  >>>  ", str_6)

// .replacingOccurrences(of: "XXX", with: "XXX") 会返回一个将原字符串中的 “of内容“ 替换为 “with内容” 后的字符串
