import UIKit

// 创建标签栏
class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [
            UINavigationController(rootViewController: LearningViewController().withTabBarItem(title: "学习", image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))),
            UINavigationController(rootViewController: DiscussViewController().withTabBarItem(title: "交流", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))),
            UINavigationController(rootViewController: CollectionViewController().withTabBarItem(title: "收藏", image: UIImage(systemName: "star.square.on.square"), selectedImage: UIImage(systemName: "star.square.on.square.fill"))),
            UINavigationController(rootViewController: ViewController4().withTabBarItem(title: "检索", image: UIImage(systemName: "rectangle.and.hand.point.up.left"), selectedImage: UIImage(systemName: "rectangle.and.hand.point.up.left.fill")))
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

// 创建学习界面
class LearningViewController: UIViewController {
    
    // 在滑动learningTableView之前获取初始偏移量，offsetJudgment判断是否是首次滑动，如果是首次滑动就用initialOffset接收当时的偏移量
    var offsetJudgment = true
    var initialOffset = CGFloat()
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if offsetJudgment {
            initialOffset = learningTableView.contentOffset.y
            offsetJudgment = false
        }
    }
    
    let navLabel = UILabel(frame: navLabelFrame) // 创建导航栏标题，会随着learningTableView的滑动而消失或者放大
    let moduleLabel = UILabel(frame: CGRect(origin: moduleOrigin, size: CGSizeZero)) // 创建模块二级标题
    let learningTableView = UITableView(frame: screenFrame, style: .grouped) // 创建一个UITableView作为LearningViewController的主体
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let courseData = courseData() // 获取CourseData中的数据
        
        // 设置导航栏标题的其他属性
        navLabel.text = "开始学习"
        navLabel.font = UIFont.systemFont(ofSize: titleFont, weight: .heavy)
        self.navigationController?.navigationBar.addSubview(navLabel)
        
        // 初始化tableview
        learningTableView.rowHeight = tableCellFrame.height + controlSpaced
        learningTableView.separatorStyle = .none
        learningTableView.backgroundColor = .systemBackground
        self.view.addSubview(learningTableView)
        learningTableView.dataSource = self
        learningTableView.delegate = self
        
        // headerView是courseTableView的表头视图的容器
        let headerView = UIView(frame: headerViewFrame)
        learningTableView.tableHeaderView = headerView
        
        // 设置头部容器视图的标题
        let headerLabel = UILabel(frame: CGRect(x: screenSpaced, y: screenSpaced * 2 + navLabelFrame.height - (self.navigationController?.navigationBar.frame.height)!, width: 0, height: 0))
        headerLabel.text = "精选课程"
        headerLabel.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        // 设置模块视图的标题
        moduleLabel.text = "精选文章"
        moduleLabel.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        moduleLabel.sizeToFit()
        
        let courseBtnWidth = screenWidth / 1.5 // 课程框的宽度
        // 设置头部容器视图的滚动视图，用作精选课程模块
        let featuredCoursesView = UIScrollView(frame: CGRect(x: 0, y: headerLabel.frame.origin.y + headerLabel.frame.size.height, width: screenWidth, height: headerView.frame.height - headerLabel.frame.height - headerLabel.frame.origin.y))
        featuredCoursesView.contentSize = CGSize(width: (courseBtnWidth + controlSpaced) * CGFloat(7) + screenSpaced * 2 - controlSpaced, height: featuredCoursesView.frame.height)
        featuredCoursesView.showsHorizontalScrollIndicator = false
        headerView.addSubview(featuredCoursesView)
        
        // 循环创建精选课程框
        for i in 0 ..< 7 {
            
            // 设置随机数来从课程数据库中取用数据
            let index = Int.random(in: 0 ..< courseData.count)
            
            // 创建精选课程框
            let courseBtn = UIButton(frame: CGRect(x: screenSpaced + CGFloat(CGFloat(i) * (courseBtnWidth + controlSpaced)), y: controlSpaced, width: courseBtnWidth, height: featuredCoursesView.frame.height - controlSpaced))
            courseBtn.backgroundColor = .systemFill
            courseBtn.layer.cornerRadius = basicCornerRadius
            courseBtn.setImage(UIImage(named: courseData[index]["name"]!), for: .normal)
            courseBtn.imageView?.contentMode = .scaleAspectFill
            courseBtn.layer.masksToBounds = true
            featuredCoursesView.addSubview(courseBtn)
            
            // 设置精选课程框底部的高斯模糊
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = CGRect(x: 0, y: courseBtn.frame.height / 4 * 3, width: courseBtn.frame.width, height: courseBtn.frame.height / 4)
            blurView.isUserInteractionEnabled = false
            courseBtn.addSubview(blurView)
            
            // 设置精选课程的标题
            let courseLabel = UILabel(frame: CGRect(x: controlSpaced, y: courseBtn.frame.height / 4 * 3 + screenSpaced, width: 0, height: 0))
            courseLabel.text = courseData[index]["name"]
            courseLabel.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
            courseLabel.sizeToFit()
            courseLabel.isUserInteractionEnabled = false
            courseBtn.addSubview(courseLabel)
            
            // 设置精选课程的作者名
            let courseLabel2 = UILabel(frame: CGRect(x: controlSpaced, y: courseBtn.frame.height / 4 * 3 + screenSpaced + courseLabel.frame.height, width: 0, height: 0))
            courseLabel2.text = courseData[index]["author"]
            courseLabel2.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
            courseLabel2.sizeToFit()
            courseLabel2.isUserInteractionEnabled = false
            courseBtn.addSubview(courseLabel2)
            
        }
        
    }
    
}

