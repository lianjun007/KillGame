//
//  ViewController2.swift
//  Tableview
//
//  Created by QHuiYan on 2023/6/15.
//

import UIKit

class ViewController2: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置界面视图的背景色和导航栏的基础设置
        view.backgroundColor = .systemBackground
        navigationItem.title = "通讯录"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        scrollView.frame = view.bounds
        scrollView.contentSize.height = view.bounds.height * 2
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        // 给已经登录的用户打招呼
        let userName = UILabel(frame: CGRect(x: spacedForScreen, y: spacedForControl, width: 0, height: 0))
        userName.text = userTips
        userName.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
        userName.sizeToFit()
        scrollView.addSubview(userName)
        
        // 提示词
        let tips = UILabel(frame: CGRect(x: spacedForScreen, y: spacedForModule + userName.frame.maxY, width: 0, height: 0))
        tips.text = "向上滑动以变成灰色"
        tips.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
        tips.sizeToFit()
        scrollView.addSubview(tips)
        
        let tips2 = UILabel(frame: CGRect(x: spacedForScreen, y: spacedForControl + tips.frame.maxY, width: screenWidth - spacedForScreen * 2, height: 0))
        tips2.text = """
没有时间适配，有点小问题：
tabBar切换后不会重新刷新界面，导致滑动后切换回来会有点混乱，应该可以写一个重新加载界面的方法来解决；
界面滑动到最底部时tabBar会消失，应该是UIScrollView视图的自动避让安全区导致滑动到底部时tabBar下面没有内容的原因，和UIScrollView默认Y轴偏移量为-96.777类似
"""
        tips2.numberOfLines = 0
        tips2.font = UIFont.systemFont(ofSize: basicFont)
        tips2.sizeToFit()
        scrollView.addSubview(tips2)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = .systemGray2.withAlphaComponent(scrollView.contentOffset.y / screenHeight)
        
    }

}
