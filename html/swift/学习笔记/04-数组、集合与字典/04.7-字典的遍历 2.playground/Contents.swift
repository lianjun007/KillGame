import UIKit

//字典
var dict0: Dictionary<String, String> = ["01": "aaa", "02": "bbb", "03": "ccc"]
var dict1: [String: String] = ["04": "ddd", "05": "eee", "06": "fff"]
var dict2 = [String: String]()
var dist3: [String: String] = [:]

dict0.count
dict0.isEmpty
dict0.count == 0

let a = dict0["01"]
dict0["a"]

dict0["02"] = "qhy"//修改字典中的一项
