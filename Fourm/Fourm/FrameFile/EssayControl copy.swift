import Foundation
import UIKit

//let url = URL(string: "https://www.baidu.com")!
//let task = URLSession.shared.dataTask(with: url) { data, response, error in
//    guard let data = data,
//          let string = String(data: data, encoding: .utf8) else {
//        return
//    }
//}

func essayInterfaceBuild0(_ essayData: String, _ VC: UIViewController) {
    let essayDataArray = essayData.components(separatedBy: "\n")
    // 设置最底层的滚动视图，用来承载界面内的所有元素
    let underlyScrollView = UIScrollView(frame: VC.view.bounds)
    underlyScrollView.alwaysBounceVertical = true
    VC.view.addSubview(underlyScrollView)
    
    var pointY = CGFloat(0)
    var control = false
    var text = false
    var paragraph = false
    var textArray: Array<String> = []
    var code = false
    var codeType = ""
    var codeArray: Array<String> = []
    var table = false
    var tableType = ""
    var tableArray: Array<String> = []
    var title = false
    var author = false
    for item in essayDataArray {
        if item.hasPrefix("@title "), !title {
            title = true
            VC.navigationItem.title = stringHandling(item)
        } else if item.hasPrefix("@author "), !author {
            author = true
            pointY = authorModuleBuild(stringHandling(item), underlyScrollView)
            let horizontalLinePath = UIBezierPath()
            let pointY = spacedForModule + spacedForControl / 2
            horizontalLinePath.move(to: CGPoint(x: 0, y: pointY))
            horizontalLinePath.addLine(to: CGPoint(x: screenWidth, y: pointY))
            let horizontalLine = CAShapeLayer()
            horizontalLine.path = horizontalLinePath.cgPath
            horizontalLine.strokeColor = settingEssayTitle2DisplayMode == 2 ? UIColor.systemIndigo.withAlphaComponent(0.2).cgColor: UIColor.black.withAlphaComponent(0.2).cgColor
            horizontalLine.lineWidth = 1
            underlyScrollView.layer.addSublayer(horizontalLine)
        }
    }
    if !title {
        VC.navigationItem.title = "未设置标题"
    }
    if !author {
        pointY = authorModuleBuild("未知", underlyScrollView)
        let horizontalLinePath = UIBezierPath()
        let pointY = spacedForModule + spacedForControl / 2
        horizontalLinePath.move(to: CGPoint(x: 0, y: pointY))
        horizontalLinePath.addLine(to: CGPoint(x: screenWidth, y: pointY))
        let horizontalLine = CAShapeLayer()
        horizontalLine.path = horizontalLinePath.cgPath
        horizontalLine.strokeColor = settingEssayTitle2DisplayMode == 2 ? UIColor.systemIndigo.withAlphaComponent(0.3).cgColor: UIColor.black.withAlphaComponent(0.5).cgColor
        horizontalLine.lineWidth = 1
        underlyScrollView.layer.addSublayer(horizontalLine)
    }
    pointY += spacedForControl * 3
    for item in essayDataArray {
        text = false
        if item.hasPrefix("# ") {
            pointY = title2ModuleBuild(stringHandling(item), underlyScrollView, originY: control ? pointY: spacedForControl * 2)
            control = true
        } else if item.hasPrefix("## ") {
            control = true
            pointY = title3ModuleBuild(stringHandling(item), underlyScrollView, originY: pointY)
        } else if item.hasPrefix("### ") {
            control = true
            pointY = title4ModuleBuild(stringHandling(item), underlyScrollView, originY: pointY)
        } else if item.hasPrefix("#img ") {
            control = true
            pointY = imageModuleBuild(stringHandling(item), underlyScrollView, originY: pointY)
        } else if item.hasPrefix("#p") {
            control = true
            textArray = []
            paragraph = true
        } else if item.hasPrefix("##p") {
            paragraph = false
            for i in 0 ..< textArray.count {
                if i == 1 {
                    pointY = textModuleBuild(textArray[i], underlyScrollView, originY: pointY, spaced: true)
                } else if i != 0 {
                    pointY = textModuleBuild(textArray[i], underlyScrollView, originY: pointY, spaced: false)
                }
            }
        } else if item.hasPrefix("#code") {
            control = true
            codeArray = []
            code = true
            codeType = stringHandling(item)
        } else if item.hasPrefix("##code") {
            code = false
            pointY = codeModuleBuild(Array(codeArray.dropFirst()), underlyScrollView, pointY, language: codeType)

        } else if item.hasPrefix("#tb") {
            control = true
            tableArray = []
            table = true
            tableType = stringHandling(item)
        } else if item.hasPrefix("##tb") {
            table = false
            pointY = tableModuleBuild(Array(tableArray.dropFirst()), underlyScrollView, originY: pointY, mode: tableType)
        } else {
            // 还有一个屏蔽前几行空行的字符没做
            if !item.isEmpty, !item.hasPrefix("@title"), !item.hasPrefix("@author") {
                control = true
                text = true
            }
        }
        
        if code {
            codeArray.append(item)
        } else if table {
            tableArray.append(item)
        } else if paragraph {
            textArray.append(item)
        } else if text {
            pointY = textModuleBuild(item, underlyScrollView, originY: pointY, spaced: true)
        }
        
        
    }
    underlyScrollView.contentSize = CGSize(width: screenWidth, height: pointY + spacedForControl)
}

/// 处理文章内容的字符串
///
/// 输入一个包含识别码的原字符串返回一个去掉识别码的内容字符串
/// - Parameter string: 需要处理的包含识别码的原字符串
/// - Returns: 去掉识别码后的内容字符串
/// - Note: 返回的内容字符串将被去掉识别码和识别码后的所有空格，但是从第一个有效字符开始后的空格不受影响。
func stringHandling(_ string: String) -> String {
    var index0 = 0
    if string.hasPrefix("> ") || string.hasPrefix("< ") || string.hasPrefix("<> ") || string.hasPrefix(">< ") || string.hasPrefix("#left ") || string.hasPrefix("right ") || string.hasPrefix("#center ") || string.hasPrefix("# ") || string.hasPrefix("## ") || string.hasPrefix("# ") || string.hasPrefix("### ") || string.hasPrefix("#img ") || string.hasPrefix("@title ") || string.hasPrefix("@author ") || string.hasPrefix("#tb ") || string.hasPrefix("##tb ") || string.hasPrefix("#code ") || string.hasPrefix("##code ") || string.hasPrefix("#p ") || string.hasPrefix("##p ") {
        
        var index1 = 0
        var bool0 = false
        var bool1 = true
        for i in string {
            index1 += 1
            if i == " ", bool1 {
                bool0 = true
                bool1 = false
            }
            if i != " " || index1 == string.count, bool0 {
                bool0 = false
                index0 = index1 - 1
            }
        }
    }
    let newString = string.dropFirst(index0)
    return String(newString)
}

