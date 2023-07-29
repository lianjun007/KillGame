//
import UIKit

/// 视图控制器初始化的方法：传入视图控制器（一般为`self`）、导航栏标题名
struct Initialize {
    enum viewMode {
    case basic, group
    }
    static func view(_ ViewController: UIViewController,_ navigaionTitle: String, mode: Initialize.viewMode) {
        // 设置界面背景色
        switch mode {
        case .basic: ViewController.view.backgroundColor = Color.background()
        default: ViewController.view.backgroundColor = Color.groupBackground()
        }
        // 设置导航栏标题
        ViewController.navigationItem.title = navigaionTitle
        // 开启导航栏大标题
        ViewController.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

/// 创建设置模块的单个控件的结构体
///
/// 单个设置的控件由说明、控件和提示组成，`Setting`依靠下面这个方法来生成设置控件
/// ```swift
/// controlBuild(caption: String, control: Array<controlMode>, tips: String) -> Array<UIView>
/// ```
///
/// - Note: `controlBuild(caption: String, control: Array<controlMode>, tips: String) -> Array<UIView>`有三个重载方法，分别可以省略`caption`、`tips`、`control`和`tips`
struct Setting {
    /// 设置行的类型枚举值
    enum controlMode: Int {
        // 继承Int协议目的是让custom1、custom2、custom3、custom4分别有对应的rawValue来判断高度倍数，切记顺序不可打乱
        /// 自定义设置行，`custom`后的数字对应高度倍数（44pt的倍数）
        case custom, custom1, custom2, custom3, custom4
        case forward, toggle
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter caption: `String`，说明，显示在控件的上方
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    /// - Parameter tips: `String`，提示，显示在控件的下方
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(caption: String, control: Array<controlMode>, tips: String) -> Dictionary<String, UIView> {
        controlBuildCenter(caption, control, tips)
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法（不含提示`tips`）
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter caption: `String`，说明，显示在控件的上方
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(caption: String, control: Array<controlMode>) -> Dictionary<String, UIView> {
        controlBuildCenter(caption, control, "")
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法（不含说明`caption`）
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    /// - Parameter tips: `String`，提示，显示在控件的下方
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(control: Array<controlMode>, tips: String) -> Dictionary<String, UIView> {
        controlBuildCenter("", control, tips)
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法（只有控件主体`control`）
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(control: Array<controlMode>) -> Dictionary<String, UIView> {
        controlBuildCenter("", control, "")
    }
}

// Setting的扩展，扩展内的都是私有属性或方法(或者是不建议外部使用)
extension Setting {
    /// 创建设置模块的单个控件的结构体的枢纽方法
    private static func controlBuildCenter(_ caption: String,_ control: Array<controlMode>,_ tips: String) -> Dictionary<String, UIView> {
        /// 作为返回值的数组（`returnArray`），接收所有返回值
        var returnDictionary: Dictionary<String, UIView> = ["control0": UIView(), "0": UIView()]
        
        /// 设置控件最底层的`UIView`
        let settingControl = UIView()
        settingControl.frame.origin = CGPointZero
        settingControl.frame.size.width = Screen.basicWidth()
        returnDictionary["view"] = settingControl
        
        /// 控件上方的说明（`caption`）部分
        let captionLabel = UILabel().fontAdaptive(caption, font: Font.tips())
        if !caption.isEmpty {
            captionLabel.frame.origin = CGPoint(x: Spaced.screen(), y: 0)
            captionLabel.frame.size.width = Screen.basicWidth() - Spaced.screen() * 2
            captionLabel.textColor = UIColor.black.withAlphaComponent(0.6)
            settingControl.addSubview(captionLabel)
        }
        
        /// 设置控件主体的`UIView`
        let settingTable = UIView()
        settingTable.frame.origin = CGPoint(x: 0, y: caption.isEmpty ? 0: captionLabel.frame.maxY + 6)
        settingTable.frame.size.width = Screen.basicWidth()
        settingTable.backgroundColor = Color.control()
        settingTable.layer.cornerRadius = 12
        settingControl.addSubview(settingTable)

        for (index, item) in control.enumerated() {
            var row = UIView()
            switch item {
            case .forward:
                row = forward() // 跳转界面类型的设置行
                returnDictionary["control\(index + 1)"] = row
            case .toggle:
                row = toggle()[0] // 开关类型的设置行
                let rowSwitch = toggle()[1]
                row.addSubview(rowSwitch)
                returnDictionary["control\(index + 1)"] = rowSwitch
            case .custom: break
            default:
                row = custom(item) // 自定义设置行
                returnDictionary["control\(index + 1)"] = row
            }
            // 配置这些行的通用参数
            row.frame.origin = CGPoint(x: 0, y: returnDictionary["\(index)"]!.frame.maxY)
            row.frame.size.width = Screen.basicWidth()
            settingTable.addSubview(row)
            returnDictionary["\(index + 1)"] = row
            // 每一行的文本内容
            let rowLabel = UILabel()
            rowLabel.frame.origin = CGPoint(x: 18, y: 12)
            rowLabel.text = "默认设置项"
            rowLabel.font = Font.text(.regular)
            rowLabel.textColor = UIColor.black
            rowLabel.sizeToFit()
            rowLabel.frame.size.width = Screen.basicWidth() / 2
            row.addSubview(rowLabel)
            returnDictionary["label\(index + 1)"] = rowLabel
        
            // 创建各个设置行之间的分割线
            if index != 0 {
                // 固定Y轴的值
                let pointY = returnDictionary["\(index)"]!.frame.maxY - 0.25
                // 创建线条的首尾点
                let segmentedLinePath = UIBezierPath()
                segmentedLinePath.move(to: CGPoint(x: 20, y: pointY))
                segmentedLinePath.addLine(to: CGPoint(x: Screen.basicWidth(), y: pointY))
                // 创建线条并且设置相关属性
                let segmentedLine = CAShapeLayer()
                segmentedLine.path = segmentedLinePath.cgPath
                segmentedLine.strokeColor = Color.segmentedLine().cgColor
                segmentedLine.lineWidth = 0.5
                settingTable.layer.addSublayer(segmentedLine)
            }
        }
        
        /// 控件下方的提示（`tips`）部分
        let tipsLabel = UILabel().fontAdaptive(tips, font: Font.tips())
        if !tips.isEmpty {
            tipsLabel.frame.origin = CGPoint(x: Spaced.screen(), y: returnDictionary["\(control.count)"]!.frame.maxY + 6)
            tipsLabel.frame.size.width = Screen.basicWidth() - Spaced.screen() * 2
            tipsLabel.textColor = UIColor.black.withAlphaComponent(0.6)
            settingControl.addSubview(tipsLabel)
        }
        
        // 设置底层和主体视图的height
        settingTable.frame.size.height = returnDictionary["\(control.count)"]!.frame.maxY
        settingControl.frame.size.height = !tips.isEmpty ? tipsLabel.frame.maxY: settingTable.frame.maxY
        
        return returnDictionary
    }
    
    /// 创建设置控件的单行（跳转界面类型）
    private static func forward() -> UIButton {
        /// 设置控件的单行
        let row = UIButton()
        row.frame.size.height = 44
        
        /// 设置控件跳转类型行的跳转箭头图标
        let rowIcon = UIImageView(frame: CGRect(x: Screen.basicWidth() - 25, y: 14, width: 10, height: 16))
        rowIcon.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        rowIcon.tintColor = UIColor.black.withAlphaComponent(0.5)
        row.addSubview(rowIcon)
        
        return row
    }
    /// 创建设置控件的单行（开关类型）
    private static func toggle() -> Array<UIView> {
        /// 设置控件的单行
        let row = UIButton()
        row.frame.size.height = 44
        
        /// 设置控件开关类型行的开关
        let rowSwitch = UISwitch()
        rowSwitch.frame.origin = CGPoint(x: Screen.basicWidth() - 67, y: 6.5)
        
        return [row, rowSwitch]
    }
    private static func custom(_ sender: Setting.controlMode) -> UIView {
        /// 匹配`custom`的原始值来判断高度倍数
        let parameter: CGFloat = CGFloat(sender.rawValue)
        
        /// 设置控件的单行
        let row = UIView()
        row.frame.size.height = 44 * parameter
        
        return row
    }
}



let largeControlSize = CGSize(width: 270, height: 360)
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
//    let moduleView = UIScrollView(frame: CGRect(x: 0, y: moduleTitle1.frame.maxY + Spaced.control(), width: Screen.width(), height: largeControlSize.height))
//    moduleView.contentSize = CGSize(width: largeControlSize.width * 7 + Spaced.control() * 6 + Spaced.screenAuto() * 2, height: largeControlSize.height)
//    moduleView.showsHorizontalScrollIndicator = false
//    moduleView.clipsToBounds = false
//    underlyScrollView.addSubview(moduleView)
//    // 创建7个精选合集框
//    for i in 0 ... 6 {
//        // 配置参数
//        let moduleControlOrigin = CGPoint(x: Spaced.screenAuto() + CGFloat(i) * (largeControlSize.width + Spaced.control()), y: 0)
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
    let largeTitle = UILabel(frame: CGRect(x: Spaced.screen(), y: largeControlSize.width + 12, width: 0, height: 0))
    largeTitle.text = title
    largeTitle.textColor = .white
    largeTitle.font = Font.title2()
    largeTitle.sizeToFit()
    largeTitle.isUserInteractionEnabled = false
    control.addSubview(largeTitle)
    // 设置控件的副标题(作者名)
    let smallTitle = UILabel(frame: CGRect(x: Spaced.screen(), y: largeTitle.frame.maxY + 8, width: 0, height: 0))
    smallTitle.text = title2
    smallTitle.textColor = .white
    smallTitle.font = Font.text()
    smallTitle.sizeToFit()
    smallTitle.isUserInteractionEnabled = false
    control.addSubview(smallTitle)
    // 这两个标题还有一个未解决的隐患：没有考虑标题字数太长的问题
    
    return control
}

// 横向的中号控件：如同学习界面精选课程展示框；一侧放置4:3的长方形封面，另一侧放置简介信息(模糊蒙版)


func mediumControlBuild(origin: CGPoint, imageName: String, title: String, title2: String, direction: Bool) -> UIButton {
    let mediumControlSize = CGSize(width: Screen.basicWidth(), height: 90)
    let mediumControlImageWidth = CGFloat(120)
    // 创建控件主体(一个UIButton)
    let control = UIButton(frame: CGRect(origin: origin, size: mediumControlSize))
    
    // 裁剪和拼接控件的背景图片
    let image = UIImage(named: imageName)!
    let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .upMirrored)
    let imageSize = CGSize(width: Screen.basicWidth(), height: image.size.height / image.size.width * mediumControlImageWidth)
    UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
    image.draw(in: CGRect(x: direction ? 0: Screen.basicWidth() - mediumControlImageWidth, y: 0, width: mediumControlImageWidth, height: imageSize.height))
    flippedImage.draw(in: CGRect(x: direction ? mediumControlImageWidth: 0, y: 0, width: Screen.basicWidth() - mediumControlImageWidth, height: imageSize.height))
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
    blurView.frame = CGRect(x: !direction ? 0: mediumControlImageWidth, y: 0, width: Screen.basicWidth() - mediumControlImageWidth, height: mediumControlSize.height + 1)
    blurView.isUserInteractionEnabled = false
    blurView.backgroundColor = .white.withAlphaComponent(0.4)
    control.addSubview(blurView)

    // 设置控件的标题
    let largeTitle = UILabel(frame: CGRect(x: !direction ? Spaced.screen(): mediumControlImageWidth + Spaced.screen(), y: mediumControlSize.height / 6, width: 0, height: 0))
    largeTitle.text = title
    largeTitle.textColor = .black
    largeTitle.font = Font.title2()
    largeTitle.sizeToFit()
    largeTitle.isUserInteractionEnabled = false
    control.addSubview(largeTitle)
    // 设置控件的副标题(作者名)
    let smallTitle = UILabel(frame: CGRect(x: !direction ? Spaced.screen(): mediumControlImageWidth + Spaced.screen(), y: mediumControlSize.height / 5 * 3, width: 0, height: 0))
    smallTitle.text = title2
    smallTitle.textColor = .black
    smallTitle.font = Font.text()
    smallTitle.sizeToFit()
    smallTitle.isUserInteractionEnabled = false
    control.addSubview(smallTitle)
    // 这两个标题还有一个未解决的隐患：没有考虑标题字数太长的问题
    
    return control
}

// type: 类型(自定义: custom, 开关: switch, 跳转: forward)
// rowTitle:
// rowHeight: 行高(默认: default, 倍数)
// title
func settingControlBuild(title: String, tips: String, _ superView: UIView, _ pointY: CGFloat, parameter: Array<Dictionary<String, String>>) -> CGFloat {
    // 标题
    let settingModuleTitle = UILabel(frame: CGRect(x: Spaced.screenAuto() + 18, y: pointY, width: Screen.basicWidth(), height: 0))
    if !title.isEmpty {
        settingModuleTitle.text = title
        settingModuleTitle.numberOfLines = 0
        settingModuleTitle.font = Font.tips()
        settingModuleTitle.sizeToFit()
        settingModuleTitle.frame.size.width = Screen.basicWidth() - 36
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
    let settingModuleBox = UIView(frame: CGRect(x: Spaced.screenAuto(), y: settingModuleTitle.frame.maxY + 6, width: Screen.basicWidth(), height: settingModuleHeight))
    settingModuleBox.backgroundColor = UIColor.systemBackground
    settingModuleBox.layer.cornerRadius = 12
    settingModuleBox.clipsToBounds = true
    superView.addSubview(settingModuleBox)
    
    let settingModuleTips = UILabel(frame: CGRect(x: Spaced.screenAuto() + 18, y: settingModuleBox.frame.maxY + 6, width: Screen.basicWidth(), height: 0))
    if !tips.isEmpty {
        settingModuleTips.text = tips
        settingModuleTips.numberOfLines = 0
        settingModuleTips.font = Font.tips()
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
            rowTitle.font = Font.text()
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

