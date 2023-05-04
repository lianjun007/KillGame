import UIKit

print("——————— 1.集合的定义 ———————")

var set_0: Set<String> = ["1", "2", "3", "4", "5"]

// 定义集合；集合内的元素无序且不可重复

let array: Array<String> = ["11", "22", "33"]
let set_1 = Set(array) // Set(XXX) 代表了 XXX 集合

// 数组转集合

let set_2: Set<String> = Set()
let set_3: Set<String> = []

// 定义空集合

print("——————— 2.集合的基本操作 ———————")

set_0.count // 集合的计数
set_0.isEmpty // 判断集合是否为空
set_0.insert("222") // 插入元素
set_0.contains("222") // 判断集合是否包含元素

print("——————— 2.集合的插入和删除 ———————")

Set(set_0.prefix(2)) // 选择前 X 个元素
Set(set_0.suffix(3)) // 选择后 X 个元素
set_0.first // 选择第一个元素

set_0.remove("5") // 删除指定元素
set_0.removeFirst() // 删除第一个元素
print(set_0)
set_0.remove(at: set_0.startIndex) // 删除索引处元素
print(set_0)
set_0.removeAll() // 删除所有元素
print(Set(set_0.dropFirst()))

Set(set_1.dropFirst(2))
Set(set_1.dropLast(3))
print(set_1)

/* 集合无序，所以不能像数组那样通过序号准确的获取集合中的元素；但是集合在每次运行时的顺序是确定的，所以依旧可以使用相关的功能
 但是很多时候取用了集合中的部分元素后返回的内容并不是集合本身，而是一个切片 (slice)，切片和数组类似，可以使用 Set(XXX) 的方式转换为集合 */
