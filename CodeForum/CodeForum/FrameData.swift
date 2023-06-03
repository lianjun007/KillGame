//
//  FrameData.swift
//  CodeForum
//
//  Created by QHuiYan on 2023/5/24.
//

import Foundation
import UIKit

// 获取安全插值
let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaInsets = window?.safeAreaInsets ?? UIEdgeInsets.zero

// 屏幕的基础属性
let screenFrame = UIScreen.main.bounds // 屏幕原点和尺寸
let screenWidth: CGFloat = UIScreen.main.bounds.width // 屏幕宽度
let screenHeight: CGFloat = UIScreen.main.bounds.height // 屏幕高度

// 各种间距边距
let spacedForScreen = screenWidth / 22 // 屏幕边距
let spacedForControl = screenWidth / 45 // 控件间距
let spacedForModule = screenHeight / 35 // 导航栏下的模块间距
let spacedForModule2 = screenHeight / 22 // 模块间距
let spacedForModule3 = screenWidth / 30 // 小模块间距

func basicCornerRadius(_ size: CGSize) -> CGFloat {
    if size.width >= size.height {
        return (size.width * 0.04)
    } else {
        return (size.height * 0.04)
    }
} // 标准控件圆角

// 字体大小
let basicFont = screenHeight / 50 // 标准正文字体大小
let titleFont = 34 // 一级标题字体大小
let titleFont2 = CGFloat(28) // 二级标题字体大小
let titleFont3 = 22 // 三级标题字体大小

// 控件尺寸
let largeControl = CGSize(width: screenWidth * 2 / 3, height: screenHeight / 5 * 2)
let mediumControl = CGSize(width: screenWidth - spacedForScreen * 2, height: screenHeight / 8) // tableView的cell的内部显示视图的尺寸

// CourseData数据初始化
func courseData() -> Array<Dictionary<String, String>>  {
    var courseDataArray: Array<Dictionary<String, String>> = []
    if let path = Bundle.main.path(forResource: "CourseData", ofType: "plist") {
        if let array = NSArray(contentsOfFile: path) as? [Dictionary<String, String>] {
            courseDataArray = array
        }
    }
    return courseDataArray
}

// 判断字符串是否超出UILabel的范围
func isTruncated(_ label: UILabel) -> Bool {
    
    let judgmentLabel = UILabel()
    judgmentLabel.text = label.text
    judgmentLabel.font = UIFont.systemFont(ofSize: CGFloat(titleFont3), weight: .bold)
    judgmentLabel.sizeToFit()
    return label.frame.width < judgmentLabel.frame.width
    
}
