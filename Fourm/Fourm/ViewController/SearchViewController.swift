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
        
        let moduleTitle = UILabel(frame: CGRect(x: spacedForScreen, y: spacedForNavigation, width: 0, height: 0))
        moduleTitle.text = "搜索选项"
        moduleTitle.font = titleFont2
        moduleTitle.sizeToFit()
        scroll.addSubview(moduleTitle)
        
        let settingTitle = UILabel(frame: CGRect(x: spacedForScreen, y: moduleTitle.frame.maxY + spacedForModule, width: 0, height: 0))
        settingTitle.text = "偏好设置"
        settingTitle.font = titleFont2
        settingTitle.sizeToFit()
        scroll.addSubview(settingTitle)
        
        let view = UIView(frame: CGRect(x: spacedForScreen, y: settingTitle.frame.maxY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 180))
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 15
        scroll.addSubview(view)
        let basic = (screenWidth - spacedForScreen * 2) / 3
        for i in 0 ... 2 {
            let button = UIButton(frame: CGRect(x: spacedForScreen + basic * CGFloat(i) + 20, y: settingTitle.frame.maxY + spacedForControl + 20, width: 80, height: 80))
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
