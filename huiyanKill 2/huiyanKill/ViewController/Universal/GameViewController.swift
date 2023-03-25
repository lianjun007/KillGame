//
//  GameViewController.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/20.
//

import UIKit

let view = UIView()

class GameViewController: UIViewController {
    
    var roleChoose: Int? // 选择的角色在roleData中的key form SingleViewController
    var roleCount: Int? // 选择的游戏角色数 form SingleViewController
    
    let num = 1

    let roleBoxSize = (66, 33, 50, 30, 80, 120)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameProcess().playerAction()
        
        view.addSubview(button111)
        let guide = view.safeAreaLayoutGuide
        let button = UIButton()
        button.setTitle("My Button", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        for i in 0 ... roleCount! {
            if roleCount == 2 {
                let roleBox = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
                roleBox.layer.cornerRadius = 15
                view.addSubview(roleBox)
                roleBox.backgroundColor = .blue
            }

        }
        
        var roleDataLabel: [UILabel] = []
        for i in 0 ... 4 {
            roleDataLabel.append(UILabel())
            roleDataLabel[i].frame = CGRect(x: 20, y: i * 20 + 10, width: 120, height: 80)
            roleDataLabel[i].textColor = .white
//            roleDataLabel[i].text = appDelegate.roleDate[0]?["角色"]
            view.addSubview(roleDataLabel[i])
        }
        
    }
    
}
