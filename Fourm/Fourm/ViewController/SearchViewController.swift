import UIKit

//// 读取数据
//let name = defaults.string(forKey: "username")
//let age = defaults.integer(forKey: "age")
//let isLoggedIn = defaults.bool(forKey: "isUserLoggedIn")

// 定义一个通知名称
let ThemeDidChangeNotification = Notification.Name("ThemeDidChangeNotification")

class SearchViewController: UIViewController {
    
    var buttonArray: Array<UIButton> = []
    
    let scroll = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        navigationItem.title = "搜索与更多"
        
        let searchControllerInstance = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchControllerInstance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchControllerInstance.searchBar.placeholder = "搜索所有内容"
        searchControllerInstance.obscuresBackgroundDuringPresentation = false
        searchControllerInstance.searchBar.searchTextField.backgroundColor = UIColor.systemGroupedBackground
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        scroll.frame = CGRect(x: 0, y: 0, width: Screen.width(), height: Screen.height())
        scroll.contentSize = CGSize(width: Screen.width(), height: Screen.height() * 2)
        view.addSubview(scroll)
        
        let moduleTitle1 = moduleTitleBuild("搜索选项", scroll, Spaced.navigation(), interaction: true)
        
        let setting0Array = [["type": "forward", "rowTitle": "筛选搜索", "rowHeight": "default"]]
        let setting0 = settingControlBuild(title: "", tips: "设置和粉丝哦击缶哦is片鹅u啊人分工iu普i哦二热刚刚好hi忍受风格寺佛好", scroll, moduleTitle1.frame.maxY + Spaced.control(), parameter: setting0Array)
        
        let moduleTitle2 = moduleTitleBuild("偏好设置", scroll, setting0 + Spaced.module(), interaction: true)
        
        let view = UIView(frame: CGRect(x: Spaced.screenAuto(), y: moduleTitle2.frame.maxY + Spaced.control(), width: Screen.width() - Spaced.screenAuto() * 2, height: 180))
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 12
        scroll.addSubview(view)
        let basic = (Screen.width() - Spaced.screenAuto() * 2) / 3
        for i in 0 ... 2 {
            let button = UIButton(frame: CGRect(x: Spaced.screenAuto() + basic * CGFloat(i) + 20, y: moduleTitle2.frame.maxY + Spaced.control() + 20, width: 80, height: 80))
            button.layer.cornerRadius = 15
            switch i {
            case 0: button.setBackgroundImage(UIImage(named: "style.simple"), for: .normal)
            case 1: button.setBackgroundImage(UIImage(named: "style.lines"), for: .normal)
            case 2: button.setBackgroundImage(UIImage(named: "style.impressions"), for: .normal)
            default: break
            }
            button.tag = i
            button.backgroundColor = UIColor.systemBackground
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            scroll.addSubview(button)
            
            let button0 = UIButton(frame: CGRect(x: CGFloat(i) * basic, y: 130, width: basic, height: 40))
            if i == 0 {
                button0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                button0.setTitle("简约", for: .normal)
            } else if i == 1 {
                button0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                button0.setTitle("线条", for: .normal)
            } else {
                button0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                button0.setTitle("印象", for: .normal)
            }
            button0.setTitleColor(UIColor.black, for: .normal)
            button0.tag = i
            button0.addTarget(self, action: #selector(click), for: .touchUpInside)
            buttonArray.append(button0)
            view.addSubview(button0)
        }
        switch UserDefaults.SettingInfo.string(forKey: .essayStyle) {
        case "simple":
            buttonArray[0].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            for i in 1 ... 2 {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        case "lines":
            buttonArray[1].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            for i in [0, 2] {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        case "impressions":
            buttonArray[2].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            for i in 0 ... 1 {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        default: break
        }
        let setting1Array = [["type": "forward", "rowTitle": "更多设置", "rowHeight": "default"]]
        let setting1 = settingControlBuild(title: "主题设置", tips: "设置更多主题", scroll, view.frame.maxY + Spaced.setting(), parameter: setting1Array)
    }
    
    
    @objc func click(sender: UIButton) {
        switch sender.tag {
        case 0: UserDefaults.SettingInfo.set(value: "simple", forKey: .essayStyle)
        case 1: UserDefaults.SettingInfo.set(value: "lines", forKey: .essayStyle)
        case 2: UserDefaults.SettingInfo.set(value: "impressions", forKey: .essayStyle)
        default: break
        }
        
        // 在需要切换主题的地方发送通知
        NotificationCenter.default.post(name: ThemeDidChangeNotification, object: nil)

        for i in 0 ... 2 {
            if i == sender.tag {
                buttonArray[sender.tag].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // 记录当前滚动视图的偏移量
        var offset: CGPoint?
        for subview in view.subviews {
            if let scroll = subview as? UIScrollView {
                offset = scroll.contentOffset
                break
            }
        }

        // 在屏幕旋转完成后刷新界面
        coordinator.animate(alongsideTransition: nil) { _ in
            // 移除旧的滚动视图
            for subview in self.scroll.subviews {
                subview.removeFromSuperview()
            }

            // 重新构建界面
            self.viewDidLoad()

            // 将新的滚动视图的偏移量设置为之前记录的值
            if let offset = offset {
                var newOffset = offset
                if offset.y < -44 {
                    newOffset.y = -(self.navigationController?.navigationBar.frame.height)!
                } else if offset.y == -44 {
                    newOffset.y = -((self.navigationController?.navigationBar.frame.height)! + Screen.safeAreaInsets().top)
                }
                self.scroll.setContentOffset(newOffset, animated: false)
            }
        }
    }
}
