import UIKit
import WebKit

var settingEssayTitle2DisplayMode: Int? = defaults.integer(forKey: "settingEssayTitle2DisplayMode")

let defaults = UserDefaults.standard

class PaperViewController: UIViewController {
    
    var tag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingEssayTitle2DisplayMode = defaults.integer(forKey: "settingEssayTitle2DisplayMode")
        
        let ID = tag ?? "0"
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "文章的标题"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        essayInterfaceBuild(data: essayData[ID]!, ViewController: self)
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.navigationController?.navigationBar.subviews.forEach({ (view) in
    //            if !view.isKind(of: NSClassFromString("_UINavigationBarContentView")!) {
    //                view.isHidden = true
    //
    //            }
    //        })
    //
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        self.navigationController?.navigationBar.subviews.forEach({ (view) in
    //            if !view.isKind(of: NSClassFromString("_UINavigationBarContentView")!) {
    //                view.isHidden = false
    //            }
    //        })
    //
    //    }
    
}
