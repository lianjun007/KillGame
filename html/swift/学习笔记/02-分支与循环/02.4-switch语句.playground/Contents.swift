import UIKit

print("——————— 1.switch 语句 ———————")

// switch 语句在可以替代多分支的 if else 语句，使得判断逻辑更为清晰。

let score = 177

switch score {
// 不仅仅是 switch 所跟随的条件，很多条件都可以使用括号包裹住，但一般情况下省略
case 0 ..< 60 :
    print("不及格")
case 60 ..< 70, 70 ..< 80 :
    print("及格")
// 此处逗号表示"或"的意思；此处不可用逻辑符号，因为 case 后所谓的条件不是一个 bool 值
case 80 ..< 90 :
    print("良好")
case 90 ..< 100 :
    if score < 96 {
        print("优秀")
    }
    else{
        print("极佳")
    } // case 的内容可以为任何东西，哪怕是上万行代码
case 100 :
    print("满分")
    fallthrough // 穿透，可以无视条件紧接着执行下一个分支的内容 (可以穿透到 default 分支)
case 777 :
    print("再接再厉")
default :
    print("异常")
// 如果 case 中的条件全部不满足则执行 default 后的内容
}

/* switch 后是判断对象，case 后是对应的判断条件：
 1、数字(以 case 3.14 : 为例)，不论是整型数还是浮点数，都是 name == 3.14 的简写
 2、区间(以 case 0 ... 100 : 为例)，是 0 ... 100 ~= name 的简写
 3、字符串(以 case "abc" : 为例)，是 name == "abc" 的简写
 执行这些判断后会返回一个 bool 值，若为 true 则执行 case 后的内容，否则跳过该 case
 
 default 不像 else 那么严格执行，所以尽量在 case 分支里面就将可能出现的条件写完，避免让程序可以执行到 default 分支
 要注意的是，和 else 分支不同，default 分支不可缺失
 如果 case 分支写的条件比较少是有可能有报错情况出现的，后面学到枚举时会进一步了解 */

print("——————— 2.switch 的其他应用 ———————")

// switch 语句可以判断的类型非常之多，比如下列的颜色判断

let color = UIColor.red

switch color {
case .red :
    print("是红色")
default:
    print("不是红色")
}