// 学习界面扩展类
extension LearningViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 设置精选文章的cell行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    // 设置cell的行高，第一行用作该模块的标题行
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return moduleSpaced + moduleLabel.frame.height
        }
        return tableCellFrame.height + controlSpaced
        
    }
    
    // 重用池创建和调用cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        return cell
        
    }
    
    // 创建自定义cellView视图
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let essayData = essayData() // 获取CourseData中的数据
        
        if cell.contentView.subviews.isEmpty {
            // 如果是第一行，返回该模块的标题视图moduleLabel
            if indexPath.row == 0 {
                cell.contentView.addSubview(moduleLabel)
            } else {
                // 设置随机数来从文章数据库中取用数据
                let index = Int.random(in: 0 ..< essayData.count)
                
                // 创建精选文章的框
                let cellView = UIButton(frame: tableCellFrame)
                cellView.backgroundColor = .systemFill
                cellView.setImage(UIImage(named: essayData[index]["image"]!), for: .normal)
                cellView.imageView?.contentMode = .scaleAspectFill
                cellView.layer.cornerRadius = basicCornerRadius
                cellView.clipsToBounds = true
                
                // 设置精选文章信息区域的高斯模糊背景
                let blurEffect = UIBlurEffect(style: .light)
                let blurView = UIVisualEffectView(effect: blurEffect)
                if indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 {
                    blurView.frame = CGRect(x: cellView.frame.width / 5 * 2, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
                } else {
                    blurView.frame = CGRect(x: 0, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
                } // 判断模糊应该在左边还是右边
                blurView.isUserInteractionEnabled = false
                cellView.addSubview(blurView)
                
                // 创建封面图视图
                let imageView = UIImageView(image: UIImage(named: essayData[index]["image"]!))
                imageView.frame = CGRect(x: blurView.frame.origin.x == 0 ? blurView.frame.origin.x + blurView.frame.width - 1: 0, y: 0, width: cellView.frame.width - blurView.frame.width + 1, height: cellView.frame.height)
                imageView.isUserInteractionEnabled = false
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                cellView.addSubview(imageView)
                
                // 设置精选文章的标题
                let essayLabel = UILabel(frame: CGRect(x: blurView.frame.origin.x + controlSpaced, y: 0, width: blurView.frame.width - controlSpaced * 2, height: 0))
                essayLabel.text = essayData[index]["name"]
                essayLabel.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
                // 根据字符串长度赋予不同行数,最多为两行
                if isTruncated(essayLabel) {
                    essayLabel.numberOfLines += 1
                }
                essayLabel.sizeToFit()
                essayLabel.frame.size.width = blurView.frame.width - controlSpaced * 2
                essayLabel.isUserInteractionEnabled = false
                cellView.addSubview(essayLabel)
                
                // 设置精选文章的作者名
                let essayLabel2 = UILabel()
                essayLabel2.text = essayData[index]["author"]
                essayLabel2.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
                essayLabel2.sizeToFit()
                essayLabel2.isUserInteractionEnabled = false
                cellView.addSubview(essayLabel2)
                cell.contentView.addSubview(cellView)
                
                // 根据字符串行数判断动态坐标
                if essayLabel.numberOfLines == 1 {
                    essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - controlSpaced) / 2
                    essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + controlSpaced, y: (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - controlSpaced) / 2 + essayLabel.frame.height * 2 + controlSpaced)
                } else {
                    essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - controlSpaced) / 2
                    essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + controlSpaced, y: (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - controlSpaced) / 2 + essayLabel.frame.height + controlSpaced)
                }
                
            }
            
        }
        
        // 判断字符串是否超出UILabel的范围
        func isTruncated(_ label: UILabel) -> Bool {
            
            let judgmentLabel = UILabel()
            judgmentLabel.text = label.text
            judgmentLabel.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
            judgmentLabel.sizeToFit()
            return label.frame.width < judgmentLabel.frame.width
            
        }
        
    }
    
    // 导航栏随着滚动而动态变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(learningTableView.contentOffset)
        
        let offset = learningTableView.contentOffset.y - initialOffset // 通过现在的偏移量减去初始偏移量获得相较于初始状态实际偏移的数值
        
        // 导航栏初始大标题渐变消失和放大动画代码
        if !offsetJudgment {
            if !offsetJudgment, offset >= 0 {
                
                self.navLabel.frame.origin.y = screenSpaced - offset
                self.navLabel.alpha = 1 - (offset / navHeight)
            } else {
                self.navLabel.frame.origin.y = screenSpaced - offset / 2.5
                self.navLabel.frame.size.height = screenHeight / 25 * (1 - offset / navHeight / 12)
                self.navLabel.font = UIFont.systemFont(ofSize: screenHeight / 25 * (1 - offset / navHeight / 12), weight: .bold)
                self.navLabel.alpha = 1 - (offset / navHeight)
            }
        }
        
        // 导航栏标题随着大标题的消失而出现的代码
        let titleViewRect = CGRect(x: 0, y: 0, width: screenWidth / 4, height: self.navigationController?.navigationBar.frame.height ?? screenHeight / 20)
        let titleView = UILabel(frame: titleViewRect)
        titleView.text = "学习"
        titleView.font = UIFont.systemFont(ofSize: titleView.font.pointSize, weight: .bold)
        let containerView = UIView(frame: titleViewRect)
        containerView.addSubview(titleView)
        titleView.textAlignment = .center
        self.navigationItem.titleView = containerView
        // 控制导航栏标题渐变出现透明度
        if self.navLabel.alpha <= 0.7 {
            titleView.alpha = (offset / navHeight) - 0.36776
        } else {
            titleView.alpha = 0
        }
        
    }
    
}

