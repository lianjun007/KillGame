import UIKit

//var greeting = "Hello, playground"
//
////日期结构体，date：日期 calender：日历
//
//let date1 = Date()
//print(date1)
//
//let formatter = DateFormatter()
//
//formatter.dateFormat = "yyyy.mm.dd HH.mm.ss"
//
//print(formatter.string(from: date1))
//
//print(date1)
//
//// 转农历
////var component = DateComponents()
////component.year = 2022
////component.month = 2022
////component.day = 2022
////component.hour = 2022
////component.minute = 2022
////component.second = 2022

var dada = Data()

let str0 = "你好，世界"
let result = str0.data(using: .utf8)!


let str1 = String(data: result, encoding: .utf8)
let str2 = String(decoding: result, as: UTF8.self)

let url = URL(string: "https://www.bing.com/?setmkt=en-US&setlang=en-US")
url?.absoluteURL

var urlCom = URLComponents()
urlCom.scheme = "https"
urlCom.host = "www.baidu.com"
urlCom.path = "/login"
urlCom.queryItems = [URLQueryItem(name: "name", value: "张三"), URLQueryItem(name: "pwd", value: "123456")]

let comURL = urlCom.url

comURL?.scheme
comURL?.host
comURL?.path
comURL?.query

print("str")