/// 创建作者名显示模块
///
/// 输入作者名和底层视图后将自动创建一个显示作者名的视图
/// - Parameter string: 作者名
/// - Parameter view: 底层视图
func authorModuleBuild(_ string: String, _ view: UIView) -> CGFloat {
    let authorHeader = UILabel()
    authorHeader.frame.size.width = screenWidth - spacedForScreen * 2
    authorHeader.text = "作者："
    authorHeader.font = UIFont.systemFont(ofSize: basicFont, weight: .bold)
    authorHeader.sizeToFit()
    authorHeader.frame.origin = CGPoint(x: spacedForScreen, y: spacedForControl - 2)
    authorHeader.layer.cornerRadius = 5
    view.addSubview(authorHeader)
    
    let author = UILabel()
    author.frame.size.width = screenWidth - spacedForScreen * 2
    author.text = string
    author.font = UIFont.systemFont(ofSize: basicFont, weight: .medium)
    author.sizeToFit()
    author.frame.origin = CGPoint(x: authorHeader.frame.maxX, y: spacedForControl - 2)
    author.layer.cornerRadius = 5
    author.frame.size.width += 7
    author.clipsToBounds = true
    author.textAlignment = .center
    author.backgroundColor = UIColor.systemFill
    view.addSubview(author)
    
    switch settingEssayTitle2DisplayMode {
    case 1:
        authorHeader.text = ""
        author.text = "作者：\(string)"
        author.sizeToFit()
        author.frame.origin.x = spacedForScreen
        author.frame.size.width += 7
        author.textAlignment = .center
        author.backgroundColor = UIColor.systemGroupedBackground
        author.layer.borderWidth = 1
        author.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    case 2:
        authorHeader.frame.origin.x += 10
        author.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.2)
        author.frame.origin.x = authorHeader.frame.maxX
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: spacedForScreen + 3, y: author.frame.minY + 1))
        path.addLine(to: CGPoint(x: spacedForScreen + 3, y: author.frame.maxY - 1))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.7).cgColor
        shapeLayer.lineWidth = 5.0
        view.layer.addSublayer(shapeLayer)
    default:
        break
    }
    return authorHeader.frame.maxY
}

/// 创建二级标题显示模块
///
/// 输入二级标题内容和底层视图后将自动创建一个显示二级标题的视图
/// - Parameter string: 二级标题内容
/// - Parameter view: 底层视图
/// - Parameter originY: 二级标题的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func title2ModuleBuild(_ string: String, _ view: UIView, originY: CGFloat) -> CGFloat {
    var newOriginY = originY
    let title2 = UILabel()
    title2.frame.size.width = screenWidth - spacedForScreen * 2
    title2.text = string
    title2.numberOfLines = 0
    title2.font = titleFont2
    title2.sizeToFit()
    title2.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForModule)
    view.addSubview(title2)
    newOriginY = title2.frame.maxY
    
    switch settingEssayTitle2DisplayMode {
    case 1:
        let path = UIBezierPath()
        path.move(to: CGPoint(x: spacedForScreen, y: title2.frame.maxY + 3))
        path.addLine(to: CGPoint(x: screenWidth - spacedForScreen, y: title2.frame.maxY + 3))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.5).cgColor
        shapeLayer.lineWidth = 1.0
        view.layer.addSublayer(shapeLayer)
        newOriginY += 5
    case 2:
        let path = UIBezierPath()
        path.move(to: CGPoint(x: spacedForScreen, y: title2.frame.maxY - 3))
        path.addLine(to: CGPoint(x: title2.frame.maxX, y: title2.frame.maxY - 3))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.5).cgColor
        shapeLayer.lineWidth = 9.0
        view.layer.addSublayer(shapeLayer)
        newOriginY += 6
    default:
        break
    }
    return newOriginY
}

/// 创建三级标题显示模块
///
/// 输入三级标题内容和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter string: 三级标题内容
/// - Parameter view: 底层视图
/// - Parameter originY: 三级标题的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func title3ModuleBuild(_ string: String, _ view: UIView, originY: CGFloat) -> CGFloat {
    var newOriginY = originY
    let title3 = UILabel()
    title3.frame.size.width = screenWidth - spacedForScreen * 2
    title3.text = "· \(string)"
    title3.font = UIFont.systemFont(ofSize: titleFont3, weight: .medium)
    title3.sizeToFit()
    title3.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForNavigation)
    view.addSubview(title3)
    
    newOriginY = title3.frame.maxY
    
    switch settingEssayTitle2DisplayMode {
    case 1:
        title3.text = "- \(string)"
        title3.sizeToFit()
    case 2:
        title3.text = "\(string)"
        title3.sizeToFit()
        title3.frame.origin.x += 13
        let path = UIBezierPath()
        path.move(to: CGPoint(x: spacedForScreen + 5, y: title3.frame.minY + 3))
        path.addLine(to: CGPoint(x: spacedForScreen + 5, y: title3.frame.maxY - 3))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.4).cgColor
        shapeLayer.lineWidth = 5.0
        view.layer.addSublayer(shapeLayer)
    default:
        break
    }
    return newOriginY
}

/// 创建四级标题显示模块
///
/// 输入三级标题内容和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter string: 三级标题内容
/// - Parameter view: 底层视图
/// - Parameter originY: 三级标题的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func title4ModuleBuild(_ string: String, _ view: UIView, originY: CGFloat) -> CGFloat {
    let title4 = UILabel()
    title4.frame.size.width = screenWidth - spacedForScreen * 2
    title4.text = string
    title4.font = UIFont.systemFont(ofSize: titleFont3 - 3, weight: .medium)
    title4.textColor = UIColor.black.withAlphaComponent(0.8)
    title4.sizeToFit()
    title4.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForNavigation)
    view.addSubview(title4)
    return title4.frame.maxY
}