// 创建讨论界面
class DiscussViewController: UIViewController {
    
    let textLabel = ["ActivityIndicator", "ProgressView", "Control", "Picker", "ScrollView", "lunbotu", "DataView", "ScrollView"]
    
    var buttonArray: Array<UIButton> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "讨论"
        
        let safeView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .insetGrouped)
        // safeView.rowHeight = screenHeight / 5
        safeView.separatorStyle = .none
        safeView.backgroundColor = .systemBackground
        // safeView.isEditing = true
        
        safeView.dataSource = self
        safeView.delegate = self
        
        view.addSubview(safeView)
        
    }
    
}

extension DiscussViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        // cell.selectionStyle = .gray
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let view = UIView()
        print(cell.bounds.size.width, screenWidth)
        view.frame.size = CGSize(width: cell.bounds.size.width, height: screenHeight / 5 - controlSpaced)
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 15
        cell.contentView.addSubview(view)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(ActivityIndicatorViewController(), animated: true)
        case 1: self.present(ProgressViewViewController(), animated: true)
        case 2: self.present(Control(), animated: true)
        case 3: self.present(Picker(), animated: true)
        case 4:
            let SVC = ScrollView()
            SVC.modalPresentationStyle = .currentContext
            self.present(SVC, animated: true)
        case 5: self.present(lunbotu(), animated: true)
        case 6:
            let SVC = DataViewController()
            SVC.modalPresentationStyle = .currentContext
            self.present(SVC, animated: true)
        case 7:
            let SVC = ScrollViewController()
            SVC.modalPresentationStyle = .currentContext
            self.present(SVC, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        controlSpaced
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}

// 创建收藏界面
class CollectionViewController: UIViewController {
    
