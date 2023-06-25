import UIKit
import WebKit

var settingEssayTitle2DisplayMode: Int? = defaults.integer(forKey: "settingEssayTitle2DisplayMode")

let defaults = UserDefaults.standard

class EssayViewController: UIViewController {
    
    var tag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingEssayTitle2DisplayMode = defaults.integer(forKey: "settingEssayTitle2DisplayMode")
        
        let ID = tag ?? "0"
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "文章加载失败"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let fileURL = Bundle.main.path(forResource: "File", ofType: "")
        let content = try! String(contentsOfFile: fileURL!, encoding: .utf8)
        
        essayInterfaceBuild0(content, self)
        
        // essayInterfaceBuild(data: essayData[ID]!, ViewController: self)
        
    }
    
}
