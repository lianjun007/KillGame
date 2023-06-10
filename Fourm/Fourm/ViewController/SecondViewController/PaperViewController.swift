
import UIKit
import WebKit
//import Ink

class PaperViewController: UIViewController {
    
    var content: String?
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "精选文章的标题大家你是他的好挑食的剪完头"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let paper = FeaturedPaperFile0()
        controlBuild(body: paper, ViewController: self)
        
        
//        let url = Bundle.main.url(forResource: "FeaturedPaperFile0", withExtension: "md")!
//        let markdown = try! String(contentsOf: url)
//        let html = MarkdownParser()
//        
//        let webView = WKWebView(frame: view.bounds)
//        
//        webView.loadHTMLString(markdown, baseURL: url)
//        view.addSubview(webView)
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
