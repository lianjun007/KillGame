import Foundation
import UIKit

// 视图控制器初始化的方法：传入视图控制器(一般为self)、导航栏标题名
func viewControllerInitialize(vc: UIViewController, navTitle: String) {
    vc.view.backgroundColor = .systemBackground
    vc.navigationItem.title = navTitle
    vc.navigationController?.navigationBar.prefersLargeTitles = true
}

// 创建模块标题的方法：传入父视图、模块标题名、Y轴坐标
func moduleTitleBuild(superView: UIView, title: String, originY: CGFloat) -> UILabel {
    let moduleTitle = UILabel(frame: CGRect(x: spacedForScreen, y: originY, width: 0, height: 0))
    moduleTitle.text = title
    moduleTitle.font = titleFont2
    moduleTitle.sizeToFit()
    superView.addSubview(moduleTitle)
    return moduleTitle
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

