import UIKit

print("执行循环A：break跳出while循环")
print("..............")
var num0 = 0
while num0 < 7 {
    print("这是数字",num0)
    num0 += 1
    if num0 == 4 {
        print("..............")
        print("循环A运行至第",num0,"次时被终止，即将结束")
        break
    }
}
print("循环A已结束，一共输出了",num0,"个数字")
//break会令循环立即终止，随即跳出循环。
//如上述代码所示，当满足循环中if语句后的boor值为true时，进入该if语句，执行break。
//当break执行后，while循环立即终止，跳出循环。

print("——————————————")

print("执行循环B：continue跳出while循环")
print("..............")
var num1 = 0
var num2 = 0
while num1 < 7 {
    if num1 == 4 {
        num1 += 777
        print("..............")
        print("循环B运行至第",num2,"次时被终止，即将结束")
        continue
    }
    print("这是数字",num1)
    num1 += 1
    num2 += 1
}
print("循环B已结束，一共输出了",num2,"个数字")
//当循环运行到continue时会终止该循环后续代码的运行，转而跳到循环开头重新运行。
//如上述代码所示，当满足循环中if语句后的boor值为true时，进入该if语句，令num4的值增加5，然后执行continu，随即转到循环开头。
//因为此时num4已经大于7了，while后的boor值已经为false，故while循环不再继续，也就实现了终止的效果。
