import UIKit

//// 读取数据
//let name = defaults.string(forKey: "username")
//let age = defaults.integer(forKey: "age")
//let isLoggedIn = defaults.bool(forKey: "isUserLoggedIn")


class SearchViewController: UIViewController {
    
    let searchControllerInstance = UISearchController(searchResultsController: nil)
    var buttonArray: Array<UIButton> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        navigationItem.title = "搜索与更多"
        let pickerView = UISegmentedControl()
        
        navigationItem.searchController = searchControllerInstance
        searchControllerInstance.searchBar.searchTextField.inputView = pickerView
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchControllerInstance.searchBar.placeholder = "搜索所有内容"
        searchControllerInstance.obscuresBackgroundDuringPresentation = false
        searchControllerInstance.searchBar.searchTextField.backgroundColor = UIColor.systemGroupedBackground
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scroll.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)
        view.addSubview(scroll)
        
        let moduleTitle1 = moduleTitleBuild("搜索选项", scroll, spacedForNavigation, interaction: true)
        
        let setting0Array = [["type": "forward", "rowTitle": "筛选搜索", "rowHeight": "default"]]
        let setting0 = settingControlBuild(title: "", tips: "设置和粉丝哦击缶哦is片鹅u啊人分工iu普i哦二热刚刚好hi忍受风格寺佛好", scroll, moduleTitle1.frame.maxY + spacedForControl, parameter: setting0Array)
        
        let moduleTitle2 = moduleTitleBuild("偏好设置", scroll, setting0 + spacedForModule, interaction: true)
        
        let view = UIView(frame: CGRect(x: spacedForScreen, y: moduleTitle2.frame.maxY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 180))
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 12
        scroll.addSubview(view)
        let basic = (screenWidth - spacedForScreen * 2) / 3
        for i in 0 ... 2 {
            let button = UIButton(frame: CGRect(x: spacedForScreen + basic * CGFloat(i) + 20, y: moduleTitle2.frame.maxY + spacedForControl + 20, width: 80, height: 80))
            button.layer.cornerRadius = 15
            button.setBackgroundImage(UIImage(named: "Setting\(i)"), for: .normal)
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
        switch settingEssayTitle2DisplayMode {
        case 1:
            buttonArray[1].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            for i in [0, 2] {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        case 2:
            buttonArray[2].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            for i in 0 ... 1 {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        default:
            buttonArray[0].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            for i in 1 ... 2 {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        }
        let setting1Array = [["type": "forward", "rowTitle": "更多设置", "rowHeight": "default"]]
        let setting1 = settingControlBuild(title: "主题设置", tips: "设置更多主题", scroll, view.frame.maxY + spacedForModule2, parameter: setting1Array)
    }
    
    
    @objc func click(sender: UIButton) {
        defaults.set(sender.tag, forKey: "settingEssayTitle2DisplayMode")
        for i in 0 ... 2 {
            if i == sender.tag {
                buttonArray[sender.tag].setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            } else {
                buttonArray[i].setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            }
        }
        
    }

}
