// 搜索与设置界面

import UIKit

/// 通知：修改主题相关
let changeThemeNotification = Notification.Name(String())

class SearchViewController: UIViewController {
    /// 接收模块`1`（偏好设置模块）的主题切换按钮，目的是为了当主题切换后可以定位到具体按钮然后切换复选框
    var buttonArray: Array<UIButton> = []
    
    /// 底层的滚动视图，最基础的界面
    let underlyView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        Initialize.view(self, "搜索与设置", mode: .group)
        
        // 添加底层视图
        underlyView.frame = Screen.bounds()
        view.addSubview(underlyView)
        
        /// 搜索栏控制器
        let searchControllerInstance = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchControllerInstance
        searchControllerInstance.searchBar.placeholder = "搜索所有内容"
        searchControllerInstance.obscuresBackgroundDuringPresentation = false
        searchControllerInstance.searchBar.searchTextField.backgroundColor = UIColor.systemGroupedBackground
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // 创建搜索相关的设置控件
        let module0ControlModeArray: Array<Setting.controlMode> = [.toggle, .custom2, .forward] // 设置控件每一行的类型数组
        /// 搜索相关的设置控件（对应的字典）
        let module0ControlDictionary = Setting.controlBuild(caption: "选择你想要搜索的内容范围", control: module0ControlModeArray)
        module0ControlDictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: 0)
        underlyView.addSubview(module0ControlDictionary["view"]!)
        // 配置每一行的左侧文本内容
        let module0Control1LabelArray = ["开启全局搜索", "筛选条件", "高级筛选条件"]
        for i in 1 ... module0Control1LabelArray.count {
            (module0ControlDictionary["label\(i)"] as! UILabel).text = module0Control1LabelArray[i - 1]
        }
        
        /// 模块标题`1`：偏好设置
        let moduleTitle1 = UIButton().moduleTitleMode("偏好设置", originY: module0ControlDictionary["view"]!.frame.maxY + Spaced.module(), mode: .arrow)
        moduleTitle1.addTarget(self, action: #selector(moduleTitle2Jumps), for: .touchUpInside)
        underlyView.addSubview(moduleTitle1)
        
        /// 偏好设置（模块`1`）的设置控件（对应的字典）
        let module1ControlDictionary = Setting.controlBuild(caption: "设置阅读文章时的主题风格", control: [.custom3, .forward])
        module1ControlDictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: moduleTitle1.frame.maxY + Spaced.control())
        underlyView.addSubview(module1ControlDictionary["view"]!)
        // 配置每一行的左侧文本内容
        (module1ControlDictionary["label1"] as! UILabel).text = ""
        (module1ControlDictionary["label2"] as! UILabel).text = "高级阅读设置"
        // 配置每一行关联的方法
        (module1ControlDictionary["control2"] as! UIButton).addTarget(self, action: #selector(module1ControlRow2Jumps), for: .touchUpInside)
        
        // 重载界面的时候清空数组防止元素索引值紊乱
        buttonArray = []
        
        /// 模块`1`控件的第一行设置（设置阅读主题行）的辅助X轴原点坐标值（确保三个图标平均分布）数组
        let module1Control1OriginXArray: Array<CGFloat> = [(Screen.basicWidth() - 180) / 4, (Screen.basicWidth() - 180) / 2 + 60, (Screen.basicWidth() - 180) / 4 * 3 + 120]
        // 自定义设置控件（阅读主题切换）
        for i in 0 ... 2 {
            /// 上方的图片按钮
            let imageButton = UIButton()
            imageButton.frame.size = CGSize(width: 60, height: 60)
            imageButton.frame.origin = CGPoint(x: module1Control1OriginXArray[i], y: 15)
            
            /// 下方的文字复选框按钮
            let button = UIButton()
            buttonArray.append(button)
            
            // 给按钮加上图片和图标
            switch i {
            case 0:
                imageButton.setBackgroundImage(UIImage(named: "theme.texture"), for: .normal)
                button.setTitle("质感", for: .normal)
            case 1:
                imageButton.setBackgroundImage(UIImage(named: "theme.style"), for: .normal)
                button.setTitle("格调", for: .normal)
            case 2:
                imageButton.setBackgroundImage(UIImage(named: "theme.gorgeous"), for: .normal)
                button.setTitle("绚烂", for: .normal)
            default: break
            }
            
            // 配置文字复选框按钮的基础参数
            button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            button.sizeToFit()
            button.frame.origin = CGPoint(x: module1Control1OriginXArray[i], y: imageButton.frame.maxY + 15)
            button.setTitleColor(UIColor.black, for: .normal)
            
            // 设置两个按钮的其他参数
            imageButton.tag = i
            imageButton.addTarget(self, action: #selector(click), for: .touchUpInside)
            module1ControlDictionary["control1"]!.addSubview(imageButton)
            button.tag = i
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            module1ControlDictionary["control1"]!.addSubview(button)
        }
        
        // 根据当前主题设置复选框样式
        switch UserDefaults.SettingInfo.string(forKey: .essayTheme) {
        case "texture": buttonArray[0].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        case "style": buttonArray[1].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        case "gorgeous": buttonArray[2].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        default: break
        }
        
        /// 模块标题`2`：更多设置
        let moduleTitle2 = UIButton().moduleTitleMode("更多设置", originY: module1ControlDictionary["view"]!.frame.maxY + Spaced.setting(), mode: .basic)
        underlyView.addSubview(moduleTitle2)
        
        // 创建更多设置(模块`2`)的设置控件1
        let module2Control1ModeArray: Array<Setting.controlMode> = [.forward, .forward, .forward, .forward] // 设置控件每一行的类型数组
        /// 更多设置（模块`2`）的设置控件`1`（对应的字典）
        let module2Control1Dictionary = Setting.controlBuild(control: module2Control1ModeArray, tips: "版本日志记录所有的更新变动，开发手册展示开发历程和设计思路。")
        module2Control1Dictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: moduleTitle2.frame.maxY + Spaced.control())
        underlyView.addSubview(module2Control1Dictionary["view"]!)
        // 配置每一行的左侧文本内容
        let module2Control1LabelArray = ["关于Frame", "用户手册与协议", "版本日志", "开发手册"]
        for i in 1 ... module2Control1LabelArray.count {
            (module2Control1Dictionary["label\(i)"] as! UILabel).text = module2Control1LabelArray[i - 1]
        }
        
        // 创建更多设置(模块2)的设置控件2
        let module2Control2ModeArray: Array<Setting.controlMode> = [.forward, .forward]  // 设置控件每一行的类型数组
        /// 更多设置（模块`2`）的设置控件`2`（对应的字典）
        let module2Control2Dictionary = Setting.controlBuild(control: module2Control2ModeArray)
        module2Control2Dictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: module2Control1Dictionary["view"]!.frame.maxY + Spaced.setting())
        underlyView.addSubview(module2Control2Dictionary["view"]!)
        // 配置每一行的左侧文本内容
        (module2Control2Dictionary["label1"] as! UILabel).text = "关于我们"
        (module2Control2Dictionary["label2"] as! UILabel).text = "反馈问题"
        
        // 创建更多设置(模块2)的设置控件3
        let module2Control3Mode: Array<Setting.controlMode> = [.toggle, .forward] // 设置控件每一行的类型数组
        /// 更多设置（模块`2`）的设置控件`3`（对应的字典）
        let module2Control3Dictionary = Setting.controlBuild(control: module2Control3Mode, tips: "实验功能不稳定，谨慎开启")
        module2Control3Dictionary["view"]!.frame.origin = CGPoint(x: Spaced.screenAuto(), y: module2Control2Dictionary["view"]!.frame.maxY + Spaced.setting())
        underlyView.addSubview(module2Control3Dictionary["view"]!)
        // 配置每一行的左侧文本内容
        (module2Control3Dictionary["label1"] as! UILabel).text = "实验功能"
        (module2Control3Dictionary["label2"] as! UILabel).text = "设置实验功能"
        
        // 配置底层视图的内容尺寸
        underlyView.contentSize = CGSize(width: Screen.width(), height: module2Control3Dictionary["view"]!.frame.maxY + Spaced.module())
    }
}