/// 创建代码块显示模块
///
/// 输入代码数组和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter stringArray: 代码块内容的数组
/// - Parameter superView: 底层视图
/// - Parameter pointY: 代码块的Y轴坐标
/// - Parameter codeLanguage: 代码语言
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func codeModuleBuild(_ stringArray: Array<String>, _ superView: UIView,_ pointY: CGFloat, language codeLanguage: String) -> CGFloat {
    // 对空行进行处理
    var codeStringArray = stringArray
    for (index, element) in codeStringArray.enumerated() {
        if element.isEmpty {
            codeStringArray[index] = "    "
        }
    }
    
    // 创建底层的代码框的UIScrollView
    let codeScrollBox = UIScrollView(frame: CGRect(x: spacedForScreen, y: pointY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 0))
    superView.addSubview(codeScrollBox)
    
    // 创建代码行序号的容器和对应的高斯模糊
    let rowNumberBox = UIView()
    let blurEffect = UIBlurEffect(style: .light)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.isUserInteractionEnabled = false
    rowNumberBox.addSubview(blurView)
    superView.addSubview(rowNumberBox)
    
    // 处理代码行和行序号
    var rowArray: Array<UILabel> = []
    var codeRowMaxX = CGFloat(0) // 接收所有代码行的最大X轴坐标的属性
    let rowSpacing = CGFloat(4) // 代码行之间的间距属性
    for i in 0 ..< codeStringArray.count {
        // 代码行部分
        let codeRow = UILabel()
        codeRow.frame.origin.y = i == 0 ? 10: rowArray[(i - 1) * 2].frame.maxY + rowSpacing
        var newCodeString = NSMutableAttributedString(string: codeStringArray[i])
        switch codeLanguage {
        case "Swift": newCodeString = swiftCodeOptimize(attString: newCodeString)
        case "HTML": newCodeString = htmlCodeOptimize(attString: newCodeString)
        default:
            break
        }
        codeRow.attributedText = newCodeString
        codeRow.font = codeFont
        codeRow.sizeToFit()
        if codeRow.frame.maxX > codeRowMaxX {
            codeRowMaxX = codeRow.frame.maxX
        } // 传出代码行的最大X轴坐标
        rowArray.append(codeRow)
        codeScrollBox.addSubview(codeRow)
        
        // 代码行的序号部分
        let rowNumber = UILabel()
        rowNumber.frame.origin = CGPoint(x: codeScrollBox.frame.origin.x, y: i == 0 ? 10 + codeScrollBox.frame.origin.y: codeRow.frame.origin.y + codeScrollBox.frame.origin.y)
        rowNumber.font = codeFont
        rowArray.append(rowNumber)
        superView.addSubview(rowNumber)
    }
    
    // 获取代码行数的位数
    var rowNumberDigits: Int?
    switch rowArray.count / 2 {
    case 0 ..< 10: rowNumberDigits = 0
    case 10 ..< 100: rowNumberDigits = 1
    case 100 ..< 1000: rowNumberDigits = 2
    case 1000 ..< Int.max: rowNumberDigits = 3
    default:
        break
    }
    // 代码行序号容器的宽度
    var rowNumberBoxWidth: CGFloat!
    switch rowNumberDigits {
    case 0: rowNumberBoxWidth = 24
    case 1: rowNumberBoxWidth = 32
    case 2: rowNumberBoxWidth = 40
    case 3: rowNumberBoxWidth = 40
    default:
        break
    }
    
    // 设置代码(滚动)块的基础参数
    codeScrollBox.frame.size.height = rowArray[(codeStringArray.count - 1) * 2].frame.maxY + 10
    codeScrollBox.contentSize.height = rowArray[(codeStringArray.count - 1) * 2].frame.maxY + 10
    codeScrollBox.layer.cornerRadius = 4
    codeScrollBox.alwaysBounceHorizontal = true
    
    // 主题相关样式的参数设置
    switch settingEssayTitle2DisplayMode {
    case 0:
        // 设置代码行和序号的样式
        for (index, element) in rowArray.enumerated() {
            let rowNumber = (index - 1) / 2 + 1 // 代码行的序号的具体数字
            if index % 2 == 0 {
                // 代码行部分
                element.frame.origin.x = rowNumberBoxWidth + 10
            } else {
                // 代码行的序号部分
                switch rowNumberDigits {
                case 0: element.text = "\(rowNumber)."
                case 1: element.text = rowNumber < 10 ? "0\(rowNumber).": "\(rowNumber)."
                case 2:
                    switch rowNumber {
                    case 0 ..< 10: element.text = "00\(rowNumber)."
                    case 10 ..< 100: element.text = "0\(rowNumber)."
                    case 100 ..< 1000: element.text = "\(rowNumber)."
                    default:
                        break
                    }
                case 3:
                    switch rowNumber {
                    case 0 ..< 10: element.text = "00\(rowNumber)."
                    case 10 ..< 100: element.text = "0\(rowNumber)."
                    case 100 ..< 1000: element.text = "\(rowNumber)."
                    case 1000 ..< Int.max: element.text = "…\(String(rowNumber).suffix(2))"
                    default:
                        break
                    }
                default:
                    break
                }
                element.textColor = UIColor(red: 127/255.0, green: 125/255.0, blue: 159/255.0, alpha: 1.000)
                element.sizeToFit()
                element.textAlignment = .right
                element.frame.size.width = rowNumberBoxWidth + 5
            }
        }
        
        // 设置代码(滚动)块的样式
        codeScrollBox.backgroundColor = UIColor.systemFill
        codeScrollBox.contentSize.width = codeRowMaxX + rowNumberBoxWidth + 15
        
        // 代码行序号容器的样式
        rowNumberBox.frame = CGRect(x: codeScrollBox.frame.origin.x, y: codeScrollBox.frame.origin.y, width: rowNumberBoxWidth + 5, height: codeScrollBox.frame.height)
        let path = UIBezierPath(roundedRect: rowNumberBox.bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 4, height: 4))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        rowNumberBox.layer.mask = shapeLayer
        blurView.frame = CGRect(origin: CGPointZero, size: rowNumberBox.frame.size)
        rowNumberBox.backgroundColor = UIColor.white.withAlphaComponent(0)
        rowNumberBox.layer.masksToBounds = true
    case 1:
        // 设置代码行和序号的样式
        for (index, element) in rowArray.enumerated() {
            let rowNumber = (index - 1) / 2 + 1 // 代码行的序号的具体数字
            if index % 2 == 0 {
                // 代码行部分
                element.frame.origin.x = rowNumberBoxWidth + 5
            } else {
                // 代码行的序号部分
                element.frame.origin.x += 0
                switch rowNumberDigits {
                case 0: element.text = "\(rowNumber)"
                case 1: element.text = rowNumber < 10 ? "0\(rowNumber)": "\(rowNumber)"
                case 2:
                    switch rowNumber {
                    case 0 ..< 10: element.text = "00\(rowNumber)"
                    case 10 ..< 100: element.text = "0\(rowNumber)"
                    case 100 ..< 1000: element.text = "\(rowNumber)"
                    default:
                        break
                    }
                case 3:
                    switch rowNumber {
                    case 0 ..< 10: element.text = "00\(rowNumber)"
                    case 10 ..< 100: element.text = "0\(rowNumber)"
                    case 100 ..< 1000: element.text = "\(rowNumber)"
                    case 1000 ..< Int.max: element.text = "…\(String(rowNumber).suffix(2))"
                    default:
                        break
                    }
                default:
                    break
                }
                element.textColor = UIColor(red: 127/255.0, green: 125/255.0, blue: 159/255.0, alpha: 1.000)
                element.sizeToFit()
                element.textAlignment = .center
                element.frame.size.width = rowNumberBoxWidth
            }
        }
        
        // 设置代码(滚动)块的样式
        codeScrollBox.backgroundColor = UIColor(red: 242/255.0, green: 242/255.0, blue: 247/255.0, alpha: 1.000)
        codeScrollBox.layer.borderWidth = 1
        codeScrollBox.layer.borderColor = UIColor(red: 138/255.0, green: 138/255.0, blue: 141/255.0, alpha: 1.000).cgColor
        codeScrollBox.contentSize.width = codeRowMaxX + rowNumberBoxWidth + 10
        
        // 代码行序号容器的样式
        rowNumberBox.frame = CGRect(x: codeScrollBox.frame.origin.x + 1, y: codeScrollBox.frame.origin.y + 1, width: rowNumberBoxWidth - 0.5, height: codeScrollBox.frame.height - 2)
        let path = UIBezierPath(roundedRect: rowNumberBox.bounds,
                                byRoundingCorners: [.topLeft, .bottomLeft],
                                cornerRadii: CGSize(width: 4, height: 4))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        rowNumberBox.layer.mask = shapeLayer
        blurView.frame = CGRect(origin: CGPointZero, size: rowNumberBox.frame.size)
        rowNumberBox.backgroundColor = UIColor.white.withAlphaComponent(0)
        rowNumberBox.layer.masksToBounds = true
        
        // 线条主题代码块中序号的分割竖线
        let verticalLinePath = UIBezierPath()
        let anchor = rowNumberBoxWidth + codeScrollBox.frame.origin.x
        verticalLinePath.move(to: CGPoint(x: anchor, y: codeScrollBox.frame.origin.y))
        verticalLinePath.addLine(to: CGPoint(x: anchor, y: codeScrollBox.frame.maxY))
        let verticalLine = CAShapeLayer()
        verticalLine.path = verticalLinePath.cgPath
        verticalLine.lineWidth = 0.5
        verticalLine.strokeColor = UIColor.black.withAlphaComponent(0.5).cgColor
        superView.layer.addSublayer(verticalLine)
    case 2:
        // 设置代码行和序号的样式
        for (index, element) in rowArray.enumerated() {
            let rowNumber = (index - 1) / 2 + 1 // 代码行的序号的具体数字
            if index % 2 == 0 {
                // 代码行部分
                element.frame.origin.x = rowNumberBoxWidth + 12
            } else {
                // 代码行的序号部分
                element.frame.origin.x += 7
                switch rowNumberDigits {
                case 0: element.text = "\(rowNumber)"
                case 1: element.text = rowNumber < 10 ? "0\(rowNumber)": "\(rowNumber)"
                case 2:
                    switch rowNumber {
                    case 0 ..< 10: element.text = "00\(rowNumber)"
                    case 10 ..< 100: element.text = "0\(rowNumber)"
                    case 100 ..< 1000: element.text = "\(rowNumber)"
                    default:
                        break
                    }
                case 3:
                    switch rowNumber {
                    case 0 ..< 10: element.text = "00\(rowNumber)"
                    case 10 ..< 100: element.text = "0\(rowNumber)"
                    case 100 ..< 1000: element.text = "\(rowNumber)"
                    case 1000 ..< Int.max: element.text = "…\(String(rowNumber).suffix(2))"
                    default:
                        break
                    }
                default:
                    break
                }
                element.textColor = UIColor(red: 127/255.0, green: 125/255.0, blue: 159/255.0, alpha: 1.000)
                element.sizeToFit()
                element.textAlignment = .center
                element.frame.size.width = rowNumberBoxWidth
            }
        }
        
        // 设置代码(滚动)块的样式
        codeScrollBox.backgroundColor = UIColor(red: 222/255.0, green: 221/255.0, blue: 247/255.0, alpha: 1.000)
        codeScrollBox.contentSize.width = codeRowMaxX + rowNumberBoxWidth + 17
        
        // 代码行序号容器的样式
        rowNumberBox.frame = CGRect(x: 7 + codeScrollBox.frame.origin.x, y: 6 + codeScrollBox.frame.origin.y, width: rowNumberBoxWidth, height: codeScrollBox.frame.height - 12)
        blurView.frame = CGRect(origin: CGPointZero, size: rowNumberBox.frame.size)
        rowNumberBox.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.25)
        rowNumberBox.layer.cornerRadius = 5
        rowNumberBox.layer.masksToBounds = true
    default:
        break
    }
    
    return codeScrollBox.frame.maxY
}

