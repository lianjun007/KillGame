
import UIKit

// 创建收藏界面
class CollectionViewController: UIViewController {
    
    let navLabel = UILabel(frame: navLabelFrame) // 创建导航栏标题，会随着collectionTableView的滑动而消失或者放大
    var collectionTableViewArray: Array<UITableView> = []
    var judgmentPage = 0
    var headerBtnArray: Array<UIButton> = [] // 接受收藏界面导航栏的headerBtn的数组
    let collectionScrollView = UIScrollView(frame: screenFrame) // 创建收藏界面的整个大视图
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
        
        // 设置收藏界面大视图的整个属性
        collectionScrollView.contentSize = CGSize(width: screenWidth * 5, height: screenHeight)
        collectionScrollView.backgroundColor = .systemBackground
        collectionScrollView.isPagingEnabled = true
        collectionScrollView.showsHorizontalScrollIndicator = false
        collectionScrollView.showsVerticalScrollIndicator = false
        collectionScrollView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.navigationBar.isTranslucent = true
        collectionScrollView.delegate = self
        self.view.addSubview(collectionScrollView)
        
        // 设置收藏页导航栏大标题的其他属性
        navLabel.text = "我的收藏"
        navLabel.font = UIFont.systemFont(ofSize: titleFont, weight: .heavy)
        self.navigationController?.navigationBar.addSubview(navLabel)
        
        // 两字和三字UILabel的参考尺寸
        let referenceLabel2 = UILabel()
        referenceLabel2.text = "一二"
        referenceLabel2.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        referenceLabel2.sizeToFit()
        let referenceLabel3 = UILabel()
        referenceLabel3.text = "一二三"
        referenceLabel3.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        referenceLabel3.sizeToFit()
        
        // 循环创建收藏界面导航栏按钮
        for i in 0 ... 9 {
            if 0 ... 4 ~= i {
                
                let headerBtn = UIButton(frame: CGRect(x: screenSpaced, y: screenSpaced + navLabelFrame.maxY, width: referenceLabel2.frame.width, height: referenceLabel2.frame.height))
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
                self.navigationController?.navigationBar.addSubview(headerBtn)
                
            } else {
                
                let headerBtn = UIButton(frame: CGRect(x: screenSpaced, y: statusBarHeight + screenSpaced + navLabelFrame.maxY, width: referenceLabel2.frame.width, height: referenceLabel2.frame.height))
                headerBtn.setTitleColor(.black, for: .normal)
                if i == 5 {
                    headerBtn.frame.size.width = referenceLabel3.frame.width
                } else {
                    headerBtn.frame.origin.x = headerBtnArray[i - 5].frame.minX
                }
                headerBtn.tag = i
                headerBtn.addTarget(self, action: #selector(navClicked), for: .touchUpInside)
                headerBtnArray.append(headerBtn)
                self.view.addSubview(headerBtn)
                
            }
        }
        
        // 创建空的头部视图调整cell的位置
        let headerView = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: screenWidth, height: headerBtnArray[0].frame.maxY + statusBarHeight)))
        
        // 初始化tableview
        for i in 0 ... 4 {
            let collectionTableView = UITableView(frame: screenFrame, style: .grouped) // 创建一个UITableView作为CollectionViewController的主体
            collectionTableView.frame.origin.x += screenWidth * CGFloat(i)
            collectionTableView.rowHeight = tableCellFrame.height + controlSpaced
            collectionTableView.separatorStyle = .none
            collectionTableView.backgroundColor = .systemBackground
            collectionTableView.contentInsetAdjustmentBehavior = .never
            collectionTableView.tableHeaderView = headerView
            collectionScrollView.addSubview(collectionTableView)
            collectionTableView.dataSource = self
            collectionTableView.delegate = self
            collectionTableViewArray.append(collectionTableView)
        }
        
    }
    
    // 导航栏按钮点击事件
    @objc func navClicked(sender: UIButton) {
        
        collectionScrollView.setContentOffset(CGPoint(x: Int(screenWidth) * sender.tag, y: 0), animated: true)
        print(collectionTableViewArray[0].contentOffset, collectionScrollView.contentOffset)
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
        case 4:
            sender.titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .heavy)
            for i in 0 ... 4 {
                if i != 4 {
                    headerBtnArray[i].titleLabel?.font = UIFont.systemFont(ofSize: titleFont2, weight: .ultraLight)
                }
            }
        default:
            headerBtnArray[sender.tag - 5].sendActions(for: .touchUpInside)
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
            blurView.frame = CGRect(x: cellView.frame.width / 5 * 2, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
        } else {
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
        
        // 判断字符串是否超出UILabel的范围
        func isTruncated(_ label: UILabel) -> Bool {
            
            let judgmentLabel = UILabel()
            judgmentLabel.text = label.text
            judgmentLabel.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
            judgmentLabel.sizeToFit()
            return label.frame.width < judgmentLabel.frame.width
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 停止滑动时模拟点击导航栏按钮，实现跟随切换效果
        if collectionScrollView.contentOffset.x / screenWidth == 0 || (1 != 0) || (2 != 0) || (3 != 0) || (4 != 0) {
            headerBtnArray[Int(collectionScrollView.contentOffset.x / screenWidth)].sendActions(for: .touchUpInside)
            judgmentPage = Int(collectionScrollView.contentOffset.x / screenWidth)
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
//        if scrollView == collectionScrollView {
//            print(#function)
//            for i in 0 ... 4 {
//                if i != judgmentPage {
//                    collectionTableViewArray[i].setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//                }
//            }
//        }
        
    }
    
    // 导航栏随着滚动而动态变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 导航栏初始大标题渐变消失和放大动画代码
        if collectionTableViewArray[judgmentPage].contentOffset.y >= 0 {
            self.navLabel.frame.origin.y = screenSpaced - collectionTableViewArray[judgmentPage].contentOffset.y
            self.navLabel.alpha = 1 - (collectionTableViewArray[judgmentPage].contentOffset.y / navHeight)
        } else {
            self.navLabel.frame.origin.y = screenSpaced - collectionTableViewArray[judgmentPage].contentOffset.y / 2.5
            self.navLabel.frame.size.height = screenHeight / 25 * (1 - collectionTableViewArray[judgmentPage].contentOffset.y / navHeight / 12)
            self.navLabel.font = UIFont.systemFont(ofSize: screenHeight / 25 * (1 - collectionTableViewArray[judgmentPage].contentOffset.y / navHeight / 12), weight: .bold)
            self.navLabel.alpha = 1 - (collectionTableViewArray[judgmentPage].contentOffset.y / navHeight)
        }
        
        // 导航栏标题随着大标题的消失而出现的代码
        let navTitleViewFrame = CGRect(x: 0, y: 0, width: screenWidth / 4, height: navBarHeight)
        let titleView = UILabel(frame: navTitleViewFrame)
        titleView.text = "收藏"
        titleView.font = UIFont.systemFont(ofSize: titleView.font.pointSize, weight: .bold)
        let containerView = UIView(frame: navTitleViewFrame)
        containerView.addSubview(titleView)
        titleView.textAlignment = .center
        self.navigationItem.titleView = containerView
        // 控制导航栏标题渐变出现透明度
        if self.navLabel.alpha <= 0.7 {
            self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            titleView.alpha = (collectionTableViewArray[judgmentPage].contentOffset.y / navHeight) - 0.36776
        } else {
            self.navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.compactAppearance
            titleView.alpha = 0
        }
        
    }
    
}
