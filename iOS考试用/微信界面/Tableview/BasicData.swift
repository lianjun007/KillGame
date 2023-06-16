//
//  BasicData.swift
//  Tableview
//
//  Created by QHuiYan on 2023/6/15.
//

import Foundation
import UIKit

var userTips = "您还未登录账号"

// 屏幕的基础属性
let screenWidth = UIScreen.main.bounds.width // 与设备屏幕宽度一样宽
let screenHeight = UIScreen.main.bounds.height // 与设备屏幕高度一样高

// 各种间距边距
let spacedForScreen = screenWidth / 22 // 左右边屏幕的留白边距
let spacedForControl = screenWidth / 45 // 各个相邻的控件之间的间距，也用做二级标题和模块之间的间距
let spacedForModule = CGFloat(45) // 各个模块之间的间距
let spacedForModule2 = CGFloat(25) // 导航栏与第一个模块之间的间距

// 字体大小
let basicFont = CGFloat(17) // 标准正文字体大小
let titleFont = CGFloat(34) // 一级标题字体大小
let titleFont2 = CGFloat(28) // 二级标题字体大小
let titleFont3 = CGFloat(22) // 三级标题字体大小

func userData() -> Dictionary<String, String> {
    var dataDict: Dictionary<String, String> = [:]
    if let path = Bundle.main.path(forResource: "userName", ofType: "plist") {
        if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, String> {
            dataDict = dict
        }
    }
    // 将精选合集数据里面的所有数据全部初始化载入项目
    return dataDict
}


// 创建横向控件：一侧放置4:3的长方形封面，另一侧放置简介信息(模糊蒙版)
let mediumControlSize = CGSize(width: screenWidth - spacedForScreen * 2, height: (screenWidth - spacedForScreen * 2) / 4)
func mediumControlBuild(origin: CGPoint, imageName: String, title: String, title2: String, direction: Bool) -> UIButton {
    // 创建控件主体(一个UIButton)
    let control = UIButton(frame: CGRect(origin: origin, size: mediumControlSize))
    
    // 裁剪和拼接控件的背景图片
    let image = UIImage(named: imageName)!
    let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .upMirrored)
    let imageSize = CGSize(width: image.size.width * 3, height: image.size.height)
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    image.draw(in: CGRect(x: direction ? 0: imageSize.width / 3 * 2, y: 0, width: image.size.width, height: imageSize.height))
    flippedImage.draw(in: CGRect(x: direction ? imageSize.width / 3: 0, y: 0, width: image.size.width * 2, height: imageSize.height))
    let finalImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    // 配置主体控件的基本属性
    control.layer.cornerRadius = 15
    control.setImage(finalImage, for: .normal)
    control.imageView?.contentMode = .scaleAspectFill
    control.layer.masksToBounds = true
    
    // 设置控件底部的高斯模糊
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.frame = CGRect(x: !direction ? 0: mediumControlSize.width / 3, y: 0, width: mediumControlSize.width * 2 / 3, height: mediumControlSize.height)
    blurView.isUserInteractionEnabled = false
    blurView.backgroundColor = .white.withAlphaComponent(0.4)
    control.addSubview(blurView)

    // 设置控件的标题
    let largeTitle = UILabel(frame: CGRect(x: !direction ? spacedForScreen: mediumControlSize.width / 3 + spacedForScreen, y: mediumControlSize.height / 6, width: 0, height: 0))
    largeTitle.text = title
    largeTitle.textColor = .black
    largeTitle.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
    largeTitle.sizeToFit()
    largeTitle.isUserInteractionEnabled = false
    control.addSubview(largeTitle)
    // 设置控件的副标题(作者名)
    let smallTitle = UILabel(frame: CGRect(x: !direction ? spacedForScreen: mediumControlSize.width / 3 + spacedForScreen, y: mediumControlSize.height / 5 * 3, width: 0, height: 0))
    smallTitle.text = title2
    smallTitle.textColor = .black
    smallTitle.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
    smallTitle.sizeToFit()
    smallTitle.isUserInteractionEnabled = false
    control.addSubview(smallTitle)
    // 这两个标题还有一个未解决的隐患：没有考虑标题字数太长的问题
    
    return control
}

