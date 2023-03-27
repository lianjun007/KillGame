//
//  SizeFile.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/22.
//

import Foundation
import UIKit

// 框架的基本属性
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let screenSpaced = screenHeight / 20
let controlSpaced = screenSpaced / 2

// 定义safePoint和safeSize
let window = UIApplication.shared.windows.first //
var safeAreaInsets = window?.safeAreaInsets ?? UIEdgeInsets.zero
// 判定显示模式
var displayMode = safeAreaInsets.left >= screenSpaced ? 0: 3

var safePoint = displayMode == 0 ? CGPoint(x: safeAreaInsets.left, y: screenSpaced): CGPoint(x: screenSpaced, y: screenSpaced)
var safeSize = displayMode == 0 ? CGSize(width: screenWidth - (safeAreaInsets.left + safeAreaInsets.right), height: screenHeight - screenSpaced * 2): CGSize(width: screenWidth - screenSpaced * 2, height: screenHeight - screenSpaced * 2)

func safeDataAdaptation() -> (CGSize, CGPoint) {
    // safeAreaInsets = window?.safeAreaInsets ?? safeAreaInsets
    safePoint = CGPoint(x: safeAreaInsets.left, y: screenSpaced)
    safeSize = displayMode == 0 ? CGSize(width: screenWidth - (safeAreaInsets.left + safeAreaInsets.right), height: screenHeight - screenSpaced * 2): CGSize(width: screenWidth - screenSpaced * 2, height: screenWidth - screenSpaced * 2)
    switch displayMode {
    case 0:
        break
    case 1:
        safeSize.width += safeAreaInsets.left
    case 2:
        safeSize.width += safeAreaInsets.left
        safePoint = CGPointZero
    case 3:
        break
    default:
        break
    }
    return (safeSize, safePoint)
}

// 控件标准数据
// Size
let buttonSize = CGSize(width: screenHeight * 3 / 10, height: screenHeight / 10)
let buttonSmallSize = CGSize(width: screenHeight / 10, height: screenHeight / 10)
let roleBoxSize = CGSize(width: (safeSize.width - controlSpaced * 5) / 6, height: (safeSize.width - controlSpaced * 5) / 4)
let roleBoxLargeSize = CGSize(width: (safeSize.height - controlSpaced - buttonSize.height) / 3 * 2, height: safeSize.height - controlSpaced - buttonSize.height)
let roleBoxSmallSize = CGSize(width: (screenWidth - safeAreaInsets.left - safeAreaInsets.right - controlSpaced * 6) / 7, height: (screenWidth - safeAreaInsets.left - safeAreaInsets.right - controlSpaced * 6) * 3 / 14)
let controlRoundSize = screenHeight / 20
// color
let backgroundColor = UIColor.systemGray6
let controlColor = UIColor.systemGray4
let frameColor = UIColor.systemGray
let fontColor = UIColor.black
// Point
let menuBtnPoint = CGPoint(x: safePoint.x + safeSize.width - screenHeight * 3 / 10, y: safePoint.y)
let gameStartBtnPoint = CGPoint(x: safePoint.x + safeSize.width - screenHeight * 3 / 10, y: safePoint.y + safeSize.height - screenHeight / 10)
let roleImagePoint = CGPoint(x: safePoint.x, y: safePoint.y + controlSpaced + screenHeight / 10)
let roleTextPoint = CGPoint(x: safePoint.x + controlSpaced + roleBoxLargeSize.width, y: safePoint.y + controlSpaced + buttonSize.height)

let roleTextSize = CGSize(width: safeSize.width - roleBoxLargeSize.width - controlSpaced, height: safeSize.height - buttonSize.height - controlSpaced)

// Navigation Bar
func navigationBarBuild(view: UIView, direction: Bool, buttonCount num: Int, buttonContent: Array<Array<String>>, bounce: Bool, boxAlpha: Double) -> Array<UIButton> {
    
    let navigationBarBox = UIView(frame: CGRect(origin: CGPointZero, size: CGSize(width: screenWidth, height: safePoint.y + buttonSize.height + controlSpaced / 2)))
    navigationBarBox.backgroundColor = backgroundColor.withAlphaComponent(boxAlpha)
    view.addSubview(navigationBarBox)
    
    // direction为true则在顶部创建一个水平滑动导航栏，为false则在左侧创建一个垂直滑动导航栏
    let navBarSize = direction ? CGSize(width: safeSize.width, height: buttonSize.height): CGSize(width: buttonSize.width, height: safeSize.height)
    let navigationBar = UIScrollView(frame: CGRect(origin: safePoint, size: navBarSize))
    navigationBar.layer.cornerRadius = controlRoundSize
    navigationBar.backgroundColor = UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 0))
    navigationBar.showsVerticalScrollIndicator = false
    navigationBar.showsHorizontalScrollIndicator = false
    navigationBar.contentSize = direction ? CGSize(width: (buttonSize.width + controlSpaced) * CGFloat(num) - controlSpaced, height: navigationBar.frame.height): CGSize(width: navigationBar.frame.width, height: (buttonSize.height + controlSpaced) * CGFloat(num) - controlSpaced)
    view.addSubview(navigationBar)
    
    // 强制界面可以反弹
    if direction {
        navigationBar.alwaysBounceHorizontal = bounce
    } else {
        navigationBar.alwaysBounceVertical = bounce
    }
    
    // 往导航栏内添加按钮，buttonContent的第一个数组包含了图片内容，第二个数组包含了标题内容
    var image = buttonContent[0]
    var title = buttonContent[1]
    var navButtonArray: Array<UIButton> = []
    for i in 0 ..< num {
        
        if num > title.count {
            for _ in 0 ..< num - title.count {
                title.append("敬请期待")
            }
        } else if num > image.count {
            for _ in 0 ..< num - image.count {
                image.append("")
            }
        }
        
        let navButton = ButtonBuild(image: image[i], title: title[i], piont: CGPointZero, view: navigationBar)
        if direction{
            navButton.frame.origin.x += CGFloat(i) * (controlSpaced + buttonSize.width)
        } else {
            navButton.frame.origin.y += CGFloat(i) * (controlSpaced + buttonSize.height)
        }
        navButtonArray.append(navButton)
        
    }
    
    return navButtonArray

}

// Button
func ButtonBuild(image: String, title: String, piont: CGPoint, view: UIView) -> UIButton{
    // 创建一个标准尺寸的按钮，使用之前需要定义一个UIButton
    
    var (image, title) = (image, title)
    if image == "unknown" {
        image = "camera.metering.unknown"
    } else if title.isEmpty {
        title = "敬请期待"
    }
    
    let button = UIButton(frame: CGRect(origin: piont, size: buttonSize))
    button.layer.cornerRadius = controlRoundSize
    button.tintColor = fontColor
    button.setImage(UIImage(systemName: image), for: .normal)
    button.setTitle(title, for: .normal)
    button.backgroundColor = controlColor
    button.setTitleColor(fontColor, for: .normal)
    view.addSubview(button)
    
    return button
    
}

