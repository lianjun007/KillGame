import UIKit

print("——————— 1.元组 ———————")

// 元组是一种数据类型，可以用于定义一组数据，其中的每一个数据都被称为该元组的元素

var tuple_0 = ("String_0", "String_1", 0, 1)
var tuple_1 = (str_0: "String_0", str_1: "String_1", int_0: 0, int_1: 1)

print(tuple_0, tuple_0.0, tuple_0.1, tuple_0.2, tuple_0.3)
print(tuple_1, tuple_1.0, tuple_1.1, tuple_1.2, tuple_1.3)
print(tuple_1.str_0, tuple_1.str_1, tuple_1.int_0, tuple_1.int_1)

/* 元组 tuple_0 中的元素所对应的标识符，就是将 tuple_0.N 中的 N 替换为该元素在元组中的序号 (从0开始计数)；
 tuple_1 也可如此，不过其内元素每一个都有了对应的名称，更建议采用 tuple_1.name 这种规则来取用元素 */

var (num_1, num_2) = (1, 2)

// 还可以使用这种前后括号内的内容相互对应的格式来同时定义多个标识符