func swiftCodeOptimize(attString: NSMutableAttributedString) -> NSMutableAttributedString {
    if attString.string.count >= 5 {
        for index in 0 ..< attString.string.count - 4 {
            let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
            let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
            let strIndex3 = attString.string.index(attString.string.startIndex, offsetBy: index + 2)
            let strIndex4 = attString.string.index(attString.string.startIndex, offsetBy: index + 3)
            let strIndex5 = attString.string.index(attString.string.startIndex, offsetBy: index + 4)
            if index % 4 == 0, attString.string[strIndex] == "p", attString.string[strIndex2] == "r", attString.string[strIndex3] == "i", index == 0, attString.string[strIndex4] == "n", attString.string[strIndex5] == "t" {
                attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 5))
            } else if index % 4 == 0, attString.string[strIndex] == "g", attString.string[strIndex2] == "u", attString.string[strIndex3] == "a", index == 0, attString.string[strIndex4] == "r", attString.string[strIndex5] == "d" {
                attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 5))
            }
        }
    }
    if attString.string.count >= 4 {
        for index in 0 ..< attString.string.count - 3 {
            let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
            let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
            let strIndex3 = attString.string.index(attString.string.startIndex, offsetBy: index + 2)
            let strIndex4 = attString.string.index(attString.string.startIndex, offsetBy: index + 3)
            if attString.string[strIndex] == "f", attString.string[strIndex2] == "u", attString.string[strIndex3] == "n", index == 0, attString.string[strIndex4] == "c" {
                attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 4))
            }
        }
    }
    if attString.string.count >= 3 {
        for index in 0 ..< attString.string.count - 2 {
            let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
            let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
            let strIndex3 = attString.string.index(attString.string.startIndex, offsetBy: index + 2)
            if index == 0, attString.string[strIndex] == "v", attString.string[strIndex2] == "a", attString.string[strIndex3] == "r" {
                attString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: index, length: 3))
            } else if index == 0, attString.string[strIndex] == "l", attString.string[strIndex2] == "e", attString.string[strIndex3] == "t" {
                attString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: index, length: 3))
            }
        }
    }
    if attString.string.count >= 2 {
        for index in 0 ..< attString.string.count - 1 {
            let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
            let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
            if attString.string[strIndex] == "i", attString.string[strIndex2] == "f" {
                attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 2))
            } else if attString.string[strIndex] == "/", attString.string[strIndex2] == "/" {
                attString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1764705882, green: 0.5215686275, blue: 0.01568627451, alpha: 1), range: NSRange(location: index, length: attString.string.count - index))
            }
        }
    }
    return attString
}

