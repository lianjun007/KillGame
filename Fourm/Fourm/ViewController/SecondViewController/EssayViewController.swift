import UIKit
import WebKit

class EssayViewController: UIViewController {
    
    var tag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.SettingInfo.string(forKey: .essayStyle) == nil {
            UserDefaults.SettingInfo.set(value: "simple", forKey: .essayStyle)
        } // 默认文章显示模式为“simple”简约

        // 在需要响应主题切换的地方添加观察者
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: ThemeDidChangeNotification, object: nil)
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "文章加载失败"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let fileURL = Bundle.main.path(forResource: "File", ofType: "")
        let content = try! String(contentsOfFile: fileURL!, encoding: .utf8)
        _ = essayInterfaceBuild(content, self)
    }
    
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

        // 在屏幕旋转完成后刷新界面
        coordinator.animate(alongsideTransition: nil) { _ in
            // 移除旧的滚动视图
            for subview in self.view.subviews {
                if subview is UIScrollView {
                    subview.removeFromSuperview()
                }
            }

            // 重新构建界面
            let fileURL = Bundle.main.path(forResource: "File", ofType: "")
            let content = try! String(contentsOfFile: fileURL!, encoding: .utf8)
            let scrollView = essayInterfaceBuild(content, self)

            // 将新的滚动视图的偏移量设置为之前记录的值
            if let offset = offset {
                var newOffset = offset
                if offset.y < -44 {
                    newOffset.y = -(self.navigationController?.navigationBar.frame.height)!
                } else if offset.y == -44 {
                    newOffset.y = -((self.navigationController?.navigationBar.frame.height)! + Screen.safeAreaInsets().top)
                }
                scrollView.setContentOffset(newOffset, animated: false)
            }
        }
    }

    
    // 实现观察者方法
    @objc func themeDidChange() {
        // 更新主题相关的设置

        // 记录当前滚动视图的偏移量
        var offset: CGPoint?
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                offset = scrollView.contentOffset
                break
            }
        }

        // 移除旧的滚动视图
        for subview in view.subviews {
            if subview is UIScrollView {
                subview.removeFromSuperview()
            }
        }

        // 重新构建界面
        let fileURL = Bundle.main.path(forResource: "File", ofType: "")
        let content = try! String(contentsOfFile: fileURL!, encoding: .utf8)
        let scrollView = essayInterfaceBuild(content, self)

        // 将新的滚动视图的偏移量设置为之前记录的值
        if let offset = offset {
            scrollView.setContentOffset(offset, animated: false)
        }
    }

}

