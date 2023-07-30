//
//  EssayThemeViewController.swift
//  Fourm
//
//  Created by LianJun on 2023/7/29.
//
// 文章主题设置界面（高级阅读设置）
import UIKit

class EssayThemeViewController: UIViewController {
    
    /// 底层的滚动视图，最基础的界面
    let underlyView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        Initialize.view(self, "高级阅读设置", mode: .group)
        
        // 添加底层视图
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
        (module1Control1Dictionary["control1"] as! UISwitch).addTarget(self, action: #selector(module1Control1Row1Switch), for: .valueChanged)
        
        /// 代码块（模块`1`）的设置控件`2`（对应的字典）
        let module1Control2Dictionary = Setting.controlBuild(control: [.toggle, .toggle, .forward])
        module1Control2Dictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: module1Control1Dictionary["view"]!.frame.maxY + Spaced.setting())
        underlyView.addSubview(module1Control2Dictionary["view"]!)
        // 配置每一行的左侧文本内容
        let module1Control2LabelArray = ["去除前后空行", "语法高亮", "自定义高亮"]
        for i in 1 ... module1Control2LabelArray.count {
            (module1Control2Dictionary["label\(i)"] as! UILabel).text = module1Control2LabelArray[i - 1]
        }
        // 配置每一行关联的方法
        (module1Control2Dictionary["control1"] as! UISwitch).isOn = (UserDefaults.SettingInfo.string(forKey: .essayCodeFristAndList)! == "true") ? true: false
        (module1Control2Dictionary["control1"] as! UISwitch).addTarget(self, action: #selector(module1Control2Row1Switch), for: .valueChanged)
    }
}

extension EssayThemeViewController {
    @objc func module1Control1Row1Switch(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.SettingInfo.set(value: "true", forKey: .essayCodeNumber)
        } else {
            UserDefaults.SettingInfo.set(value: "false", forKey: .essayCodeNumber)
        }
        // 切换主题相关设置，发送通知
        NotificationCenter.default.post(name: changeThemeNotification, object: nil)
    }
    @objc func module1Control2Row1Switch(sender: UISwitch) {
        if sender.isOn {
            UserDefaults.SettingInfo.set(value: "true", forKey: .essayCodeFristAndList)
        } else {
            UserDefaults.SettingInfo.set(value: "false", forKey: .essayCodeFristAndList)
        }
        // 切换主题相关设置，发送通知
        NotificationCenter.default.post(name: changeThemeNotification, object: nil)
    }
}

// 扩展，放置界面显示效果修改后执行的所有方法
extension EssayThemeViewController {
    /// 当屏幕旋转时触发的方法
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // 记录当前滚动视图的偏移量
        var offset: CGPoint?
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                offset = scrollView.contentOffset
                break
            }
        }
        
        // 屏幕旋转中触发的方法
        coordinator.animate { [self] _ in // 先进行一遍重新绘制充当过渡动画
            transitionAnimate(offset ?? CGPoint(x: 0, y: 0))
        } completion: { [self] _ in
            transitionAnimate(offset ?? CGPoint(x: 0, y: 0))
        }
    }
    
    func transitionAnimate(_ offset: CGPoint) {
        // 移除旧的滚动视图
        for subview in self.underlyView.subviews {
            subview.removeFromSuperview()
        }
        
        // 重新构建界面
        viewDidLoad()

        // 将新的滚动视图的偏移量设置为之前记录的值
        var newOffset = offset
        if offset.y < -44 {
            newOffset.y = -(self.navigationController?.navigationBar.frame.height)!
        } else if offset.y == -44 {
            newOffset.y = -((self.navigationController?.navigationBar.frame.height)! + Screen.safeAreaInsets().top)
        }
        self.underlyView.setContentOffset(newOffset, animated: false)
    }
}

