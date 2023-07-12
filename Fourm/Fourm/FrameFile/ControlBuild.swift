import Foundation
import UIKit

// 视图控制器初始化的方法：传入视图控制器(一般为self)、导航栏标题名
func viewControllerInitialize(vc: UIViewController, navTitle: String) {
    vc.view.backgroundColor = .systemBackground
    vc.navigationItem.title = navTitle
    vc.navigationController?.navigationBar.prefersLargeTitles = true
}

// 创建模块标题的方法：传入父视图、模块标题名、Y轴坐标
// 点击手势还是没有添加到此处，以后修改
func moduleTitleBuild(_ title: String,_ superView: UIView,_ pointY: CGFloat,interaction: Bool) -> UIButton {
    let moduleButton = UIButton(frame: CGRect(x: spacedForScreen, y: pointY, width: screenWidth - spacedForScreen * 2, height: 0))
    
    // 创建标题
    let moduleTitle = UILabel(frame: CGRectZero)
    moduleTitle.text = title
    moduleTitle.font = titleFont2
    moduleTitle.sizeToFit()
    moduleButton.addSubview(moduleTitle)
    
    // 创建箭头
    if interaction {
        let moduleIcon = UIImageView(frame: CGRect(x: moduleTitle.frame.maxX + 5, y: 6, width: 15, height: moduleTitle.frame.size.height - 12))
        moduleIcon.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        moduleIcon.tintColor = UIColor.black.withAlphaComponent(0.5)
        moduleButton.addSubview(moduleIcon)
    }
    
    moduleButton.frame.size.height = moduleTitle.frame.size.height
    superView.addSubview(moduleButton)
    
    return moduleButton
}

let largeControlSize = CGSize(width: 240, height: 320)

/// 创建横向滚动展示控件
///
/// 创建开始学习界面的精选课程模块的
/// - Parameter originY: Y轴坐标
/// - Parameter imageName: 模块控件图片名
/// - Parameter title: 标题名字
/// - Returns: 两个整数的和【返回格式】
/// - Note: 使用时需传入整型数据【批注格式】
func largeControlBuild(origin: CGPoint, imageName: String, title: String, title2: String) -> UIButton {
    // 设置第一个模块的横向滚动视图，用来承载第一个模块“精选合集”
//    let moduleView = UIScrollView(frame: CGRect(x: 0, y: moduleTitle1.frame.maxY + spacedForControl, width: screenWidth, height: largeControlSize.height))
//    moduleView.contentSize = CGSize(width: largeControlSize.width * 7 + spacedForControl * 6 + spacedForScreen * 2, height: largeControlSize.height)
//    moduleView.showsHorizontalScrollIndicator = false
//    moduleView.clipsToBounds = false
//    underlyScrollView.addSubview(moduleView)
//    // 创建7个精选合集框
//    for i in 0 ... 6 {
//        // 配置参数
//        let moduleControlOrigin = CGPoint(x: spacedForScreen + CGFloat(i) * (largeControlSize.width + spacedForControl), y: 0)
//        let featuredCourseBox = largeControlBuild(origin: moduleControlOrigin, imageName: featuredCollectionsRandomDataArray[i]["imageName"]!, title: featuredCollectionsRandomDataArray[i]["title"]!, title2: featuredCollectionsRandomDataArray[i]["author"]!)
//        featuredCourseBox.tag = i
//        featuredCourseBox.addTarget(self, action: #selector(clickCollectionControl), for: .touchUpInside)
//        moduleView.addSubview(featuredCourseBox)
//        let interaction = UIContextMenuInteraction(delegate: self)
//        featuredCourseBox.addInteraction(interaction)
//    }
    
    // 创建控件主体(一个UIButton)
    let control = UIButton(frame: CGRect(origin: origin, size: largeControlSize))
    
    // 裁剪和拼接控件的背景图片
    let image = UIImage(named: imageName)!
    let imageRef = image.cgImage!.cropping(to: CGRect(x: 0, y: image.size.height / 2, width: image.size.width, height: image.size.height / 2))
    let flippedImage = UIImage(cgImage: imageRef!, scale: image.scale, orientation: .downMirrored)
    let imageSize = CGSize(width: image.size.width, height: image.size.height * (largeControlSize.height / largeControlSize.width))
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    image.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: image.size.height))
    flippedImage.draw(in: CGRect(x: 0, y: image.size.height, width: imageSize.width, height: image.size.height / 2))
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
    blurView.frame = CGRect(x: 0, y: largeControlSize.width, width: largeControlSize.width, height: largeControlSize.height - largeControlSize.width)
    blurView.isUserInteractionEnabled = false
    blurView.backgroundColor = .black.withAlphaComponent(0.6)
    control.addSubview(blurView)
    
    // 设置控件的标题
    let largeTitle = UILabel(frame: CGRect(x: spacedForScreen, y: largeControlSize.width + 12, width: 0, height: 0))
    largeTitle.text = title
    largeTitle.textColor = .white
    largeTitle.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
    largeTitle.sizeToFit()
    largeTitle.isUserInteractionEnabled = false
    control.addSubview(largeTitle)
    // 设置控件的副标题(作者名)
    let smallTitle = UILabel(frame: CGRect(x: spacedForScreen, y: largeTitle.frame.maxY + 8, width: 0, height: 0))
    smallTitle.text = title2
    smallTitle.textColor = .white
    smallTitle.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
    smallTitle.sizeToFit()
    smallTitle.isUserInteractionEnabled = false
    control.addSubview(smallTitle)
    // 这两个标题还有一个未解决的隐患：没有考虑标题字数太长的问题
    
    return control
}

