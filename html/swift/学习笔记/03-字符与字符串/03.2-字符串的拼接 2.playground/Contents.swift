import UIKit

print("——————— 1.字符串的拼接 ———————")

var title = ("打老虎", "打老虎")
let str = ("一二三四五", "上山打老虎", "老虎打不着", "打到小松鼠")
let symbol = ("——————", "，", "。")

let result_0 = title.0 + symbol.0 + str.0 + symbol.1 + str.1 + symbol.2 + str.2 + symbol.1 + str.3 + symbol.2
print(result_0)

// 最简单的就是使用加号直接拼接字符串

title.0.append(symbol.0)
title.0.append(str.0)
title.0.append(symbol.1)
title.0.append(str.1)
title.0.append(symbol.2)
title.0.append(str.2)
title.0.append(symbol.1)
title.0.append(str.3)
title.0.append(symbol.2)
print(title.0)

// 使用 append 进行一级一级的拼接也可以实现字符串的拼接

let result_1 = title.1.appending(symbol.0).appending(str.0).appending(symbol.1).appending(str.1).appending(symbol.2).appending(str.2).appending(symbol.1).appending(str.3).appending(symbol.2)
print(result_1)

/* appending 与使用加号的效果是类似的，整个操作不会改变原有字符串的任何内容
 而 append 则不同，虽然需要多次拼接，但是其可以在被拼接的字符串的内容上直接做修改 */
