//
//  RoleChooseViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/26.
//

import UIKit

class RoleChooseViewController: UIViewController, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor.withAlphaComponent(1.0)
        
        displayBoxView.delegate = self
        
        // Role Interface 创建滚动视图
        displayBoxView.showsVerticalScrollIndicator = false
        let num = roleData.count % 6 == 0 ? 0: 1
        displayBoxView.contentSize = CGSize(width: safeSize.width, height: CGFloat((safeSize.width - controlSpaced * 5) / 4 + controlSpaced) * CGFloat((roleData.count - roleData.count % 6) / 6 + num) + buttonSize.height + safePoint.y)
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
            
            let modeBox = UIButton(frame: CGRect(origin: displayMode == 0 ? CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced): CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced), size: roleBoxSize))
            
            if i < 12 {
                modeBox.alpha = 0
            }
            
            switch i % 6 {
            case 0: modeBox.frame.origin.x += CGFloat(0) * (controlSpaced + modeBox.frame.width)
            case 1: modeBox.frame.origin.x += CGFloat(1) * (controlSpaced + modeBox.frame.width)
            case 2: modeBox.frame.origin.x += CGFloat(2) * (controlSpaced + modeBox.frame.width)
            case 3: modeBox.frame.origin.x += CGFloat(3) * (controlSpaced + modeBox.frame.width)
            case 4: modeBox.frame.origin.x += CGFloat(4) * (controlSpaced + modeBox.frame.width)
            case 5: modeBox.frame.origin.x += CGFloat(5) * (controlSpaced + modeBox.frame.width)
            default:
                break
            }
            let num = (i - i % 6) / 6
            modeBox.frame.origin.y += CGFloat(modeBox.frame.size.height + controlSpaced) * CGFloat(num)
            
            // modeBox.frame.origin.x += CGFloat(i) * (controlSpaced + modeBox.frame.width)
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
            modeLabel.text = roleData["角色"]
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
            modeBoxArray[i].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
        }
        
        navButtonArray = navigationBarBuild(view: view, direction: true, buttonCount: buttonCount, buttonContent: [["arrowshape.backward", "person"], ["返回首页", "角色选择"]], bounce: false)
        navButtonArray[0].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
        navButtonArray[1].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        
        UIView.animate(withDuration: 0, animations: {
        }, completion: { _ in
            UIView.animate(withDuration: 0.5,delay: 0, options: [], animations: { [self] in
                navButtonArray[0].backgroundColor = buttonColor
                navButtonArray[0].setTitle("取消", for: .normal)
                navButtonArray[1].backgroundColor = buttonColor
                navButtonArray[1].setTitle("选择扩展", for: .normal)
                navButtonArray[1].frame.size.width = safeSize.width - buttonSize.width + controlSpaced
                navButtonArray[1].frame.origin.x = CGFloat(buttonSize.width + controlSpaced)
            }, completion: { _ in
                self.modeBoxArray[0].alpha = 1
            })
        })

        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.navButtonArray[0].frame.size.width = safeSize.width
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.1, animations: {
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.1, animations: {
//                    self.modeBoxArray[0].alpha = 1
//                    self.modeBoxArray[0].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                }, completion: { _ in
//                    UIView.animate(withDuration: 0.1, animations: {
//                        self.modeBoxArray[1].alpha = 1
//                        self.modeBoxArray[1].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                    }, completion: { _ in
//                        UIView.animate(withDuration: 0.1, animations: {
//                            self.modeBoxArray[2].alpha = 1
//                            self.modeBoxArray[2].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                        }, completion: { _ in
//                            UIView.animate(withDuration: 0.1, animations: {
//                                self.modeBoxArray[3].alpha = 1
//                                self.modeBoxArray[3].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                            }, completion: { _ in
//                                UIView.animate(withDuration: 0.1, animations: {
//                                    self.modeBoxArray[4].alpha = 1
//                                    self.modeBoxArray[4].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                }, completion: { _ in
//                                    UIView.animate(withDuration: 0.1, animations: {
//                                        self.modeBoxArray[5].alpha = 1
//                                        self.modeBoxArray[5].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                    }, completion: { _ in
//                                        UIView.animate(withDuration: 0.1, animations: {
//                                            self.modeBoxArray[6].alpha = 1
//                                            self.modeBoxArray[6].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                        }, completion: { _ in
//                                            UIView.animate(withDuration: 0.1, animations: {
//                                                self.modeBoxArray[7].alpha = 1
//                                                self.modeBoxArray[7].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                            }, completion: { _ in
//                                                UIView.animate(withDuration: 0.1, animations: {
//                                                    self.modeBoxArray[8].alpha = 1
//                                                    self.modeBoxArray[8].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                                }, completion: { _ in
//                                                    UIView.animate(withDuration: 0.1, animations: {
//                                                        self.modeBoxArray[9].alpha = 1
//                                                        self.modeBoxArray[9].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                                    }, completion: { _ in
//                                                        UIView.animate(withDuration: 0.1, animations: {
//                                                            self.modeBoxArray[10].alpha = 1
//                                                            self.modeBoxArray[10].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                                        }, completion: { _ in
//                                                            UIView.animate(withDuration: 0.1, animations: {
//                                                                self.modeBoxArray[11].alpha = 1
//                                                                self.modeBoxArray[11].transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//                                                            }, completion: { _ in
//
//                                                            })
//                                                        })
//                                                    })
//                                                })
//                                            })
//                                        })
//                                    })
//                                })
//                            })
//                        })
//                    })
//                })
//            })
//        })
    }
    
    let displayBoxView = UIScrollView(frame: CGRect(origin: CGPoint(x: safePoint.x, y: 0), size: CGSize(width: safeSize.width, height: screenHeight)))
    var modeBoxArray: Array<UIButton> = []
    
    @objc func clickEvents(sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @objc func stayTuned() {
        print(#function)
        let alertController = UIAlertController(title: "敬请期待", message: "正在制作中......", preferredStyle: .alert)
        let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        alertController.addAction(knownAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var navButtonArray: Array<UIButton> = []
    let buttonCount = 2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取UIScrollView的偏移量
        let offsetY = displayBoxView.contentOffset.y
        let alpha = (offsetY - (controlSpaced)) / navButtonArray[1].frame.height
        if offsetY >= controlSpaced {
            for i in 0 ... buttonCount {
                navButtonArray[i].alpha = 1 - alpha / 2
            }
        } else if navButtonArray[buttonCount].alpha == 0 {
            navButtonArray[buttonCount].isUserInteractionEnabled = false
            navigationBar.isUserInteractionEnabled = false
        } else {
            for i in 0 ... buttonCount {
                navButtonArray[i].alpha = 1
                navButtonArray[i].isUserInteractionEnabled = true
                navigationBar.isUserInteractionEnabled = true
            }
        }
    }
    
}
