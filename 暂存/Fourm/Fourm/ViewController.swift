import UIKit

// 创建标签栏
class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [
            UINavigationController(rootViewController: LearningViewController().withTabBarItem(title: "学习", image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))),
            UINavigationController(rootViewController: DiscussViewController().withTabBarItem(title: "交流", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))),
            UINavigationController(rootViewController: CollectionViewController().withTabBarItem(title: "收藏", image: UIImage(systemName: "star.square.on.square"), selectedImage: UIImage(systemName: "star.square.on.square.fill"))),
            UINavigationController(rootViewController: SearchViewController().withTabBarItem(title: "检索", image: UIImage(systemName: "rectangle.and.hand.point.up.left"), selectedImage: UIImage(systemName: "rectangle.and.hand.point.up.left.fill")))
        ]
        self.viewControllers = viewControllers
        
    }
    
}

// 拓展实现底部标签栏的切换功能
extension UIViewController {
    func withTabBarItem(title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        self.tabBarItem = tabBarItem
        return self
    }
}
