//
//  GameViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/29.
//

import UIKit

class GameViewController: UIViewController {

    var roleBoxButtonArray: Array<UIButton> = []
    var text: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        let roleDateDict = roleData[text!]
        let navButtonArray = navigationBarBuild(view: view, direction: true, buttonCount: 1, buttonContent: [[""], ["返回"]], bounce: false)
        navButtonArray[0].addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        var boxPoint = CGPoint()
        for i in 0 ..< 8 {
            let roleBoxButton = UIButton()
            switch i {
            case 1: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 4, y: safePoint.y)
            case 2: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 3, y: safePoint.y)
            case 3: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 6, y: safePoint.y + roleBoxSmallSize.height / 2)
            case 4: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 2, y: safePoint.y)
            case 5: boxPoint = CGPoint(x: safePoint.x, y: safePoint.y + roleBoxSmallSize.height / 2)
            case 6: boxPoint = CGPoint(x: safePoint.x + roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6, y: safePoint.y)
            case 7: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 5, y: safePoint.y)
            default:
                boxPoint = CGPoint(x: safePoint.x, y: safePoint.y + safeSize.height - roleBoxSmallSize.height)
            }
            roleBoxButton.frame.origin = boxPoint
            roleBoxButton.frame.size = roleBoxSmallSize
            roleBoxButton.layer.cornerRadius = smallContronRoundSize
            roleBoxButton.layer.borderWidth = thinBorderWidth
            roleBoxButton.layer.borderColor = borderColor
            roleBoxButton.layer.masksToBounds = true
            roleBoxButtonArray.append(roleBoxButton)
            view.addSubview(roleBoxButton)
            
            // 创建选择角色框(chooseRoleBox)上的名称标签(nameLabel)
            let nameLabel = UILabel()
            nameLabel.backgroundColor = UIColor(cgColor: borderColor)
            nameLabel.text = roleDateDict["角色"]
            nameLabel.textColor = fontColor
            nameLabel.textAlignment = .center
            nameLabel.font = UIFont.systemFont(ofSize: 13)
            roleBoxButton.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: roleBoxButton.topAnchor, constant: roleBoxButton.frame.size.height / 4 * 3),
                nameLabel.leadingAnchor.constraint(equalTo: roleBoxButton.leadingAnchor, constant: thinBorderWidth),
                nameLabel.trailingAnchor.constraint(equalTo: roleBoxButton.trailingAnchor, constant: -thinBorderWidth),
                nameLabel.bottomAnchor.constraint(equalTo: roleBoxButton.bottomAnchor, constant: -(roleBoxButton.frame.size.height / 8))
            ])
        }
        
        roleBoxButtonArray[0].setImage(UIImage(named: roleDateDict["插画"]!), for: .normal)

    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }

}