func htmlCodeOptimize(attString: NSMutableAttributedString) -> NSMutableAttributedString {
    attString
}

/// 创建文本显示模块
///
/// 输入代码数组和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter stringArray: 代码块内容的数组
/// - Parameter view: 底层视图
/// - Parameter originY: 代码块的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func textModuleBuild(_ string: String, _ view: UIView, originY: CGFloat, spaced: Bool) -> CGFloat {
    let text = UILabel()
    text.frame.size.width = screenWidth - spacedForScreen * 2
    text.text = string
    text.numberOfLines = 0
    text.font = UIFont.systemFont(ofSize: basicFont)
    text.sizeToFit()
    text.frame.origin = CGPoint(x: spacedForScreen, y: originY + (spaced ? spacedForControl: 0))
    view.addSubview(text)
    return text.frame.maxY
}

/// 创建图片显示模块
///
/// 输入代码数组和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter imageName: 代码块内容的数组
/// - Parameter view: 底层视图
/// - Parameter originY: 代码块的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func imageModuleBuild(_ imageName: String, _ view: UIView, originY: CGFloat) -> CGFloat {
    let imageView = UIImageView()
    imageView.image = UIImage(named: imageName)
    imageView.contentMode = .scaleAspectFit
    imageView.sizeToFit()
    let proportion = imageView.frame.size.height / imageView.frame.size.width
    imageView.frame.size.width = screenWidth - spacedForScreen * 2
    imageView.frame.size.height = imageView.frame.size.width * proportion
    imageView.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl)
    view.addSubview(imageView)
    return imageView.frame.maxY
}

