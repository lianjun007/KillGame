//import UIKit

//001
//
//b:

//var num = 0
//for i in 0 ... 48 {
//    let a = i * 10
//    num = a + num + 15
//}
//print(num)
//
//a:
//
//var num = 0
//for i in 0 ... 24 {
//    let a = i * 20
//    num = a + num + 10
//}
//print(num)
//
//func a()
//
//第三题
//b：
//
//func a(a: Int, b: Int) {
//    print("面积是\(a * b)")
//}
//
//a(a: 10, b: 8)
//
//let b = { (a: Int, b: Int) in
//    print("面积是\(a * b)")
//}
//
//a(10, 8)
//
//a：参数可能不对，自己改
//func a(a: Int, b: Int, c: Int) {
//    print("ti积是\(a * b * c)")
//}
//
//a(a: 10, b: 8, c: 6)
//
//let b = { (a: Int, b: Int) in
//    print("ti积是\(a * b *c)")
//}
//
//a(10, 8, 6)
//
////刚才那个第三题是第四题
////这个是第2题范围都自己改
//var score = Int.random(in: 0 ... 100)
//var scoreAll: Array<String> = ["youxiu", "lianghao","hege","jige","bujige"]
//b卷的switch：
//switch score {
//case 90 ... 100 :
//    print(scoreAll[0])
//case 80 ... 90 :
//    print(scoreAll[1])
//case 90 ... 100 :
//    print(scoreAll[2])
//case 90 ... 100 :
//    print(scoreAll[3])
//default:
//    print(scoreAll[4])
//}
//a卷的if else
//if 90 ... 100 ~= score {
//    print(scoreAll[0])
//}
//else if 90 ... 100 ~= score {
//    print(scoreAll[1])
//}
//else if 90 ... 100 ~= score {
//    print(scoreAll[2])
//}
//else if 90 ... 100 ~= score {
//    print(scoreAll[3])
//}
//else {
//    print(scoreAll[3])
//}

a卷子第三题
func a(a: Int, b: Int) {
    if a > b{
        print("\(a)大于\(b)")
    }
    else if a < b{
        print("\(a)小于\(b)")
    }
    else{
        print("\(a)等于\(b)")
    }
}
a(a: 3, b: 6)

func a(a: Double, b: Double) {
    if a > b{
        print("\(a)大于\(b)")
    }
    else if a < b{
        print("\(a)小于\(b)")
    }
    else{
        print("\(a)等于\(b)")
    }
}

a(a: 2.3, b: 4.3)

b卷子第三题
func a(a: Int, b: Int) {
    if a > b{
        print("a大于b")
    }
    else if a < b{
        print("axiao于b")
    }
    else{
        print("a dengyu b")
    }
}
a(a: 3, b: 6)

func a(a:Int, b:Int, c:Int) {
    if a > b{
        print("a大于b")
    }
    else if a < b{
        print("axiao于b")
    }
    else{
        print("a dengyu b")
    }
}

a(a: 3, b: 4, 5)
