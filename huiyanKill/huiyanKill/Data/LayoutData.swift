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

var safePoint = CGPoint(x: safeAreaInsets.left, y: screenSpaced)
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
let roleBoxSize = CGSize(width: 0, height: 0) // 暂未设置
let roleBoxLargeSize = CGSize(width: (screenHeight - controlSpaced - screenSpaced / 5) / 3 * 2, height: screenHeight - controlSpaced - screenSpaced / 5)
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
let roleTextPoint = CGPoint(x: safePoint.x + controlSpaced + (screenHeight - controlSpaced - screenSpaced / 5) / 3 * 2, y: safePoint.y + screenHeight - controlSpaced - screenSpaced / 5)

let roleTextSize = CGSize(width: safeSize.width - roleBoxLargeSize.width - controlSpaced, height: screenHeight - controlSpaced - screenSpaced / 5)

// Navigation Bar
func navigationBarBuild(view: UIView, direction: Bool, buttonCount num: Int, buttonContent: Array<Array<String>>) -> Array<UIButton> {
    // direction为true则在顶部创建一个水平滑动导航栏，为false则在左侧创建一个垂直滑动导航栏
    
    let navBarSize = direction ? CGSize(width: safeSize.width, height: buttonSize.height): CGSize(width: buttonSize.width, height: safeSize.height)
    let navigationBar = UIScrollView(frame: CGRect(origin: safePoint, size: navBarSize))
    navigationBar.backgroundColor = UIColor(cgColor: CGColor(red: 1, green: 1, blue: 1, alpha: 0))
    navigationBar.showsVerticalScrollIndicator = false
    navigationBar.showsHorizontalScrollIndicator = false
    navigationBar.contentSize = direction ? CGSize(width: (buttonSize.width + controlSpaced) * CGFloat(num) - controlSpaced, height: navigationBar.frame.height): CGSize(width: navigationBar.frame.width, height: (buttonSize.height + controlSpaced) * CGFloat(num) - controlSpaced)
    view.addSubview(navigationBar)
    
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
    button.setImage(UIImage(systemName: image), for: .normal)
    button.setTitle(title, for: .normal)
    button.backgroundColor = controlColor
    button.setTitleColor(fontColor, for: .normal)
    view.addSubview(button)
    
    return button
    
}







// roleChooseButton是角色选择按钮
//let roleChooseButton = UIButton(frame: CGRect(origin: firstButtonPoint, size: buttonSize))
//roleChooseButton.layer.cornerRadius = buttonRadius
//roleChooseButton.tintColor = fontColor
//roleChooseButton.setImage(UIImage(systemName: "person.fill.questionmark.rtl"), for: .normal)
//roleChooseButton.setTitle("角色", for: .normal)
//let fontRoChBtnSize = Int(fontSize) * 2 / (roleChooseButton.titleLabel?.text?.count ?? 2)
//roleChooseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(fontRoChBtnSize))
//roleChooseButton.titleLabel?.adjustsFontSizeToFitWidth = true
//roleChooseButton.setTitleColor(fontColor, for: .normal)
//roleChooseButton.backgroundColor = groundColor
//view.addSubview(roleChooseButton)
//
//// 给roleChooseButton按钮添加菜单
//var roleChooseArray: [UIAction] = []
//for i in 0 ..< roleDate.count {
//    let roleChooseAction = UIAction(title: roleDate[i]?["角色"] ?? "未知", image: UIImage(systemName: "person")) { [self] _ in
//        roleChoose = i
//        roleIsChoose = true
//        roleChooseButton.setTitle("\(roleDate[i]?["角色"] ?? "未知")", for: .normal)
//        roleChooseButton.setImage(UIImage(systemName: "person.fill.checkmark.rtl"), for: .normal)
//        // 改变角色插画显示区域的图片
//        let roleImageName = roleDate[i]?["插画"] ?? ""
//        let roleImage = UIImage(named: roleImageName)
//        roleImageBox.image = roleImage
//        // 改变信息预览区域的文本
//        roleDataLabel[0].text = "角色：\(roleDate[i]?["角色"] ?? "未知")"
//        roleDataLabel[1].text = "生命：\(roleDate[i]?["生命"] ?? "未知")"
//        roleDataLabel[2].text = "体力：\(roleDate[i]?["体力"] ?? "未知")"
//        roleDataLabel[3].text = "攻击：\(roleDate[i]?["攻击"] ?? "未知")"
//        roleDataLabel[4].text = "防御：\(roleDate[i]?["防御"] ?? "未知")"
//    }
//    roleChooseArray.append(roleChooseAction)
//}
//let roleChooseMenu = UIMenu(title: "选择本局游戏你要使用的角色", children: roleChooseArray)
//roleChooseButton.menu = roleChooseMenu
//roleChooseButton.showsMenuAsPrimaryAction = true
//
//// roleCountButton是人数选择按钮
//let roleCountButton = UIButton(frame: CGRect(origin: secondButtonPoint, size: buttonSize))
//roleCountButton.layer.cornerRadius = buttonRadius
//roleCountButton.setImage(UIImage(systemName: "person.fill.checkmark.rtl"), for: .normal)
//roleCountButton.setTitle("设定", for: .normal)
//roleCountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
//roleCountButton.setTitleColor(fontColor, for: .normal)
//roleCountButton.tintColor = fontColor
//roleCountButton.backgroundColor = groundColor
//view.addSubview(roleCountButton)
//
//// 给roleCountButton按钮添加菜单
//var roleCountArray: [UIAction] = []
//for i in 0 ... 6 {
//    let roleCountAction = UIAction(title: "游戏人数：\(i + 2)", image: UIImage(systemName: "person")) { [self] _ in
//        roleIsCount = true
//        roleCount = i + 2
//        // 改变roleCountButton的显示内容
//        roleCountButton.setTitle("人数:\(i + 2)", for: .normal)
//        roleCountButton.backgroundColor = .darkText
//    }
//    roleCountArray.append(roleCountAction)
//}
//let roleCountMenu = UIMenu(title: "选择本局游戏的参与人数", children: roleCountArray)
//roleCountButton.menu = roleCountMenu
//roleCountButton.showsMenuAsPrimaryAction = true






//let rlPrBoxHt = safeSizeAll.height - controlSpaced - btnSizeHt // rolePreviewBox的标准高度
//let btnSizeHt = safeSizeAll.height / 10
//
//let rolePreviewBoxSize = CGSize(width: rlPrBoxHt * 2 / 3, height: rlPrBoxHt) // 角色框大尺寸