    // 在滑动collectionTableView之前获取初始偏移量，offsetJudgment判断是否是首次滑动，如果是首次滑动就用initialOffset接收当时的偏移量
    var offsetJudgment = true
    var initialOffset = CGFloat()
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if offsetJudgment {
            initialOffset = collectionTableView.contentOffset.y
            offsetJudgment = false
        }
    }
    
    let navLabel = UILabel(frame: navLabelFrame) // 创建导航栏标题，会随着collectionTableView的滑动而消失或者放大
    let collectionTableView = UITableView(frame: screenFrame, style: .grouped) // 创建一个UITableView作为CollectionViewController的主体
    var headerBtnArray: Array<UIButton> = [] // 接受收藏界面导航栏的headerBtn的数组
    let collectionScrollView = UIScrollView(frame: screenFrame) // 创建收藏界面的整个大视图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        
        // 设置收藏界面大视图的整个属性
        collectionScrollView.contentSize = CGSize(width: screenWidth * 5, height: screenHeight)
        collectionScrollView.backgroundColor = .systemBackground
        collectionScrollView.isPagingEnabled = true
        collectionScrollView.showsHorizontalScrollIndicator = false
        collectionScrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionScrollView)
        
        print(collectionTableView.contentOffset, "collectionTableView.contentOffset")
        print(collectionScrollView.contentOffset, "collectionScrollView.contentOffset")
        
        // 设置收藏页导航栏大标题的其他属性
        navLabel.text = "我的收藏"
        navLabel.font = UIFont.systemFont(ofSize: titleFont, weight: .heavy)
        self.navigationController?.navigationBar.addSubview(navLabel)
        
        // 初始化tableview
        collectionTableView.rowHeight = tableCellFrame.height + controlSpaced
        collectionTableView.separatorStyle = .none
        collectionTableView.backgroundColor = .systemBackground
        collectionScrollView.addSubview(collectionTableView)
        collectionTableView.dataSource = self
        collectionTableView.delegate = self
        // collectionScrollView.delegate = self
        
        // 两字和三字UILabel的参考尺寸
        let referenceLabel2 = UILabel()
        referenceLabel2.text = "一二"
        referenceLabel2.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        referenceLabel2.sizeToFit()
        let referenceLabel3 = UILabel()
        referenceLabel3.text = "一二三"
        referenceLabel3.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        referenceLabel3.sizeToFit()
        
        // 获取状态栏高度
        var statusBarHeight = CGFloat()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = windowScene.statusBarManager {
            statusBarHeight = statusBarManager.statusBarFrame.height
        }
        
        // 循环创建收藏界面导航栏按钮
        for i in 0 ... 4 {
            
            let headerBtn = UIButton(frame: CGRect(x: screenSpaced, y: statusBarHeight + screenSpaced + navLabelFrame.maxY, width: referenceLabel2.frame.width, height: referenceLabel2.frame.height))
            let array = ["收藏夹", "课程", "文章", "讨论", "闲聊"]
            headerBtn.setTitle(array[i], for: .normal)
            headerBtn.setTitleColor(.black, for: .normal)
            if i == 0 {
                headerBtn.frame.size.width = referenceLabel3.frame.width
                headerBtn.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            } else {
                headerBtn.frame.origin.x = headerBtnArray[i - 1].frame.maxX + controlSpaced
                headerBtn.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
            }
            headerBtn.tag = i
            headerBtn.addTarget(self, action: #selector(navClicked), for: .touchUpInside)
            headerBtnArray.append(headerBtn)
            
            // self.navigationItem.titleView?.addSubview(headerBtn)
            self.view.addSubview(headerBtn)
            
        }
        
        // 创建空的头部视图调整cell的位置
        let headerView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: screenWidth, height: headerBtnArray[0].frame.maxY - statusBarHeight - (self.navigationController?.navigationBar.frame.height)!)))
        collectionTableView.tableHeaderView = headerView
        
    }
    
    // 导航栏按钮点击事件
    @objc func navClicked(sender: UIButton) {
        
        collectionScrollView.setContentOffset(CGPoint(x: Int(screenWidth) * sender.tag, y: -97), animated: true)
        print(collectionScrollView.contentOffset)
        switch sender.tag {
        case 0:
            sender.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            for i in 0 ... 4 {
                if i != 0 {
                    headerBtnArray[i].titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
                }
            }
        case 1:
            sender.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            for i in 0 ... 4 {
                if i != 1 {
                    headerBtnArray[i].titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
                }
            }
        case 2:
            sender.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            for i in 0 ... 4 {
                if i != 2 {
                    headerBtnArray[i].titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
                }
            }
        case 3:
            sender.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            for i in 0 ... 4 {
                if i != 3 {
                    headerBtnArray[i].titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
                }
            }
        default:
            sender.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            for i in 0 ... 4 {
                if i != 4 {
                    headerBtnArray[i].titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
                }
            }
        }
        
    }
    
}

