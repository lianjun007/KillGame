import UIKit

print("——————— 1.字典的定义 ———————")

let dict_0 = [1: "aaa", 2: "bbb", 3: "ccc"]
var dict_1: Dictionary<Int, String> = [1: "ddd", 2: "eee", 3: "fff"]
var dict_2: [Int: String] = [1: "ggg", 2: "hhh", 3: "iii"]
let dict_3 = [Int: String]()
let dist_4: [Int: String] = [:]

/* 字典是由键值对(key:value)组成的集合类型
 字典中的元素之间无序且可以重复，不过元素对应的键值不可重复
 字典是可以看成是由两个集合构成的结构体，一个是键(key)集合，一个是值(value)集合，可以通过访问键值间接访问值 */

print("——————— 2.字典的基本操作 ———————")

dict_0.count
dict_0.isEmpty
dict_0.count == 0
dict_0[1] // 查询数据

dict_1[4] = "ggg"
dict_1[5] = "hhh"
dict_1[2] = "222"
print(dict_1)

// 增加新数据到字典中，如果已经有相应的 key 则修改该 key 所对应的 value

dict_1.updateValue("111", forKey: 1) // 更新字典中的数据
print(dict_1)

print("——————— 3.字典的合并 ———————")

for (key, value) in dict_1 {
    dict_2[key] = value
}
print(dict_2)

/* 与字符串、数组还有集合的拼接不同，字典的 key 是唯一的，所以字典的类似操作是合并；
 其实就是通过遍历一个字典的所有内容，然后将这些键值对使用 dict[XX] = "XXX" 依次修改或增加至靶字典中 */
