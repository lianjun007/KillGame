//
//  RoleChooseViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/26.
//

import UIKit

class RoleChooseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navButtonArray:Array<UIButton> = navigationBarBuild(view: view, direction: true, buttonCount: 1, buttonContent: [["person"], ["角色选择"]], bounce: false)
        navButtonArray[0].frame.origin.x += CGFloat(buttonSize.width + controlSpaced)
        navButtonArray[0].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
        
        // Role Interface 创建滚动视图
        displayBoxView.showsHorizontalScrollIndicator = true
        displayBoxView.contentSize = CGSize(width: CGFloat(roleData.count) * (roleBoxLargeSize.width + controlSpaced) - controlSpaced, height: displayBoxView.frame.size.height)
        view.addSubview(displayBoxView)
        
        // 创建ModeBox
        for i in 0 ..< roleData.count {
            
            var roleData = roleData[i]
            
            if roleData["插画"]!.isEmpty {
                roleData["插画"] = "DefaultRole.jpeg"
            }
            if roleData["角色"]!.isEmpty {
                roleData["角色"] = "敬请期待"
            }
            
            let modeBox = UIButton(frame: CGRect(origin: displayMode == 0 ? CGPoint(x: 0, y: 0): CGPoint(x: screenSpaced, y: 0), size: roleBoxSize))
            modeBox.frame.origin.x += CGFloat(i) * (controlSpaced + modeBox.frame.width)
            modeBoxArray.append(modeBox)
            modeBox.layer.cornerRadius = controlRoundSize
            let borderWidth = CGFloat(3)
            modeBox.tag = i
            modeBox.layer.borderWidth = borderWidth
            modeBox.layer.borderColor = controlColor.withAlphaComponent(0.8).cgColor
            modeBox.setImage(UIImage(named: roleData["插画"]!), for: .normal)
            modeBox.imageView?.contentMode = .scaleAspectFill
            modeBox.layer.masksToBounds = true
            modeBox.backgroundColor = backgroundColor
            displayBoxView.addSubview(modeBox)
            
            // Mode Title
            let modeLabel = UILabel()
            modeLabel.backgroundColor = controlColor.withAlphaComponent(0.8)
            modeLabel.text = roleData["角色"] //
            modeLabel.textColor = fontColor
            modeBox.addSubview(modeLabel)
            modeLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                modeLabel.topAnchor.constraint(equalTo: modeBox.topAnchor, constant: modeBox.frame.size.height / 4 * 3),
                modeLabel.leadingAnchor.constraint(equalTo: modeBox.leadingAnchor, constant: borderWidth),
                modeLabel.trailingAnchor.constraint(equalTo: modeBox.trailingAnchor, constant: -borderWidth),
                modeLabel.bottomAnchor.constraint(equalTo: modeBox.bottomAnchor, constant: -(modeBox.frame.size.height / 8))
            ])
            
        }
        
        for i in 0 ..< roleData.count {
            modeBoxArray[i].addTarget(self, action: #selector(scrollToView), for: .touchUpInside)
        }
        
    }
    
    let displayBoxView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced), size: CGSize(width: screenWidth, height: safeSize.height - controlSpaced - buttonSize.height)))
    var modeBoxArray: Array<UIButton> = []
    
    @objc func scrollToView(sender: UIButton) {
        displayBoxView.setContentOffset(CGPoint(x: modeBoxArray[sender.tag].frame.origin.x - safePoint.x, y: 0), animated: true)
    }
    
    @objc func clickEvents() {
        self.dismiss(animated: true)
    }

}
