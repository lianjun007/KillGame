//
//  RoleViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/24.
//

import UIKit

class RoleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化视图
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = backgroundColor
        
        let buttonCount = 4
        let navButtonArray:Array<UIButton> = navigationBarBuild(view: view, direction: true, buttonCount: buttonCount, buttonContent: [["arrowshape.backward", "person", "figure.softball", "person.2"], ["返回首页", "角色选择", "模式选择", "角色图鉴"]], bounce: false)
        for i in 0 ..< buttonCount {
            navButtonArray[i].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
            navButtonArray[i].tag = i
        }
        
        // roleImageBox是插画显示区域
        let roleImageBox = UIImageView(frame: CGRect(origin: roleImagePoint, size: roleBoxLargeSize))
        roleImageBox.backgroundColor = backgroundColor
        roleImageBox.layer.borderWidth = 7
        roleImageBox.layer.borderColor = controlColor.withAlphaComponent(0.8).cgColor
        roleImageBox.image = UIImage(named: "DefaultRole.jpeg")
        roleImageBox.contentMode = .scaleAspectFill
        roleImageBox.layer.cornerRadius = controlRoundSize
        roleImageBox.clipsToBounds = true
        view.addSubview(roleImageBox)
        
        // roleBrieflyBox是角色选择后的信息预览区域的背景
        let roleTextBox = UIScrollView(frame: CGRect(origin: roleTextPoint, size: roleTextSize))
        roleTextBox.backgroundColor = backgroundColor
        roleTextBox.layer.borderColor = controlColor.cgColor
        roleTextBox.layer.borderWidth = 7
        roleTextBox.layer.cornerRadius = controlRoundSize
        roleTextBox.contentSize = CGSize(width: roleTextSize.width, height: roleTextSize.height * 2) // 暂定
        view.addSubview(roleTextBox)
        
    }
    
    @objc func clickEvents(sender: UIButton) {
        switch sender.tag {
        case 0: self.navigationController?.popViewController(animated: true)
        case 1: self.present(RoleChooseViewController(), animated: false)
        case 2: self.present(ModeViewController(), animated: false)
        default:
            break
        }
        print(#function)
        let alertController = UIAlertController(title: "敬请期待", message: "该功能正在制作中......", preferredStyle: .alert)
        let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        alertController.addAction(knownAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
