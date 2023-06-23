import UIKit

class LearningViewController: UIViewController {
    
    var featuredCollectionsRandomDataArray: Array<Dictionary<String, String>> = [] // 接收精选课程的随机数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerInitialize(vc: self, navTitle: "开始学习")
        
        // 创建底层滚动视图
        let underlyScrollView = UIScrollView(frame: UIScreen.main.bounds)
        view.addSubview(underlyScrollView)
        
        let moduleTitle1 = moduleTitleBuild(superView: underlyScrollView, title: "精选合集", originY: spacedForNavigation)
        
        // 发送精选课程的随机数据
        featuredCollectionsRandomDataArray = arrayRandom(number: 7, array: featuredCollectionsDataArray) as! Array<Dictionary<String, String>>

        // 设置第一个模块的横向滚动视图，用来承载第一个模块“精选合集”
        let moduleView = UIScrollView(frame: CGRect(x: 0, y: moduleTitle1.frame.maxY + spacedForControl, width: screenWidth, height: largeControlSize.height))
        moduleView.contentSize = CGSize(width: largeControlSize.width * 7 + spacedForControl * 6 + spacedForScreen * 2, height: largeControlSize.height)
        moduleView.showsHorizontalScrollIndicator = false
        moduleView.clipsToBounds = false
        underlyScrollView.addSubview(moduleView)
        // 创建7个精选合集框
        for i in 0 ... 6 {
            // 配置参数
            let moduleControlOrigin = CGPoint(x: spacedForScreen + CGFloat(i) * (largeControlSize.width + spacedForControl), y: 0)
            let featuredCourseBox = largeControlBuild(origin: moduleControlOrigin, imageName: featuredCollectionsRandomDataArray[i]["imageName"]!, title: featuredCollectionsRandomDataArray[i]["title"]!, title2: featuredCollectionsRandomDataArray[i]["author"]!)
            featuredCourseBox.tag = i
            featuredCourseBox.addTarget(self, action: #selector(clickCollectionControl), for: .touchUpInside)
            moduleView.addSubview(featuredCourseBox)
            let interaction = UIContextMenuInteraction(delegate: self)
            featuredCourseBox.addInteraction(interaction)
        }
        
        // Set the UILabel at the featuredCoursesBox tilte
        let featuredCourseLable1 = UILabel(frame: CGRect(x: spacedForScreen, y: spacedForNavigation + moduleView.frame.height + spacedForModule * 2, width: 0, height: 0))
        featuredCourseLable1.text = "精选文章"
        featuredCourseLable1.font = titleFont2
        featuredCourseLable1.sizeToFit()
        underlyScrollView.addSubview(featuredCourseLable1)
        
        var cellViewArray: Array<UIButton> = []
        for i in 0 ... 6 {
            var direction = Bool()
            if i == 2 || i == 3 || i == 4 {
                direction = false
            } else {
                direction = true
            }
            
            let cellView = mediumControlBuild(origin: CGPoint(x: spacedForScreen, y: featuredCourseLable1.frame.maxY + spacedForControl + CGFloat(i) * (spacedForControl + mediumControlSize.height)), imageName: essayData["\(i + 1)"]?["cover"] as! String, title: essayData["\(i + 1)"]?["title"] as! String, title2: essayData["\(i + 1)"]?["author"] as! String, direction: direction)
            
            cellView.tag = i + 1
            cellView.addTarget(self, action: #selector(clickEssayControl), for: .touchUpInside)
            cellViewArray.append(cellView)
            underlyScrollView.addSubview(cellView)

//            // 根据字符串长度赋予不同行数,最多为两行
//            if isTruncated(essayLabel) {
//                essayLabel.numberOfLines += 1
//            }
//            essayLabel.sizeToFit()
//            essayLabel.frame.size.width = blurView.frame.width - spacedForControl * 2
//            essayLabel.isUserInteractionEnabled = false
//            cellView.addSubview(essayLabel)
//
//            // 根据字符串行数判断动态坐标
//            if essayLabel.numberOfLines == 1 {
//                essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - spacedForControl) / 2
//                essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + spacedForControl, y: (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - spacedForControl) / 2 + essayLabel.frame.height * 2 + spacedForControl)
//            } else {
//                essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - spacedForControl) / 2
//                essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + spacedForControl, y: (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - spacedForControl) / 2 + essayLabel.frame.height + spacedForControl)
//            }
//
            let interaction = UIContextMenuInteraction(delegate: self)
            cellView.addInteraction(interaction)
        }
        
        underlyScrollView.contentSize = CGSize(width: screenWidth, height: cellViewArray[6].frame.maxY + spacedForControl)
        
        
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
                let image = UIImageView(frame: CGRect(x: spacedForScreen, y: spacedForScreen, width: previewControllerInstance.view.bounds.width - spacedForScreen * 2, height: previewControllerInstance.view.bounds.width - spacedForScreen * 2))
                image.layer.cornerRadius = 10
                image.clipsToBounds = true
                image.image = UIImage(named: featuredCollectionsRandomDataArray[identifier]["imageName"]!)
                previewControllerInstance.view.addSubview(image)
                
                // 设置精选课程的标题
                let courseLabel = UILabel(frame: CGRect(x: spacedForScreen, y: image.frame.maxY + spacedForScreen, width: 0, height: 0))
                courseLabel.text = featuredCollectionsRandomDataArray[identifier]["title"]
                courseLabel.font = titleFont2
                courseLabel.sizeToFit()
                courseLabel.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel)
                
                // 设置精选课程的作者名
                let courseLabel2 = UILabel(frame: CGRect(x: spacedForScreen, y: courseLabel.frame.maxY + spacedForControl, width: 0, height: 0))
                courseLabel2.text = featuredCollectionsRandomDataArray[identifier]["author"]
                courseLabel2.font = UIFont.systemFont(ofSize: titleFont3, weight: .regular)
                courseLabel2.sizeToFit()
                courseLabel2.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel2)
                
