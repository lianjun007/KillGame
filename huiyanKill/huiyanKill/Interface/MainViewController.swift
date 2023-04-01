//
//  ViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/24.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化视图
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = backgroundColor
        
        var roleDataArray: Array<Any> = []
        if let path = Bundle.main.path(forResource: "RoleData", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                if let arr = dict["神弃之地"] as? [Any] {
                    roleDataArray = arr
//                    for item in arr {
//                        print(item)
//                    }
                }
            }
        } else {
            print("文件不存在")
        }
        print(roleDataArray)
        
        // 进入游戏按钮
        let enterGameBtnPoint = CGPoint(x: safePoint.x + safeSize.width - buttonSize.width, y: safePoint.y + safeSize.height - buttonSize.height)
        let enterGameButton = ButtonBuild(image: "", title: "进入游戏", piont: enterGameBtnPoint, view: view)
        enterGameButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let buttonCount = 5
        let navButtonArray:Array<UIButton> = navigationBarBuild(view: view, direction: true, buttonCount: buttonCount, buttonContent: [["rectangle.portrait.and.arrow.right", "doc.richtext.ar", "macwindow.on.rectangle", "terminal", "gearshape"], ["登录", "公告", "官网", "日志", "设置"]], bounce: false)
        for i in 0 ..< buttonCount {
            navButtonArray[i].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        }
        
    }
    
    @objc func buttonTapped() {
        self.navigationController?.pushViewController(RoleViewController(), animated: true)
    }
    
    @objc func stayTuned() {
        let alertController = UIAlertController(title: "敬请期待", message: "该功能正在制作中......", preferredStyle: .alert)
        let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        alertController.addAction(knownAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