// 收藏界面扩展类
extension CollectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 设置精选文章的cell行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    // 设置cell的行高，第一行用作该模块的标题行
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableCellFrame.height + controlSpaced
    }
    
    // 重用池创建和调用cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        return cell
        
    }
    
    // 创建自定义cellView视图
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let essayData = essayData() // 获取CourseData中的数据
        
        if cell.contentView.subviews.isEmpty {
            
            // 创建精选文章的框
            let cellView = UIButton(frame: tableCellFrame)
            cellView.backgroundColor = .systemFill
            cellView.setImage(UIImage(named: essayData[indexPath.row % 4]["image"]!), for: .normal)
            cellView.imageView?.contentMode = .scaleAspectFill
            cellView.layer.cornerRadius = basicCornerRadius
            cellView.clipsToBounds = true
            
            // 设置精选文章信息区域的高斯模糊背景
            let blurEffect = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blurEffect)
            if (indexPath.row - indexPath.row % 3) % 2 == 0 {
                print(indexPath.row)
                blurView.frame = CGRect(x: cellView.frame.width / 5 * 2, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
            } else {
                print(indexPath.row)
                blurView.frame = CGRect(x: 0, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
            } // 判断模糊应该在左边还是右边
            blurView.isUserInteractionEnabled = false
            cellView.addSubview(blurView)
            
            // 创建封面图视图
            let imageView = UIImageView(image: UIImage(named: essayData[indexPath.row % 4]["image"]!))
            imageView.frame = CGRect(x: blurView.frame.origin.x == 0 ? blurView.frame.origin.x + blurView.frame.width - 1: 0, y: 0, width: cellView.frame.width - blurView.frame.width + 1, height: cellView.frame.height)
            imageView.isUserInteractionEnabled = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            cellView.addSubview(imageView)
            
            // 设置精选文章的标题
            let essayLabel = UILabel(frame: CGRect(x: blurView.frame.origin.x + controlSpaced, y: 0, width: blurView.frame.width - controlSpaced * 2, height: 0))
            essayLabel.text = essayData[indexPath.row % 4]["name"]
            essayLabel.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
            // 根据字符串长度赋予不同行数,最多为两行
            if isTruncated(essayLabel) {
                essayLabel.numberOfLines += 1
            }
            essayLabel.sizeToFit()
            essayLabel.frame.size.width = blurView.frame.width - controlSpaced * 2
            essayLabel.isUserInteractionEnabled = false
            cellView.addSubview(essayLabel)
            
            // 设置精选文章的作者名
            let essayLabel2 = UILabel()
            essayLabel2.text = essayData[indexPath.row % 4]["author"]
            essayLabel2.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
            essayLabel2.sizeToFit()
            essayLabel2.isUserInteractionEnabled = false
            cellView.addSubview(essayLabel2)
            cell.contentView.addSubview(cellView)
            
            // 根据字符串行数判断动态坐标
            if essayLabel.numberOfLines == 1 {
                essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - controlSpaced) / 2
                essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + controlSpaced, y: (blurView.frame.height - essayLabel.frame.height * 2 - essayLabel2.frame.height - controlSpaced) / 2 + essayLabel.frame.height * 2 + controlSpaced)
            } else {
                essayLabel.frame.origin.y = (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - controlSpaced) / 2
                essayLabel2.frame.origin = CGPoint(x: blurView.frame.origin.x + controlSpaced, y: (blurView.frame.height - essayLabel.frame.height - essayLabel2.frame.height - controlSpaced) / 2 + essayLabel.frame.height + controlSpaced)
            }
            
        }
        
        // 判断字符串是否超出UILabel的范围
        func isTruncated(_ label: UILabel) -> Bool {
            
            let judgmentLabel = UILabel()
            judgmentLabel.text = label.text
            judgmentLabel.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
            judgmentLabel.sizeToFit()
            return label.frame.width < judgmentLabel.frame.width
            
        }
        
    }
    
    // 导航栏随着滚动而动态变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = collectionTableView.contentOffset.y - initialOffset // 通过现在的偏移量减去初始偏移量获得相较于初始状态实际偏移的数值
        
        print(collectionTableView.contentOffset, "collectionTableView.contentOffset")
        print(collectionScrollView.contentOffset, "collectionScrollView.contentOffset")
        
        // 导航栏初始大标题渐变消失和放大动画代码
        if !offsetJudgment {
            if !offsetJudgment, offset >= 0 {
                self.navLabel.frame.origin.y = screenSpaced - offset
                self.navLabel.alpha = 1 - (offset / navHeight)
            } else {
                self.navLabel.frame.origin.y = screenSpaced - offset / 2.5
                self.navLabel.frame.size.height = screenHeight / 25 * (1 - offset / navHeight / 12)
                self.navLabel.font = UIFont.systemFont(ofSize: screenHeight / 25 * (1 - offset / navHeight / 12), weight: .bold)
                self.navLabel.alpha = 1 - (offset / navHeight)
            }
        }
        
        // 导航栏标题随着大标题的消失而出现的代码
        let navTitleViewFrame = CGRect(x: 0, y: 0, width: screenWidth / 4, height: self.navigationController?.navigationBar.frame.height ?? screenHeight / 20)
        let titleView = UILabel(frame: navTitleViewFrame)
        titleView.text = "收藏"
        titleView.font = UIFont.systemFont(ofSize: titleView.font.pointSize, weight: .bold)
        let containerView = UIView(frame: navTitleViewFrame)
        containerView.addSubview(titleView)
        titleView.textAlignment = .center
        self.navigationItem.titleView = containerView
        // 控制导航栏标题渐变出现透明度
        if self.navLabel.alpha <= 0.7 {
            titleView.alpha = (offset / navHeight) - 0.36776
        } else {
            titleView.alpha = 0
        }

    }
    
}

