// 关于内容结构
// 收藏夹：可以包含任何形式的内容，不限作者
// 合集：可以包含文章，其中的文章必须为自己原创或者他人授权转载，所有的文章作者都需要标注在合集作者内
// 文章：可以转载可以原创，内容较为严谨，用于学习
// 杂谈：内容随意，可以用于提问、讨论、闲聊等用途；类似其他软件的动态功能
// 举报与反馈：类似杂谈模块的格式
// 官方公示：类似文章模块的格式，不过没有封面

// 关于封面
// 合集和头像的封面限制为1:1方形；收藏夹的封面限制为3:2长方形；文章的封面限制为4:3长方形；杂谈类型无封面，图片尺寸随意

import Foundation
import UIKit

let featuredCollectionsDataArray = featuredCollectionsDataInitialize()
let ContentData = contentDataInitialize()
let essayData: Dictionary<String, Dictionary<String, Any>> = ContentData["essay"]!
let collectionData: Dictionary<String, Dictionary<String, Any>> = ContentData["collections"]!


// 获取安全插值
let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaInsets = window?.safeAreaInsets ?? UIEdgeInsets.zero

// 屏幕的基础属性
let screenWidth = UIScreen.main.bounds.width // 与设备屏幕宽度一样宽
let screenHeight = UIScreen.main.bounds.height // 与设备屏幕高度一样高

// 各种间距边距
let spacedForScreen = CGFloat(20)
let spacedForControl = CGFloat(10) // 各个相邻的控件之间的间距，也用做二级标题和模块之间的间距
let spacedForModule = CGFloat(45) // 各个模块之间的间距
let spacedForNavigation = CGFloat(25) // 导航栏与第一个模块之间的间距

// 控件尺寸

let largeControl2Size = CGSize(width: screenWidth - spacedForScreen * 2, height: (screenWidth - spacedForScreen * 2) * 2 / 3) // 收藏界面的收藏夹展示框
let largeControl2Size2 = CGSize(width: screenWidth - spacedForScreen * 2, height: (screenWidth - spacedForScreen * 2) * 2 / 3 + 100) // 收藏界面的收藏夹展示框的大框子，包含标题、数量、简介，暂未启用


// 字体大小
let basicFont = CGFloat(17) // 标准正文字体大小，还有作者名也使用用
let titleFont = CGFloat(34) // 一级标题字体大小，largeTitle那种
let titleFont2 = UIFont.systemFont(ofSize: CGFloat(28), weight: .bold) // 二级标题字体大小，例如每个模块的标题
let titleFont3 = CGFloat(22) // 三级标题字体大小，例如展示文章的一些控件的标题




//
//func basicCornerRadius(_ size: CGSize) -> CGFloat {
//    if size.width >= size.height {
//        return (size.width * 0.04)
//    } else {
//        return (size.height * 0.04)
//    }
//} // 标准控件圆角



//// 判断字符串是否超出UILabel的范围
//func isTruncated(_ label: UILabel) -> Bool {
//    
//    let judgmentLabel = UILabel()
//    judgmentLabel.text = label.text
//    judgmentLabel.font = UIFont.systemFont(ofSize: CGFloat(titleFont3), weight: .bold)
//    judgmentLabel.sizeToFit()
//    return label.frame.width < judgmentLabel.frame.width
//    
//}
//
//func navBar(_ navBar: UINavigationBar) -> CGFloat {
//    navBar.frame.height
//}
