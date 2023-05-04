import UIKit

print("——————— 1.协议 ———————")



//题目：把不同的类型放进一个数组内

print("——————— 2.协议的继承与合并 ———————")

protocol prot_0 {
    func func_0()
}

protocol prot_1: prot_0 {
    func func_1()
}

protocol prot_2: prot_1 {
    func func_2()
}

protocol prot_3: prot_2 {
    func func_3()
}

protocol prot_4: prot_3 {
    func func_4()
}

class str: prot_4 {
    func func_0() {
        
    }
    
    func func_4() {
        
    }
    
    func func_3() {
        
    }
    
    func func_2() {
        
    }
    
    func func_1() {
        
    }
    

}

// 扩展

protocol prot7 {
    func func_0()
}

extension prot7 {
    func func_1() {
        
    }
}

class a: prot7 {
    func func_0() {
        
    }
    func func_1() {
        
    }
}
// 下周三作业；如何将不同的对象装进数组里面，并且可以取出来判断，代理模式

// 代理模式


protocol 任务{
    func 必要工作()
}

extension 任务 {
    func 工作1() {
        print("完成工作1")
    }
    func 工作2() {
        print("完成工作2")
    }
}

class 员工1: 任务 {
    var str = "员工1"
    func 必要工作() {
        print("员工1完成必要工作")
    }
    func 工作1() {
        print(str)
    }
}

class 员工2: 任务 {
    var str = "员工2"
    func 必要工作() {
        print("员工2完成必要工作")
    }
    func 工作2() {
        print(str)
    }
}

class 老板 {
    var 分配工作: 任务
    
    init(分配工作: 任务) {
        self.分配工作 = 分配工作
    }
    
    func 必要工作() {
        self.工作1()
    }
    func 工作1() {
        self.工作2()
    }
    func 工作2() {
        self.必要工作()
    }

}

let a = 老板(分配工作: 员工1(工作))

let b = 老板(分配工作: 员工2(工作))

class numSutup =

