//
//  ViewController.swift
//  Tableview
//
//  Created by QHuiYan on 2023/6/14.
//

import UIKit

class ViewController: UITabBarController {
    
    var user: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [
            UINavigationController(rootViewController: ViewController1().withTabBarItem(title: "聊天", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))),
            UINavigationController(rootViewController: ViewController2().withTabBarItem(title: "联系人", image: UIImage(systemName: "person.crop.rectangle.stack"), selectedImage: UIImage(systemName: "person.crop.rectangle.stack.fill"))),
            UINavigationController(rootViewController: ViewController3().withTabBarItem(title: "发现", image: UIImage(systemName: "safari"), selectedImage: UIImage(systemName: "safari.fill"))),
            UINavigationController(rootViewController: ViewController4().withTabBarItem(title: "我的", image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill")))
        ]
        self.viewControllers = viewControllers
        
    }
    
}

extension UIViewController {
    func withTabBarItem(title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        self.tabBarItem = tabBarItem
        return self
    }
}
    
        
    


