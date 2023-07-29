//
//  EssayThemeViewController.swift
//  Fourm
//
//  Created by LianJun on 2023/7/29.
//
// 文章主题设置界面（高级阅读设置）
import UIKit

class EssayThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Initialize.view(self, "高级阅读设置", mode: .group)
        
        /// 底层的滚动视图，最基础的界面
        let underlyView = UIScrollView()
        underlyView.frame = Screen.bounds()
        view.addSubview(underlyView)
        
        /// 自定义设置开关的设置控件（对应的字典）
        let module0ControlDictionary = Setting.controlBuild(control: [.toggle], tips: "打开此开关可修改下列所有设置来增加阅读的个性化体验。关闭此开关则下列所有设置恢复默认（暂时没有保存预设功能），请谨慎操作！")
        module0ControlDictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: Spaced.navigation())
        underlyView.addSubview(module0ControlDictionary["view"]!)
        // 配置左侧文本内容
        (module0ControlDictionary["label1"] as! UILabel).text = "自定义设置"
        
        /// 模块标题`1`：代码块
        let moduleTitle1 = UIButton().moduleTitleMode("代码块", originY: module0ControlDictionary["view"]!.frame.maxY + Spaced.module(), mode: .basic)
        underlyView.addSubview(moduleTitle1)
        
        /// 代码块（模块`1`）的设置控件`1`（对应的字典）
        let module1Control1Dictionary = Setting.controlBuild(caption: "设置“代码块”的序号条", control: [.toggle, .toggle, .forward, .toggle])
        module1Control1Dictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: moduleTitle1.frame.maxY + Spaced.control())
        underlyView.addSubview(module1Control1Dictionary["view"]!)
        // 配置每一行的左侧文本内容
        let module1Control1LabelArray = ["序号条", "自动隐藏", "最大显示位数", "位数补全"]
        for i in 1 ... module1Control1LabelArray.count {
            (module1Control1Dictionary["label\(i)"] as! UILabel).text = module1Control1LabelArray[i - 1]
        }
        // 配置每一行关联的方法
        (module1Control1Dictionary["control1"] as! UISwitch).isOn = (UserDefaults.SettingInfo.string(forKey: .essayCodeNumber)! == "true") ? true: false

        (module1Control1Dictionary["control1"] as! UISwitch).addTarget(self, action: #selector(EssayThemeViewController.module1Control1Row1Switch), for: .valueChanged)
    }
}

extension EssayThemeViewController {
    @objc func module1Control1Row1Switch(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.SettingInfo.set(value: "true", forKey: .essayCodeNumber)
        } else {
            UserDefaults.SettingInfo.set(value: "false", forKey: .essayCodeNumber)
        }
        // 在需要切换主题的地方发送通知
        NotificationCenter.default.post(name: changeThemeNotification, object: nil)
    }
}
