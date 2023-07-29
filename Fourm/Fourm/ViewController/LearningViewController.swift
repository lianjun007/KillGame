import UIKit

class LearningViewController: UIViewController {
    
    var featuredCollectionsRandomDataArray: Array<Dictionary<String, String>> = [] // 接收精选课程的随机数据
    let underlyView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        Initialize.view(self, "推荐内容", mode: .basic)
        
        /// 底层的滚动视图，最基础的界面
        underlyView.frame = UIScreen.main.bounds
        view.addSubview(underlyView)
        
        /// 模块标题：精选合集
        let moduleTitle1 = UIButton().moduleTitleMode("精选合集", originY: Spaced.navigation(), mode: .arrow)
        underlyView.addSubview(moduleTitle1)
        // 关联跳转方法
        moduleTitle1.addTarget(self, action: #selector(clickModuleTitleControl), for: .touchUpInside)
        
        // 发送精选课程的随机数据（废弃⚠️）
        featuredCollectionsRandomDataArray = arrayRandom(number: 7, array: featuredCollectionsDataArray) as! Array<Dictionary<String, String>>

        // 设置第一个模块的横向滚动视图，用来承载第一个模块“精选合集”（待修改⚠️）
        let moduleView = UIScrollView(frame: CGRect(x: 0, y: moduleTitle1.frame.maxY + Spaced.control(), width: Screen.width(), height: largeControlSize.height))
        moduleView.contentSize = CGSize(width: largeControlSize.width * 7 + Spaced.control() * 6 + Spaced.screenAuto() * 2, height: largeControlSize.height)
        moduleView.showsHorizontalScrollIndicator = false
        moduleView.clipsToBounds = false
        underlyView.addSubview(moduleView)
        // 创建7个精选合集框
        for i in 0 ... 6 {
            // 配置参数
            let moduleControlOrigin = CGPoint(x: Spaced.screen() + CGFloat(i) * (largeControlSize.width + Spaced.control()), y: 0)
            let featuredCourseBox = largeControlBuild(origin: moduleControlOrigin, imageName: featuredCollectionsRandomDataArray[i]["imageName"]!, title: featuredCollectionsRandomDataArray[i]["title"]!, title2: featuredCollectionsRandomDataArray[i]["author"]!)
            featuredCourseBox.tag = i
            featuredCourseBox.addTarget(self, action: #selector(clickCollectionControl), for: .touchUpInside)
            moduleView.addSubview(featuredCourseBox)
            let interaction = UIContextMenuInteraction(delegate: self)
            featuredCourseBox.addInteraction(interaction)
        }
        
        /// 模块标题：精选文章
        let moduleTitle2 = UIButton().moduleTitleMode("精选合集", originY: moduleView.frame.maxY + Spaced.module(), mode: .arrow)
        underlyView.addSubview(moduleTitle2)
        // 关联跳转方法
        moduleTitle2.addTarget(self, action: #selector(clickModuleTitleControl), for: .touchUpInside)
        
        var cellViewArray: Array<UIButton> = []
        for i in 0 ... 6 {
            var direction = Bool()
            if i == 2 || i == 3 || i == 4 {
                direction = false
            } else {
                direction = true
            }
            
            let cellView = mediumControlBuild(origin: CGPoint(x: Spaced.screenAuto(), y: moduleTitle2.frame.maxY + Spaced.control() + CGFloat(i) * (Spaced.control() + 90)), imageName: essayData["\(i + 1)"]?["cover"] as! String, title: essayData["\(i + 1)"]?["title"] as! String, title2: essayData["\(i + 1)"]?["author"] as! String, direction: direction)
            
            cellView.tag = i + 1
            cellView.addTarget(self, action: #selector(clickEssayControl), for: .touchUpInside)
            cellViewArray.append(cellView)
            underlyView.addSubview(cellView)

//            // 根据字符串长度赋予不同行数,最多为两行
//            if isTruncated(essayLabel) {
//                essayLabel.numberOfLines += 1
//            }
//            essayLabel.sizeToFit()
//            essayLabel.frame.size.width = blurView.frame.width - Spaced.control() * 2
//            essayLabel.isUserInteractionEnabled = false
//            cellView.addSubview(essayLabel)
//
//            // 根据字符串行数判断动态坐标
//            if essayLabel.numberOfLines == 1 {
//                essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - Spaced.control()) / 2
//                essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + Spaced.control(), y: (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - Spaced.control()) / 2 + essayLabel.frame.height * 2 + Spaced.control())
//            } else {
//                essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - Spaced.control()) / 2
//                essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + Spaced.control(), y: (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - Spaced.control()) / 2 + essayLabel.frame.height + Spaced.control())
//            }
//
            let interaction = UIContextMenuInteraction(delegate: self)
            cellView.addInteraction(interaction)
        }
        
        underlyView.contentSize = CGSize(width: Screen.width(), height: cellViewArray[6].frame.maxY + Spaced.module())
    }
    
    @objc func clickEssayControl(_ sender: UIButton) {
        let VC = EssayViewController()
        VC.tag = "\(sender.tag)"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func clickCollectionControl(_ sender: UIButton) {
        let VC = CourseViewController()
        VC.tag = "\(sender.tag)"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func clickModuleTitleControl(_ sender: UIButton) {
        let VC = SelectedCollectionViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        // 记录当前滚动视图的偏移量
        var offset: CGPoint?
        for subview in view.subviews {
            if let underlyScrollView = subview as? UIScrollView {
                offset = underlyScrollView.contentOffset
                break
            }
        }

        // 在屏幕旋转完成后刷新界面
        coordinator.animate(alongsideTransition: nil) { _ in
            // 移除旧的滚动视图
            for subview in self.underlyView.subviews {
                subview.removeFromSuperview()
            }

            // 重新构建界面
            self.viewDidLoad()

            // 将新的滚动视图的偏移量设置为之前记录的值
            if let offset = offset {
                var newOffset = offset
                if offset.y < -44 {
                    newOffset.y = -(self.navigationController?.navigationBar.frame.height)!
                } else if offset.y == -44 {
                    newOffset.y = -((self.navigationController?.navigationBar.frame.height)! + Screen.safeAreaInsets().top)
                }
                self.underlyView.setContentOffset(newOffset, animated: false)
            }
        }
    }
}

extension LearningViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        var identifier = Int()
        if let button = interaction.view as? UIButton {
            identifier = button.tag
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: { [self] in
            
            let previewControllerInstance = UIViewController()
            if identifier < 7 {
                let image = UIImageView(frame: CGRect(x: Spaced.screen(), y: Spaced.screen(), width: previewControllerInstance.view.bounds.width - Spaced.screen() * 2, height: previewControllerInstance.view.bounds.width - Spaced.screen() * 2))
                image.layer.cornerRadius = 10
                image.clipsToBounds = true
                image.image = UIImage(named: featuredCollectionsRandomDataArray[identifier]["imageName"]!)
                previewControllerInstance.view.addSubview(image)
                
                // 设置精选课程的标题
                let courseLabel = UILabel(frame: CGRect(x: Spaced.screen(), y: image.frame.maxY + Spaced.screen(), width: 0, height: 0))
                courseLabel.text = featuredCollectionsRandomDataArray[identifier]["title"]
                courseLabel.font = Font.title1()
                courseLabel.sizeToFit()
                courseLabel.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel)
                
                // 设置精选课程的作者名
                let courseLabel2 = UILabel(frame: CGRect(x: Spaced.screen(), y: courseLabel.frame.maxY + Spaced.control(), width: 0, height: 0))
                courseLabel2.text = featuredCollectionsRandomDataArray[identifier]["author"]
                courseLabel2.font = Font.title2()
                courseLabel2.sizeToFit()
                courseLabel2.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel2)
                
                previewControllerInstance.preferredContentSize = CGSize(width: previewControllerInstance.view.bounds.width, height: courseLabel2.frame.maxY + Spaced.screen())
            } else {
                let image = UIImageView(frame: CGRect(x: Spaced.screen(), y: Spaced.screen(), width: previewControllerInstance.view.bounds.width - Spaced.screen() * 2, height: previewControllerInstance.view.bounds.width - Spaced.screen() * 2))
                image.layer.cornerRadius = 10
                image.clipsToBounds = true
                image.image = UIImage(named: featuredCollectionsRandomDataArray[identifier - 7]["imageName"]!)
                previewControllerInstance.view.addSubview(image)
                
                // 设置精选课程的标题
                let courseLabel = UILabel(frame: CGRect(x: Spaced.screen(), y: image.frame.maxY + Spaced.screen(), width: 0, height: 0))
                courseLabel.text = featuredCollectionsRandomDataArray[identifier - 7]["title"]
                courseLabel.font = Font.title1()
                courseLabel.sizeToFit()
                courseLabel.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel)
                
                // 设置精选课程的作者名
                let courseLabel2 = UILabel(frame: CGRect(x: Spaced.screen(), y: courseLabel.frame.maxY + Spaced.control(), width: 0, height: 0))
                courseLabel2.text = featuredCollectionsRandomDataArray[identifier - 7]["author"]
                courseLabel2.font = Font.title2()
                courseLabel2.sizeToFit()
                courseLabel2.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel2)
                
                previewControllerInstance.preferredContentSize = CGSize(width: previewControllerInstance.view.bounds.width, height: courseLabel2.frame.maxY + Spaced.screenAuto())
            }
            
            return previewControllerInstance
        }) { suggestedActions in
            let action2 = UIAction(title: "收藏至收藏夹", image: UIImage(systemName: "star")) { action in
            }
            let action3 = UIAction(title: "分享给朋友", image: UIImage(systemName: "square.and.arrow.up")) { action in
            }
            let menu1 = UIMenu(title: "",options: .displayInline, children: [action2, action3])
            let action4 = UIAction(title: "点赞课程", image: UIImage(systemName: "hand.thumbsup")) { action in
            }
            let action5 = UIAction(title: "打赏作者", image: UIImage(systemName: "dollarsign.circle")) { action in
            }
            let action6 = UIAction(title: "减少推荐", image: UIImage(systemName: "hand.thumbsdown")) { action in
            }
            let menu2 = UIMenu(title: "",options: .displayInline, children: [action4, action5, action6])
            let action7 = UIAction(title: "反馈问题", image: UIImage(systemName: "quote.bubble.rtl")) { action in
            }
            let action8 = UIAction(title: "举报不良信息", image: UIImage(systemName: "exclamationmark.bubble"), attributes: .destructive) { action in
            }
            let menu3 = UIMenu(title: "",options: .displayInline, children: [action7, action8])
            return UIMenu(title: "", children: [menu1, menu2, menu3])
        }
    }
}