/// 创建表格显示模块
///
/// 输入代码数组和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter stringArray: 代码块内容的数组
/// - Parameter view: 底层视图
/// - Parameter originY: 代码块的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func tableModuleBuild(_ array: Array<String>, _ view: UIView, originY: CGFloat, mode: String) -> CGFloat {
    var lineWidth = CGFloat(1.0) // 表格中的分割线宽度
    var boardWidth = CGFloat(1.5) // 表格的边框宽度
    var rowHeight = CGFloat(30)
    /* 一些问题：
     1、设置lineWidth为0.5时label不知道为什么会有一条上边框，百思不得其解
     2、设置lineWidth和boardWidth为10时不知道为什么需要向左偏移1才能对齐(适配2)
     3、设置lineWidth为1.0和boardWidth设置为1.5时label不知道为什么尺寸会不对，在检查器中查看坐标都没问题，按理说不会有遮挡，应该是小数被优化掉了(适配3)
     猜测可能和Label的尺寸坐标参数的小数点有关系，因为后面又遇到了一次，把所有的CGFloat改为Int值就没这问题了，懒得研究了 */
    var arrayData: Array<String> = []
    for i in 0 ..< array.count {
        if !array[i].isEmpty {
            arrayData.append(array[i])
        }
    }
    let underlyView = UIScrollView()
    underlyView.layer.cornerRadius = 4
    underlyView.backgroundColor = UIColor.systemGroupedBackground
    underlyView.bounces = false
    underlyView.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl + 4)
    if settingEssayTitle2DisplayMode == 1 {
        underlyView.backgroundColor = UIColor.systemBackground
        underlyView.layer.borderColor = UIColor(red: 146/255.0, green: 146/255.0, blue: 148/255.0, alpha: 1.000).cgColor
    } else if settingEssayTitle2DisplayMode == 2 {
        lineWidth = CGFloat(3)
        boardWidth = CGFloat(0)
        rowHeight = CGFloat(30)
        underlyView.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.3)
    }
    underlyView.layer.borderWidth = boardWidth
    
    // 获取最大列数
    var columnCountMax = 0
    for i in 0 ..< arrayData.count {
        let cellString = String(arrayData[i]).components(separatedBy: "|")
        if columnCountMax < cellString.count {
            columnCountMax = cellString.count
        }
    }
    // 获取每列最长宽度
    var columnStringArrayArray: Array<Array<String>> = []
    for _ in 0 ..< columnCountMax {
        let columnMaxStringArray: Array<String> = []
        columnStringArrayArray.append(columnMaxStringArray)
    }
    for i in 0 ..< arrayData.count {
        let cellString = String(arrayData[i]).components(separatedBy: "|")
        for item in 0 ..< columnCountMax {
            if item < cellString.count {
                columnStringArrayArray[item].append(cellString[item])
            }
        }
    }
    var columnMaxWidthArray: Array<CGFloat> = []
    for i in 0 ..< columnStringArrayArray.count {
        var columnMaxWidth = CGFloat(0)
        for item in 0 ..< columnStringArrayArray[i].count {
            let cellString1 = stringHandling(columnStringArrayArray[i][item])
            let cellString = cellString1.trimmingCharacters(in: .whitespacesAndNewlines)
            let labelFrame = UILabel()
            labelFrame.text = cellString
            labelFrame.font = UIFont.systemFont(ofSize: basicFont - 1)
            labelFrame.sizeToFit()
            if columnMaxWidth < labelFrame.frame.size.width {
                columnMaxWidth = labelFrame.frame.size.width
            }
        }
        if columnMaxWidth <= 50 {
            columnMaxWidth = 50
        }
        columnMaxWidthArray.append(columnMaxWidth)
    }
    // 框架大小
    var frameWidth = CGFloat(0)
    var frameOriginX: Array<CGFloat> = []
    for i in 0 ..< columnCountMax {
        frameOriginX.append(frameWidth + 5)
        frameWidth += columnMaxWidthArray[i] + 10
    }
    if frameWidth < screenWidth - spacedForScreen * 2 {
        let difference = (screenWidth - spacedForScreen * 2) - frameWidth
        frameWidth = screenWidth - spacedForScreen * 2
        for i in 0 ..< columnCountMax {
            frameOriginX[i] += CGFloat(i * (Int(difference) / columnCountMax))
            columnMaxWidthArray[i] += difference / CGFloat(columnCountMax)
        }
    }
    
    var cellViewArray: Array<UIView> = []
    for i in 0 ..< arrayData.count {
        let cellView = UIView(frame: CGRect(x: boardWidth - lineWidth / 2, y: boardWidth + rowHeight * CGFloat(i) - lineWidth / 2, width: frameWidth - boardWidth * 2, height: rowHeight))
        if frameWidth == screenWidth - spacedForScreen * 2, settingEssayTitle2DisplayMode == 2 , i % 2 == 1 {
            cellView.frame.size.width += lineWidth / 2
        }
        // 绘制表格水平方向的分割线
        if i != 0 {
            let horizontalLinePath = UIBezierPath()
            let pointY = rowHeight * CGFloat(i) + boardWidth - lineWidth / 2
            horizontalLinePath.move(to: CGPoint(x: boardWidth, y: pointY))
            horizontalLinePath.addLine(to: CGPoint(x: frameWidth - boardWidth, y: pointY))
            let horizontalLine = CAShapeLayer()
            horizontalLine.path = horizontalLinePath.cgPath
            switch settingEssayTitle2DisplayMode {
            case 0: horizontalLine.strokeColor = UIColor.black.cgColor
            case 1: horizontalLine.strokeColor = UIColor(red: 146/255.0, green: 146/255.0, blue: 148/255.0, alpha: 1.000).cgColor
            case 2: horizontalLine.strokeColor = UIColor.systemBackground.cgColor
            default:
                break
            }
            horizontalLine.lineWidth = lineWidth
            underlyView.layer.addSublayer(horizontalLine)
        }
        
        cellViewArray.append(cellView)
        underlyView.addSubview(cellView)
        let cellString = String(arrayData[i]).components(separatedBy: "|")
        var labelArray: Array<UILabel> = []
        for item in 0 ..< columnCountMax {
            if i == 0, item != 0 {
                // 绘制表格垂直方向的分割线
                let verticalLinePath = UIBezierPath()
                var point = frameOriginX[item] - 5 - lineWidth / 2 + boardWidth
                if boardWidth == CGFloat(10), lineWidth == CGFloat(10) {
                    // 适配2
                    point -= 1
                }
                verticalLinePath.move(to: CGPoint(x: point, y: boardWidth))
                verticalLinePath.addLine(to: CGPoint(x: point, y: CGFloat(arrayData.count) * rowHeight + boardWidth))
                let verticalLine = CAShapeLayer()
                verticalLine.path = verticalLinePath.cgPath
                switch settingEssayTitle2DisplayMode {
                case 0: verticalLine.strokeColor = UIColor.black.cgColor
                case 1: verticalLine.strokeColor = UIColor(red: 146/255.0, green: 146/255.0, blue: 148/255.0, alpha: 1.000).cgColor
                case 2: verticalLine.strokeColor = UIColor.systemBackground.cgColor
                default:
                    break
                }
                verticalLine.lineWidth = lineWidth
                underlyView.layer.addSublayer(verticalLine)
            }
            for item in 0 ..< columnCountMax {
                if i % 2 == 1, item != 0, settingEssayTitle2DisplayMode == 2 {
                    let verticalLinePath2 = UIBezierPath()
                    var point2 = frameOriginX[item] - 5 + boardWidth
                    if boardWidth == CGFloat(10), lineWidth == CGFloat(10) {
                        // 适配2
                        point2 -= 1
                    }
                    verticalLinePath2.move(to: CGPoint(x: point2, y: 0))
                    verticalLinePath2.addLine(to: CGPoint(x: point2, y: rowHeight))
                    let verticalLine2 = CAShapeLayer()
                    verticalLine2.path = verticalLinePath2.cgPath
                    verticalLine2.strokeColor = UIColor.systemBackground.cgColor
                    verticalLine2.lineWidth = lineWidth
                    cellView.layer.addSublayer(verticalLine2)
                }
            }
            if item < cellString.count {
                let trimmedString = String(cellString[item]).trimmingCharacters(in: .whitespacesAndNewlines)
                let label = UILabel(frame: CGRect(x: Int(frameOriginX[item]), y: 0, width:  Int(columnMaxWidthArray[item]), height: Int(rowHeight)))
                label.backgroundColor = UIColor.systemGroupedBackground
                label.lineBreakMode = .byClipping
                
                if settingEssayTitle2DisplayMode == 1 {
                    label.backgroundColor = UIColor.systemBackground
                } else if settingEssayTitle2DisplayMode == 2 {
                    if i % 2 == 1 {
                        cellView.backgroundColor = UIColor(red: 222/255.0, green: 221/255.0, blue: 247/255.0, alpha: 1.000)
                        label.backgroundColor = UIColor(red: 222/255.0, green: 221/255.0, blue: 247/255.0, alpha: 1.000)
                        let horizontalLinePath2 = UIBezierPath()
                        horizontalLinePath2.move(to: CGPoint(x: 0, y: 0))
                        horizontalLinePath2.addLine(to: CGPoint(x: cellView.frame.width, y: 0))
                        let horizontalLine2 = CAShapeLayer()
                        horizontalLine2.path = horizontalLinePath2.cgPath
                        horizontalLine2.strokeColor = UIColor.systemBackground.cgColor
                        horizontalLine2.lineWidth = 2.5
                        cellView.layer.addSublayer(horizontalLine2)
                    } else {
                        label.backgroundColor = UIColor(red: 205/255.0, green: 204/255.0, blue: 243/255.0, alpha: 1.000)
                    }
                }
                
                switch mode {
                case "<>": label.textAlignment = .center
                case "><": label.textAlignment = .center
                case "center": label.textAlignment = .center
                case ">": label.textAlignment = .right
                case "right": label.textAlignment = .right
                default:
                    label.textAlignment = .left
                }
                // 单独的单元格模式
                label.text = stringHandling(trimmedString)
                if trimmedString.hasPrefix("> ") {
                    label.textAlignment = .right
                } else if trimmedString.hasPrefix("< ") {
                    label.textAlignment = .left
                } else if trimmedString.hasPrefix("#left ") {
                    label.textAlignment = .left
                } else if trimmedString.hasPrefix("#right ") {
                    label.textAlignment = .right
                } else if trimmedString.hasPrefix("<> ") {
                    label.textAlignment = .center
                } else if trimmedString.hasPrefix(">< ") {
                    label.textAlignment = .center
                } else if trimmedString.hasPrefix("#center ") {
                    label.textAlignment = .center
                } else {
                    label.text = trimmedString
                }
                label.font = UIFont.systemFont(ofSize: basicFont - 1)
                label.frame.origin.y += (i == 0 ? boardWidth / 2: lineWidth / 2)
                label.frame.size.height -= (i == 0 ? lineWidth / 2 + boardWidth / 2: lineWidth)
                //                if settingEssayTitle2DisplayMode == 1 {
                //                    let canshu = 0.1165
                //                    label.frame.origin.y += canshu
                //                    label.frame.size.height -= canshu * 2
                //                }
                if lineWidth == CGFloat(1.0), boardWidth == CGFloat(1.5) {
                    // 适配3
                    label.frame.origin.y += (i == 0 ? 0: 0.002)
                    label.frame.size.height -= (i == 0 ? 0: 0.002)
                }
                cellView.addSubview(label)
                labelArray.append(label)
            } else {
                labelArray[cellString.count - 1].frame.size.width += CGFloat(10 + Int( columnMaxWidthArray[item]))
            }
        }
        
        underlyView.addSubview(cellView)
    }
    underlyView.frame.size = CGSize(width: screenWidth - spacedForScreen * 2, height: cellViewArray[arrayData.count - 1].frame.maxY + boardWidth - lineWidth / 2)
    underlyView.contentSize.width = frameWidth - lineWidth
    view.addSubview(underlyView)
    return underlyView.frame.maxY
}

