
import UIKit

// 创建学习界面
class LearningViewController: UIViewController {
    
    let navLabel = UILabel(frame: navLabelFrame) // 创建导航栏标题，会随着learningTableView的滑动而消失或者放大
    let moduleLabel = UILabel(frame: CGRect(origin: moduleOrigin, size: CGSizeZero)) // 创建模块二级标题
    let learningTableView = UITableView(frame: screenFrame, style: .grouped) // 创建一个UITableView作为LearningViewController的主体
    var navBarHeight = CGFloat() // 接收导航栏高度的变量
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取状态栏高度
        var statusBarHeight = CGFloat()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let statusBarManager = windowScene.statusBarManager {
            statusBarHeight = statusBarManager.statusBarFrame.height
        }
        navBarHeight = navBar(self.navigationController!.navigationBar) // 获取导航栏高度
        let topHeight = statusBarHeight + navBarHeight // 导航栏加状态栏高度
        let courseData = courseData() // 获取CourseData中的数据
        
        // 设置导航栏标题的其他属性
        navLabel.text = "开始学习"
        navLabel.font = UIFont.systemFont(ofSize: titleFont, weight: .heavy)
        self.navigationController?.navigationBar.addSubview(navLabel)
        
        // 初始化tableview
        learningTableView.rowHeight = tableCellFrame.height + controlSpaced
        learningTableView.separatorStyle = .none
        learningTableView.backgroundColor = .systemBackground
        learningTableView.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(learningTableView)
        learningTableView.dataSource = self
        learningTableView.delegate = self
        
        // headerView是courseTableView的表头视图的容器
        let headerView = UIView(frame: CGRect(x: 0, y: topHeight, width: screenWidth, height: (screenHeight - navHeight * 2 - safeAreaInsets.top - safeAreaInsets.bottom) / 3 * 2 + topHeight))
        learningTableView.tableHeaderView = headerView
        
        // 设置头部容器视图的标题
        let headerLabel = UILabel(frame: CGRect(x: screenSpaced, y: screenSpaced * 2 + navLabelFrame.height + statusBarHeight, width: 0, height: 0))
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
        
        // 导航栏初始大标题渐变消失和放大动画代码
        if learningTableView.contentOffset.y >= 0 {
            self.navLabel.frame.origin.y = screenSpaced
            self.navLabel.alpha = 1 - (learningTableView.contentOffset.y / navHeight)
        } else {
            self.navLabel.frame.origin.y = screenSpaced - learningTableView.contentOffset.y / 2.5
            self.navLabel.frame.size.height = screenHeight / 25 * (1 - learningTableView.contentOffset.y / navHeight / 12)
            self.navLabel.font = UIFont.systemFont(ofSize: screenHeight / 25 * (1 - learningTableView.contentOffset.y / navHeight / 12), weight: .bold)
            self.navLabel.alpha = 1 - (learningTableView.contentOffset.y / navHeight)
        }
        
        // 导航栏标题随着大标题的消失而出现的代码
        let titleViewRect = CGRect(x: 0, y: 0, width: screenWidth / 4, height: navBarHeight)
        let titleView = UILabel(frame: titleViewRect)
        titleView.text = "学习"
        titleView.font = UIFont.systemFont(ofSize: titleView.font.pointSize, weight: .bold)
        let containerView = UIView(frame: titleViewRect)
        containerView.addSubview(titleView)
        titleView.textAlignment = .center
        self.navigationItem.titleView = containerView
        // 控制导航栏标题渐变出现透明度
        if self.navLabel.alpha <= 0.7 {
            titleView.alpha = (learningTableView.contentOffset.y / navHeight) - 0.36776
        } else {
            titleView.alpha = 0
        }
        
    }
    
}
