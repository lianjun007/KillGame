import UIKit

//定义函数的格式

func function0() -> Void {
    print("这是没有参数和返回值的函数1")
}
function0()

func function1() -> () {
    print("这是没有参数和返回值的函数2")
}
function1()

func function2() {
    print("这是没有参数和返回值的函数3")
}
function2()

func function3(num: Int, str: String){
    print("这是", str, "的函数", num)
}
function3(num: 4, str: "有参数无返回值")

func function4() -> String {
    return "这是有返回值无参数的函数5"
}
let result0 = function4()
print(result0)

func function5(num: String) -> String {
    return "这是有参数和返回值的函数" + num
}
print(function5(num: "6"))

//函数的参数

var name = "qhuiyan"
var a = "七绘言"

func Grades(name a: String, subject b: String, scores c: Int) -> (String, Double) {
    let result = Double(c) / 1.5
    return (a + "的" + b + "成绩", result)
}

let result1:(String, Double) = Grades(name: "QHuiYan", subject: "Swift", scores: 100)

print(result1)

//默认参数

func num0(_ a: Int, _ b: String) {
    print(a, b)
}
num0(7, "七")

func num1(_ a: Int = 12, _ b: String = "七绘言") {
    print(a, b)
}
num1(8)

//可变参数

func count(numbers: Int...) -> Int {
    var count = 0
    for _ in 0 ..< numbers.count {
        count += 1
    }
    return count
}

count()
count(numbers: 10)
count(numbers: 10, 20)
count(numbers: 10, 20, 30)

//传入传出参数

func swapInt(d: inout Int, e: inout Int) {
    let tmp = d
    d = e
    e = tmp
}

var d = 10
var e = 20
print("d=\(d), e=\(e)")
swapInt(d: &d, e: &e)
print("d=\(d), e=\(e)")