func essayInterfaceBuild(data: Dictionary<String, Any>, ViewController: UIViewController) {
    // 设置最底层的滚动视图，用来承载界面内的所有元素
    let underlyScrollView = UIScrollView(frame: ViewController.view.bounds)
    ViewController.view.addSubview(underlyScrollView)
    
    var header: Array<String> = []
    var content: Array<String> = []
    let dataContent: Array<String> = data["content"] as! Array<String>
    for i in 0 ..< dataContent.count {
        if i % 2 == 0 {
            header.append(dataContent[i])
        } else {
            content.append(dataContent[i])
        }
    }
    
    var originY = CGFloat(0)
    ViewController.navigationItem.title = data["title"] as? String
    
    let author0 = UILabel()
    author0.frame.size.width = screenWidth - spacedForScreen * 2
    author0.text = "作者："
    author0.font = UIFont.systemFont(ofSize: basicFont, weight: .bold)
    author0.sizeToFit()
    author0.frame.origin = CGPoint(x: spacedForScreen, y: spacedForControl - 2)
    author0.layer.cornerRadius = 5
    underlyScrollView.addSubview(author0)
    
    let author = UILabel()
    author.frame.size.width = screenWidth - spacedForScreen * 2
    author.text = data["author"] as? String
    author.font = UIFont.systemFont(ofSize: basicFont, weight: .medium)
    author.sizeToFit()
    author.frame.origin = CGPoint(x: author0.frame.maxX, y: spacedForControl - 2)
    author.layer.cornerRadius = 5
    author.frame.size.width += 7
    author.clipsToBounds = true
    author.textAlignment = .center
    author.backgroundColor = UIColor.systemFill
    underlyScrollView.addSubview(author)
    
    switch settingEssayTitle2DisplayMode {
    case 1:
        author0.text = ""
        author.text = "作者：\(String(describing: data["author"]!))"
        author.sizeToFit()
        author.frame.origin.x = spacedForScreen
        author.frame.size.width += 7
        author.textAlignment = .center
        author.backgroundColor = UIColor.systemGroupedBackground
        author.layer.borderWidth = 1
        author.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
    case 2:
        author0.frame.origin.x += 10
        author.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.2)
        author.frame.origin.x = author0.frame.maxX
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: spacedForScreen + 3, y: author.frame.minY + 1))
        path.addLine(to: CGPoint(x: spacedForScreen + 3, y: author.frame.maxY - 1))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.7).cgColor
        shapeLayer.lineWidth = 5.0
        underlyScrollView.layer.addSublayer(shapeLayer)
    default:
        break
    }
    
    for i in 0 ..< content.count {
        switch header[i] {
        case "title2":
            let title2 = UILabel()
            title2.frame.size.width = screenWidth - spacedForScreen * 2
            title2.text = content[i]
            title2.font = titleFont2
            title2.sizeToFit()
            title2.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForModule)
            underlyScrollView.addSubview(title2)
            originY = title2.frame.maxY
            
            switch settingEssayTitle2DisplayMode {
            case 1:
                let path = UIBezierPath()
                path.move(to: CGPoint(x: spacedForScreen, y: title2.frame.maxY + 3))
                path.addLine(to: CGPoint(x: screenWidth - spacedForScreen, y: title2.frame.maxY + 3))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.5).cgColor
                shapeLayer.lineWidth = 1.0
                underlyScrollView.layer.addSublayer(shapeLayer)
                originY += 5
            case 2:
                let path = UIBezierPath()
                path.move(to: CGPoint(x: spacedForScreen, y: title2.frame.maxY - 3))
                path.addLine(to: CGPoint(x: title2.frame.maxX, y: title2.frame.maxY - 3))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.5).cgColor
                shapeLayer.lineWidth = 9.0
                underlyScrollView.layer.addSublayer(shapeLayer)
                originY += 6
            default:
                break
            }
        case "title3":
            let title3 = UILabel()
            title3.frame.size.width = screenWidth - spacedForScreen * 2
            title3.text = "· \(content[i])"
            title3.font = UIFont.systemFont(ofSize: titleFont3, weight: .medium)
            title3.sizeToFit()
            title3.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForNavigation)
            underlyScrollView.addSubview(title3)
            
            originY = title3.frame.maxY
            
            switch settingEssayTitle2DisplayMode {
            case 1:
                title3.text = "- \(content[i])"
                title3.sizeToFit()
            case 2:
                title3.text = "\(content[i])"
                title3.sizeToFit()
                title3.frame.origin.x += 13
                let path = UIBezierPath()
                path.move(to: CGPoint(x: spacedForScreen + 5, y: title3.frame.minY + 3))
                path.addLine(to: CGPoint(x: spacedForScreen + 5, y: title3.frame.maxY - 3))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.7).cgColor
                shapeLayer.lineWidth = 5.0
                underlyScrollView.layer.addSublayer(shapeLayer)
            default:
                break
            }
        case "text":
            let text = UILabel()
            text.frame.size.width = screenWidth - spacedForScreen * 2
            let string = content[i]
            let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
            text.text = trimmed
            text.numberOfLines = 0
            text.font = UIFont.systemFont(ofSize: basicFont)
            text.sizeToFit()
            text.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl)
            underlyScrollView.addSubview(text)
            originY = text.frame.maxY
        case "image":
            let imageView = UIImageView()
            imageView.image = UIImage(named: content[i])
            imageView.contentMode = .scaleAspectFit
            imageView.sizeToFit()
            let proportion = imageView.frame.size.height / imageView.frame.size.width
            imageView.frame.size.width = screenWidth - spacedForScreen * 2
            imageView.frame.size.height = imageView.frame.size.width * proportion
            imageView.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl)
            underlyScrollView.addSubview(imageView)
            originY = imageView.frame.maxY
        case "code":
            let codeScroll = UIScrollView(frame: CGRect(x: spacedForScreen, y: originY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 0))
            codeScroll.backgroundColor = UIColor.systemFill
            codeScroll.layer.cornerRadius = 5
            codeScroll.alwaysBounceHorizontal = true
            underlyScrollView.addSubview(codeScroll)
            let lines = content[i].split(separator: "\n")
            var codeArray: Array<UILabel> = []
            var maxX = CGFloat(0)
            for i in 0 ..< lines.count {
                let code = UILabel()
                code.frame.origin = CGPoint(x: 10, y: 10)
                let attString = NSMutableAttributedString(string: String(lines[i]))
                
                if attString.string.count >= 5 {
                    for index in 0 ..< attString.string.count - 4 {
                        let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
                        let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
                        let strIndex3 = attString.string.index(attString.string.startIndex, offsetBy: index + 2)
                        let strIndex4 = attString.string.index(attString.string.startIndex, offsetBy: index + 3)
                        let strIndex5 = attString.string.index(attString.string.startIndex, offsetBy: index + 4)
                        if index % 4 == 0, attString.string[strIndex] == "p", attString.string[strIndex2] == "r", attString.string[strIndex3] == "i", index == 0, attString.string[strIndex4] == "n", attString.string[strIndex5] == "t" {
                            attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 5))
                        } else if index % 4 == 0, attString.string[strIndex] == "g", attString.string[strIndex2] == "u", attString.string[strIndex3] == "a", index == 0, attString.string[strIndex4] == "r", attString.string[strIndex5] == "d" {
                            attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 5))
                        }
                    }
                }
                if attString.string.count >= 4 {
                    for index in 0 ..< attString.string.count - 3 {
                        let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
                        let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
                        let strIndex3 = attString.string.index(attString.string.startIndex, offsetBy: index + 2)
                        let strIndex4 = attString.string.index(attString.string.startIndex, offsetBy: index + 3)
                        if attString.string[strIndex] == "f", attString.string[strIndex2] == "u", attString.string[strIndex3] == "n", index == 0, attString.string[strIndex4] == "c" {
                            attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 5))
                        }
                    }
                }
                if attString.string.count >= 3 {
                    for index in 0 ..< attString.string.count - 2 {
                        let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
                        let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
                        let strIndex3 = attString.string.index(attString.string.startIndex, offsetBy: index + 2)
                        if index % 4 == 3, attString.string[strIndex] == "v", attString.string[strIndex2] == "a", attString.string[strIndex3] == "r" {
                            attString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: index, length: 3))
                        } else if index % 4 == 3, attString.string[strIndex] == "l", attString.string[strIndex2] == "e", attString.string[strIndex3] == "t" {
                            attString.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: index, length: 3))
                        }
                    }
                }
                if attString.string.count >= 2 {
                    for index in 0 ..< attString.string.count - 1 {
                        let strIndex = attString.string.index(attString.string.startIndex, offsetBy: index)
                        let strIndex2 = attString.string.index(attString.string.startIndex, offsetBy: index + 1)
                        if attString.string[strIndex] == "/", attString.string[strIndex2] == "/" {
                            attString.addAttribute(.foregroundColor, value: #colorLiteral(red: 0.1764705882, green: 0.5215686275, blue: 0.01568627451, alpha: 1), range: NSRange(location: index, length: attString.string.count - index))
                        } else if index % 4 == 3, attString.string[strIndex] == "i", attString.string[strIndex2] == "f" {
                            attString.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: index, length: 2))
                        }
                    }
                }
                code.attributedText = attString
                code.font = UIFont(name: "Menlo", size: basicFont - 1)
                code.sizeToFit()
                if i != 0 {
                    code.frame.origin.y = codeArray[i - 1].frame.maxY + 4
                }
                if code.frame.maxX > maxX {
                    maxX = code.frame.maxX
                }
                codeArray.append(code)
                codeScroll.addSubview(code)
            }
            
            codeScroll.frame.size.height = codeArray[lines.count - 1].frame.maxY + 10
            codeScroll.contentSize = CGSize(width: maxX + 10, height: codeArray[lines.count - 1].frame.maxY + 10)
            
            originY = codeScroll.frame.maxY
            
            switch settingEssayTitle2DisplayMode {
            case 1:
                codeScroll.backgroundColor = UIColor.systemGroupedBackground
                codeScroll.layer.borderWidth = 1
                codeScroll.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
            case 2:
                codeScroll.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.2)
            default:
                break
            }
        default:
            break
        }
        underlyScrollView.contentSize = CGSize(width: screenWidth, height: originY + spacedForScreen)
    }
}

