import UIKit
import WebKit

class EssayViewController: UIViewController {
    
    var tag: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        Initialize.view(self, "文章加载失败", mode: .basic)

        // 在需要响应主题切换的地方添加观察者
        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange), name: changeThemeNotification, object: nil)
        
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
        
        // 屏幕旋转中触发的方法
        coordinator.animate { [self] _ in // 先进行一遍重新绘制充当过渡动画
            transitionAnimate(offset ?? CGPoint(x: 0, y: 0))
        } completion: { [self] _ in
            transitionAnimate(offset ?? CGPoint(x: 0, y: 0))
        }
    }
    
    func transitionAnimate(_ offset: CGPoint) {
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
        var newOffset = offset
        if offset.y < -44 {
            newOffset.y = -(self.navigationController?.navigationBar.frame.height)!
        } else if offset.y == -44 {
            newOffset.y = -((self.navigationController?.navigationBar.frame.height)! + Screen.safeAreaInsets().top)
        }
        scrollView.setContentOffset(newOffset, animated: false)
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