class ViewController4: UIViewController {
    
}

class ActivityIndicatorViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var a = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        // UIActivityIndicatorView()
        activityIndicator.frame.size = CGSize(width: 100, height: 100)
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.white
        activityIndicator.backgroundColor = UIColor.systemGray
        activityIndicator.layer.cornerRadius = 30
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = false // 默认为true：控件停止动画时隐藏
        activityIndicator.isUserInteractionEnabled = true // 默认为false：控件不可交互
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        activityIndicator.addGestureRecognizer(tap) // UITapGestureRecognizer是一个轻触手势
        view.addSubview(activityIndicator)
        
    }
    
    // activityIndicator关联的方法
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            if a == 0 {
                a = 1
                activityIndicator.stopAnimating()
            } else {
                a = 0
                activityIndicator.startAnimating()
            }
        }
        
    }
    
}

class ProgressViewViewController: UIViewController {
    
    let progressView = UIProgressView(progressViewStyle: .default)
    var num = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        // UIProgressView()
        progressView.frame = CGRect(x: 20, y: 100, width: 300, height: 100)
        progressView.progressTintColor = UIColor.white // 设置进度条的颜色
        progressView.trackTintColor = UIColor.gray // 设置进度条的背景颜色
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 0.2
        progressView.layer.cornerRadius = 0
        progressView.progress = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(increaseProgress))
        progressView.addGestureRecognizer(tap)
        
        view.addSubview(progressView)
        
    }
    
    @objc func increaseProgress(_ sender: Any) {
        
        num += 0.1
        progressView.setProgress(Float(num), animated: true)
        
    }
    
}

class Control: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let switchControl = UISwitch()
        switchControl.frame = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 50, height: 30))
        switchControl.isOn = false
        switchControl.tintColor = UIColor.blue
        switchControl.onTintColor = UIColor.red // 打开时候的颜色
        switchControl.thumbTintColor = UIColor.systemCyan // 滑块颜色
        switchControl.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        view.addSubview(switchControl)
        
        let slider = UISlider()
        slider.frame = CGRect(origin: CGPoint(x: 50, y: 150), size: CGSize(width: 300, height: 50))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.addSubview(slider)
        
        let stepper = UIStepper()
        stepper.frame = CGRect(origin: CGPoint(x: 50, y: 250), size: CGSize(width: 300, height: 100))
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 5
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        view.addSubview(stepper)
        
        let segmentControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
        segmentControl.frame = CGRect(origin: CGPoint(x: 50, y: 350), size: CGSize(width: 300, height: 50))
        segmentControl.selectedSegmentIndex = 0 // 初始选定段
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(segmentControl)
        
        let colorWell = UIColorWell()
        colorWell.frame = CGRect(origin: CGPoint(x: 50, y: 450), size: CGSize(width: 300, height: 50))
        colorWell.selectedColor = .red
        colorWell.addTarget(self, action: #selector(colorWellValueChanged(_:)), for: .valueChanged)
        view.addSubview(colorWell)
        
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is ON")
        } else {
            print("Switch is OFF")
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        print("Slider value changed to \(sender.value)")
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        print("Stepper value changed to \(sender.value)")
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        print("Segment control value changed to \(sender.selectedSegmentIndex)")
    }
    
    @objc func colorWellValueChanged(_ sender: UIColorWell) {
        print("Color well value changed to \(String(describing: sender.selectedColor))")
    }
    
}

