import UIKit

print("——————— 1.数组 ———————")

var array_0: Array<String> = ["1", "2", "3"]
var array_1: Array<String> = ["4", "5", "6"]
var array_2 = Array(repeating: 7, count: 7) // 创建重复元素数组

// 数组中的元素有序且可以重复，在之前”字符串的分隔与替换“相关内容中出现的便是由一堆字符串构成的数组，所以很多内容不再赘述

print("——————— 2.数组的计数与取用 ———————")

array_0.count // 计数
array_0.isEmpty // 判断是否为空
array_0.first // 返回数组中第一个元素
array_0.last // 返回数组中最后一个元素
array_0.prefix(2) // 返回数组中前 X 个元素组成的数组
array_0.suffix(2) // 返回数组中后 X 个元素组成的数组

print("——————— 3.数组的修改与删除 ———————")

array_0[0] = "99" // 数组的修改

array_0.remove(at: 0)
array_1.removeAll()
array_2.removeFirst(1)
array_2.removeLast(1)

// 数组的删除 (改变原数组)

array_0.dropFirst(1)
array_0.dropLast(1)

// 数组的删除 (不改变原数组)

array_0.contains("2") // 判断是否包含数据

print("——————— 3.数组的拼接 ———————")

var result_0 = array_0 + array_1
array_0.append("7")
array_0.append(contentsOf: array_1)
array_0.insert("7", at: 2)
array_0.insert(contentsOf: array_1, at: 2)

// .append 是拼接，字符串的拼接类似；.insert 是插入，插入位置是 at 的值；contentsOf: 可以接或插入一个数组
