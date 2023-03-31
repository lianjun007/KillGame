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
        
        let navButtonArray = navigationBarBuild(view: view, direction: true, buttonCount: 1, buttonContent: [[""], ["返回"]], bounce: false)
        // navButtonArray[0].addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
        var boxPoint = CGPoint()
        for i in 0 ..< 8 {
            let roleBoxButton = UIButton()
            switch i {
            case 1: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 4, y: safePoint.y)
            case 2: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 3, y: safePoint.y)
            case 3: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 2, y: safePoint.y)
            case 4: boxPoint = CGPoint(x: safePoint.x + roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6, y: safePoint.y)
            case 5: boxPoint = CGPoint(x: safePoint.x, y: safePoint.y + roleBoxSmallSize.height / 2)
            case 6: boxPoint = CGPoint(x: safePoint.x, y: safePoint.y + safeSize.height - roleBoxSmallSize.height)
            case 7: boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 6, y: safePoint.y + roleBoxSmallSize.height / 2)
            default:
                boxPoint = CGPoint(x: safePoint.x + (roleBoxSmallSize.width + (safeSize.width - roleBoxSmallSize.width * 7) / 6) * 5, y: safePoint.y)
            }
            roleBoxButton.frame.origin = boxPoint
            roleBoxButton.frame.size = roleBoxSmallSize
            roleBoxButton.layer.cornerRadius = smallContronRoundSize
            roleBoxButton.layer.borderWidth = 3
            roleBoxButton.layer.borderColor = borderColor
            roleBoxButtonArray.append(roleBoxButton)
            view.addSubview(roleBoxButton)
        }
        
        let roleDate = roleData[text!]
        roleBoxButtonArray[0].setImage(UIImage(named: roleDate["插画"]!), for: .normal)

    }

}