// 扩展，放置所有界面切换的方法
extension SearchViewController {
    ///
    @objc func moduleTitle2Jumps() {
        let VC = SettingViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    /// 搜索界面文章主题设置的高级阅读设置界面的跳转方法
    @objc func module1ControlRow2Jumps() {
        let VC = EssayThemeViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

// 扩展，放置设置控件对应的点击、切换等事件（非跳转界面事件）
extension SearchViewController {
    /// 搜索界面文章主题切换按钮对应的点击方法，作用是切换文章的阅读主题
    @objc func click(sender: UIButton) {
        // 根据点击的按钮来修改UserDefaults
        switch sender.tag {
        case 0: UserDefaults.SettingInfo.set(value: "texture", forKey: .essayTheme)
        case 1: UserDefaults.SettingInfo.set(value: "style", forKey: .essayTheme)
        case 2: UserDefaults.SettingInfo.set(value: "gorgeous", forKey: .essayTheme)
        default: break
        }
        // 循环来处理复选框点中后的显示效果
        for i in 0 ... 2 {
            if i == sender.tag {
                buttonArray[sender.tag].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        }
        // 在需要切换主题的地方发送通知
        NotificationCenter.default.post(name: changeThemeNotification, object: nil)
    }
}

// 扩展，放置界面显示效果修改后执行的所有方法
extension SearchViewController {
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
