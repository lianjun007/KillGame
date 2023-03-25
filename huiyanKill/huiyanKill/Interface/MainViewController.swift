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
        
        // 进入游戏按钮
        let enterGameBtnPoint = CGPoint(x: safePoint.x + safeSize.width - buttonSize.width, y: safePoint.y + safeSize.height - buttonSize.height)
        let enterGameButton = ButtonBuild(image: "", title: "进入游戏", piont: enterGameBtnPoint, view: view)
        enterGameButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let navButtonArray:Array<UIButton> = navigationBarBuild(view: view, direction: true, buttonCount: 3, buttonContent: [["unknown", "unknown", "unknown"], ["登录", "公告", "官网"]])
        navButtonArray[0].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        navButtonArray[1].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        navButtonArray[2].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        
    }
    
    @objc func buttonTapped() {
        self.navigationController?.pushViewController(ModeViewController(), animated: true)
    }
    
    @objc func stayTuned() {
        print(#function)
        let alertController = UIAlertController(title: "敬请期待", message: "该功能正在制作中......", preferredStyle: .alert)
        let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        alertController.addAction(knownAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