                previewControllerInstance.preferredContentSize = CGSize(width: previewControllerInstance.view.bounds.width, height: courseLabel2.frame.maxY + spacedForScreen)
            } else {
                let image = UIImageView(frame: CGRect(x: spacedForScreen, y: spacedForScreen, width: previewControllerInstance.view.bounds.width - spacedForScreen * 2, height: previewControllerInstance.view.bounds.width - spacedForScreen * 2))
                image.layer.cornerRadius = 10
                image.clipsToBounds = true
                image.image = UIImage(named: featuredCollectionsRandomDataArray[identifier - 7]["imageName"]!)
                previewControllerInstance.view.addSubview(image)
                
                // 设置精选课程的标题
                let courseLabel = UILabel(frame: CGRect(x: spacedForScreen, y: image.frame.maxY + spacedForScreen, width: 0, height: 0))
                courseLabel.text = featuredCollectionsRandomDataArray[identifier - 7]["title"]
                courseLabel.font = titleFont2
                courseLabel.sizeToFit()
                courseLabel.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel)
                
                // 设置精选课程的作者名
                let courseLabel2 = UILabel(frame: CGRect(x: spacedForScreen, y: courseLabel.frame.maxY + spacedForControl, width: 0, height: 0))
                courseLabel2.text = featuredCollectionsRandomDataArray[identifier - 7]["author"]
                courseLabel2.font = UIFont.systemFont(ofSize: titleFont3, weight: .regular)
                courseLabel2.sizeToFit()
                courseLabel2.isUserInteractionEnabled = false
                previewControllerInstance.view.addSubview(courseLabel2)
                
                previewControllerInstance.preferredContentSize = CGSize(width: previewControllerInstance.view.bounds.width, height: courseLabel2.frame.maxY + spacedForScreen)
            }
            
            return previewControllerInstance
        }) { suggestedActions in
            let action1 = UIAction(title: "查看该课程", image: UIImage(systemName: "eye")) { action in
            }
            let action2 = UIAction(title: "收藏至收藏夹", image: UIImage(systemName: "star")) { action in
            }
            let action3 = UIAction(title: "分享给朋友", image: UIImage(systemName: "square.and.arrow.up")) { action in
            }
            let menu1 = UIMenu(title: "",options: .displayInline, children: [action1, action2, action3])
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

