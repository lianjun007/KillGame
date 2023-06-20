import UIKit

var settingEssayTitle2DisplayMode: Int?

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
        
        let moduleTitle = UILabel(frame: CGRect(x: spacedForScreen, y: spacedForModule2, width: 0, height: 0))
        moduleTitle.text = "搜索选项"
        moduleTitle.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        moduleTitle.sizeToFit()
        scroll.addSubview(moduleTitle)
        
        let settingTitle = UILabel(frame: CGRect(x: spacedForScreen, y: moduleTitle.frame.maxY + spacedForModule, width: 0, height: 0))
        settingTitle.text = "更多设置"
        settingTitle.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        settingTitle.sizeToFit()
        scroll.addSubview(settingTitle)
        
        let view = UIView(frame: CGRect(x: spacedForScreen, y: settingTitle.frame.maxY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 140))
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 15
        scroll.addSubview(view)
        let basic = (screenWidth - spacedForScreen * 2) / 3
        for i in 0 ... 2 {
            let button = UIButton(frame: CGRect(x: spacedForScreen + basic * CGFloat(i), y: settingTitle.frame.maxY + spacedForControl, width: basic, height: 140))
            button.layer.cornerRadius = 15
            button.tag = i
            button.backgroundColor = UIColor.systemBackground
            if i == 0 {
                button.backgroundColor = UIColor.systemIndigo
                button.setTitle("下划线", for: .normal)
            } else if i == 1 {
                button.setTitle("马克笔高亮", for: .normal)
            } else {
                button.setTitle("简约", for: .normal)
            }
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            scroll.addSubview(button)
            buttonArray.append(button)
        }
        
    }
    
    @objc func click(sender: UIButton) {
        settingEssayTitle2DisplayMode = sender.tag
        for i in 0 ... 2 {
            if i == sender.tag {
                buttonArray[sender.tag].backgroundColor = UIColor.systemIndigo
            } else {
                buttonArray[i].backgroundColor = UIColor.systemBackground
            }
        }
        
    }

}
