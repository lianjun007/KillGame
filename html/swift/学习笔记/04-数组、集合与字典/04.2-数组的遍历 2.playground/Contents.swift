import UIKit

let array = ["1", "2", "4"]

print("——————— 1.普通遍历 ———————")

for i in 0 ..< array.count {
    print(array[i], " >>>  普通遍历")
}

// 直接使用 for in 遍历整个数组

print("——————— 2.for in 遍历 ———————")

for item in array {
    print(item, " >>>  item 遍历")
}

for item in array[1 ... 2] {
    print(item, " >>>  item + 区间遍历")
}

// 这两种使用 item 遍历整个数组，后者可以限定遍历的范围 (由序号决定，如果省略区间的半边，则默认从第一个数开始遍历或遍历到最后一个数)

print("——————— 3.枚举方式遍历 ———————")

for item in array.indices {
    print("序号：", item, " >>> ", array[item])
}

// 若使用 .indices，item 会变成数组内的序号，array[item] 才是序号对应数组中的数字

for (index, value) in array.enumerated() {
    print(value, " >>> ", "序号：", index)
}

// .enumerated()，自行观察数据对应关系