class Picker: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        print("Date picker value changed to \(dateFormatter.string(from: sender.date))")
    }
    
}

class ScrollView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: view.bounds.width, height: view.bounds.height))
        scrollView.contentSize = CGSize(width: view.bounds.width, height: (view.bounds.height - 100) * 2)
        view.addSubview(scrollView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        print("开始下拉刷新")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("松手后打印的内容")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("自动收回控件")
                sender.endRefreshing()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("收回控件后打印的内容")
                }
            }
        }
    }
    
    
}

class lunbotu: UIViewController {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: Timer!
    let imageWidth = UIScreen.main.bounds.width
    let imageHeight = UIScreen.main.bounds.width * 0.6
    let images = ["image1.jpg", "image2.jpg", "image3.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        scrollView.contentSize = CGSize(width: imageWidth * CGFloat(images.count), height: imageHeight)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        for i in 0 ..< images.count {
            let imageView = UIImageView(frame: CGRect(x: imageWidth * CGFloat(i), y: 0, width: imageWidth, height: imageHeight))
            imageView.image = UIImage(named: images[i])
            scrollView.addSubview(imageView)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: imageHeight - 50, width: imageWidth, height: 50))
        pageControl.numberOfPages = images.count
        pageControl.currentPageIndicatorTintColor = UIColor.red // 选中颜色
        pageControl.pageIndicatorTintColor = UIColor.white // 未选中颜色
        pageControl.addTarget(self, action: #selector(aaa), for: .valueChanged)
        view.addSubview(pageControl)
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(autoScroll), userInfo:nil, repeats:true)
    }
    
    @objc func aaa() {
        let currentPage = pageControl.currentPage
        let offsetX = CGFloat(currentPage) * imageWidth
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc func autoScroll() {
        var currentPage = pageControl.currentPage
        currentPage += 1
        if currentPage == images.count {
            currentPage = 0
        }
        let offsetX = CGFloat(currentPage) * imageWidth
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension lunbotu: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentPage = Int(offsetX / imageWidth + 0.5)
        pageControl.currentPage = currentPage
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 5, target:self, selector:#selector(autoScroll), userInfo:nil, repeats:true)
    }
}

class DataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let textView = UITextField()
    let pickerView = UIPickerView()
    
    let years = ["2003", "2004"]
    let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    let days = ["01", "02", "03", "04", "05", "06", "07", "08", "09",
                "10", "11", "12", "13", "14", "15", "16", "17",
                "18", "19", "20", "21", "22", "23", "24", "25",
                "26", "27", "28"]
    let days1 = ["01", "02", "03", "04", "05", "06", "07", "08", "09",
                 "10", "11", "12", "13", "14", "15", "16", "17",
                 "18", "19", "20", "21", "22", "23", "24", "25",
                 "26", "27", "28", "29", "30"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        textView.frame = CGRect(origin: CGPoint(x: 50, y: 100), size: CGSize(width: 200, height: 50))
        textView.backgroundColor = UIColor.systemGray
        view.addSubview(textView)
        textView.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return years.count
        } else if component == 1 {
            return months.count
        } else {
            return days1.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return years[row]
        } else if component == 1 {
            return months[row]
        } else {
            return days1[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[pickerView.selectedRow(inComponent: 0)]
        let month = months[pickerView.selectedRow(inComponent: 1)]
        let day = days1[pickerView.selectedRow(inComponent: 2)]
        textView.text = "\(year)-\(month)-\(day)"
    }
}

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "image1.jpg"))
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        view.addSubview(scrollView)
        
        setZoomScale()
        setupGestureRecognizer()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(#function)
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print(#function)
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(#function)
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}