// 横向的中号控件：如同学习界面精选课程展示框；一侧放置4:3的长方形封面，另一侧放置简介信息(模糊蒙版)
let mediumControlSize = CGSize(width: screenWidth - spacedForScreen * 2, height: 100)
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
    blurView.frame = CGRect(x: !direction ? 0: mediumControlSize.width / 3, y: 0, width: mediumControlSize.width * 2 / 3, height: mediumControlSize.height + 1)
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

// type: 类型(滚动: custom, 开关: switch, 跳转: forward)
// rowTitle:
// rowHeight: 行高(默认: default, 倍数)
// title
func settingControlBuild(title: String, tips: String, _ superView: UIView, _ pointY: CGFloat, parameter: Array<Dictionary<String, String>>) -> CGFloat {
    // 标题
    let settingModuleTitle = UILabel(frame: CGRect(x: spacedForScreen + 18, y: pointY, width: screenWidth - spacedForScreen * 2, height: 0))
    if !title.isEmpty {
        settingModuleTitle.text = title
        settingModuleTitle.numberOfLines = 0
        settingModuleTitle.font = tipsFont
        settingModuleTitle.sizeToFit()
        settingModuleTitle.frame.size.width = screenWidth - spacedForScreen * 2 - 36
        settingModuleTitle.textColor = UIColor.black.withAlphaComponent(0.6)
        superView.addSubview(settingModuleTitle)
    }
    
    var settingModuleHeight = CGFloat(0)
    for (index, item) in parameter.enumerated() {
        if index != 0 {
            settingModuleHeight += 1
        }
        switch item["rowHeight"] {
        case "default": settingModuleHeight += CGFloat(44)
        case "thrice": settingModuleHeight += CGFloat(44) * 3
        default:
            break
        }
    }
    
    // 设置主体框
    let settingModuleBox = UIView(frame: CGRect(x: spacedForScreen, y: settingModuleTitle.frame.maxY + 6, width: screenWidth - spacedForScreen * 2, height: settingModuleHeight))
    settingModuleBox.backgroundColor = UIColor.systemBackground
    settingModuleBox.layer.cornerRadius = 12
    settingModuleBox.clipsToBounds = true
    superView.addSubview(settingModuleBox)
    
    let settingModuleTips = UILabel(frame: CGRect(x: spacedForScreen + 18, y: settingModuleBox.frame.maxY + 6, width: screenWidth - spacedForScreen * 2, height: 0))
    if !tips.isEmpty {
        settingModuleTips.text = tips
        settingModuleTips.numberOfLines = 0
        settingModuleTips.font = tipsFont
        settingModuleTips.sizeToFit()
        settingModuleTips.frame.size.width = settingModuleBox.frame.width - 36
        settingModuleTips.textColor = UIColor.black.withAlphaComponent(0.6)
        superView.addSubview(settingModuleTips)
    }
    
    for item in parameter {
        switch item["type"] {
        case "custom": break
        case "forward":
            let rowBox = UIButton()
            rowBox.frame.origin = CGPointZero
            rowBox.frame.size = settingModuleBox.frame.size
            settingModuleBox.addSubview(rowBox)
            
            let rowTitle = UILabel()
            rowTitle.frame.origin = CGPoint(x: 18, y: 13)
            rowTitle.text = item["rowTitle"]
            rowTitle.font = basicFont1
            rowTitle.textColor = UIColor.black
            rowTitle.sizeToFit()
            rowBox.addSubview(rowTitle)
            
            let rowIcon = UIImageView(frame: CGRect(x: settingModuleBox.frame.maxX - 45, y: 14, width: 10, height: 16))
            rowIcon.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
            rowIcon.tintColor = UIColor.black.withAlphaComponent(0.5)
            rowBox.addSubview(rowIcon)
        case "switch": break
        default:
            break
        }
    }
    return settingModuleTips.frame.maxY
}

