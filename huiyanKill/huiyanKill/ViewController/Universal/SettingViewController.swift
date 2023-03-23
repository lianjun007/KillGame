//
//  SettingViewController.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/22.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // displayAdaptationButton是人数选择按钮
        let displayAdaptationButton = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        displayAdaptationButton.setImage(UIImage(systemName: "iphone.gen1"), for: .normal)
        displayAdaptationButton.setTitle("显示适配", for: .normal)
        displayAdaptationButton.tintColor = .white
        displayAdaptationButton.backgroundColor = .black
        displayAdaptationButton.layer.cornerRadius = CGFloat(20)
        if safeArea.left != 0 {
            view.addSubview(displayAdaptationButton)
        }

        // 给displayAdaptationButton按钮添加菜单
        let adaptation0 = UIAction(title: "默认方案", image: UIImage(systemName: "iphone.gen1.landscape")) { _ in
            displayAdaptationData = 0
            if let presentingVC = self.presentingViewController as? SingleViewController {
                presentingVC.viewDidLoad()
            }
            super.viewDidLoad()
            self.dismiss(animated: true) {
            }
        }
        let adaptation1 = UIAction(title: "刘海在左侧", image: UIImage(systemName: "iphone.gen3.landscape")) { _ in
            displayAdaptationData = 1
            self.dismiss(animated: true, completion: nil)
        }
        let adaptation2 = UIAction(title: "刘海在右侧", image: UIImage(systemName: "iphone.gen3.landscape")) { _ in
            displayAdaptationData = 2
        }
        let adaptation3 = UIAction(title: "忽略刘海", image: UIImage(systemName: "iphone.gen3.landscape")) { _ in
            displayAdaptationData = 3
        }
        let adaptation4 = UIAction(title: "全屏显示", image: UIImage(systemName: "iphone.gen3.landscape")) { _ in
            displayAdaptationData = 4
        }
        let adaptationMenu = UIMenu(title: "选择你想要的显示区域方案", children: [adaptation0, adaptation1, adaptation2, adaptation3, adaptation4])
        displayAdaptationButton.menu = adaptationMenu
        displayAdaptationButton.showsMenuAsPrimaryAction = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let presentationController = self.presentationController as? SingleViewController {
            presentationController.viewDidLoad()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            
        }
    }
    
}
