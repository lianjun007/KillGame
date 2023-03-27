//
//  ModeViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/24.
//

import UIKit

class ModeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navButtonArray:Array<UIButton> = navigationBarBuild(view: view, direction: true, buttonCount: 1, buttonContent: [["figure.softball"], ["模式选择"]], bounce: false, boxAlpha: 1)
        navButtonArray[0].frame.origin.x += CGFloat((buttonSize.width + controlSpaced) * 2)
        navButtonArray[0].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
        
        let boxCount = 5
        let boxContent = [["单人模式", "剧情模式", "军团模式", "BOSS模式"], ["singlePlayerMode.jpeg"]]
        
        // Mode Interface 创建滚动视图
        displayBoxView.showsHorizontalScrollIndicator = false
        displayBoxView.contentSize = CGSize(width: CGFloat(boxCount) * (roleBoxLargeSize.width + controlSpaced) - controlSpaced, height: displayBoxView.frame.size.height)
        view.addSubview(displayBoxView)
        
        // 创建ModeBox
        for i in 0 ..< boxCount {
            
            var image = boxContent[1]
            var title = boxContent[0]
            if boxCount > image.count {
                for _ in 0 ..< boxCount - image.count {
                    image.append("stayTunedMode.png")
                }
            }
            if boxCount > title.count {
                for _ in 0 ..< boxCount - title.count {
                    title.append("敬请期待")
                }
            }
            
            let modeBox = UIButton(frame: CGRect(origin: displayMode == 0 ? CGPoint(x: 0, y: 0): CGPoint(x: screenSpaced, y: 0), size: roleBoxLargeSize))
            modeBox.frame.origin.x += CGFloat(i) * (controlSpaced + modeBox.frame.width)
            modeBoxArray.append(modeBox)
            modeBox.layer.cornerRadius = controlRoundSize
            let borderWidth = CGFloat(7)
            modeBox.tag = i
            modeBox.layer.borderWidth = borderWidth
            modeBox.layer.borderColor = controlColor.withAlphaComponent(0.8).cgColor
            modeBox.setImage(UIImage(named: image[i]), for: .normal)
            modeBox.imageView?.contentMode = .scaleAspectFill
            modeBox.layer.masksToBounds = true
            modeBox.backgroundColor = backgroundColor
            displayBoxView.addSubview(modeBox)
            
            // Mode Title
            let modeLabel = UILabel()
            modeLabel.backgroundColor = controlColor.withAlphaComponent(0.8)
            modeLabel.text = title[i] //
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
        
        for i in 0 ..< boxCount {
            modeBoxArray[i].addTarget(self, action: #selector(scrollToView), for: .touchUpInside)
        }
        
        modeBoxArray[0].addTarget(self, action: #selector(singlePlayerMode), for: .touchUpInside)
        modeBoxArray[1].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        modeBoxArray[2].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        modeBoxArray[3].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        modeBoxArray[4].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        
    }
    
    let displayBoxView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced), size: CGSize(width: screenWidth, height: safeSize.height - controlSpaced - buttonSize.height)))
    var modeBoxArray: Array<UIButton> = []
    
    @objc func scrollToView(sender: UIButton) {
        displayBoxView.setContentOffset(CGPoint(x: modeBoxArray[sender.tag].frame.origin.x - safePoint.x, y: 0), animated: true)
    }
    
    @objc func singlePlayerMode() {
        let button1 = ButtonBuild(image: "person", title: "选择人数", piont: CGPointZero, view: modeBoxArray[0])
        button1.center = modeBoxArray[0].center
        ButtonBuild(image: "slider.horizontal.2.square.on.square", title: "选择难度", piont: CGPointZero, view: modeBoxArray[0])
        
    }
    
    @objc func stayTuned() {
        print(#function)
        let alertController = UIAlertController(title: "敬请期待", message: "该功能正在制作中......", preferredStyle: .alert)
        let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        alertController.addAction(knownAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func clickEvents() {
        self.dismiss(animated: true)
    }
    
}
