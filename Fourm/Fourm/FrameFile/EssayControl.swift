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
    VC.view.addSubview(underlyScrollView)
    
    var originY = CGFloat(0)
    
    var code = false
    var text = false
    var codeArray: Array<String> = []
    for item in essayDataArray {
        text = false
        if item.hasPrefix("#title ") {
            VC.navigationItem.title = stringHandling(item)
        } else if item.hasPrefix("#author ") {
            authorModuleBuild(stringHandling(item), underlyScrollView)
        } else if item.hasPrefix("#date ") {
        } else if item.hasPrefix("# ") {
            originY = title2ModuleBuild(stringHandling(item), underlyScrollView, originY: originY)
        } else if item.hasPrefix("## ") {
            originY = title3ModuleBuild(stringHandling(item), underlyScrollView, originY: originY)
        } else if item.hasPrefix("#image ") {
        } else if item.hasPrefix("#code") {
            codeArray = []
            code = true
        } else if item.hasPrefix("##code") {
            code = false
            originY = codeModuleBuild(Array(codeArray.dropFirst()), underlyScrollView, originY: originY)
        } else if item.hasPrefix("#chart") {
        } else if item.hasPrefix("##chart") {
        } else {
            text = true
        }
        
        if code {
            codeArray.append(item)
        } else if text {
            originY = textModuleBuild(item, underlyScrollView, originY: originY)
        }
    }
}

/// 处理文章内容的字符串
///
/// 输入一个包含识别码的原字符串返回一个去掉识别码的内容字符串
/// - Parameter string: 需要处理的包含识别码的原字符串
/// - Returns: 去掉识别码后的内容字符串
/// - Note: 返回的内容字符串将被去掉识别码和识别码后的所有空格，但是从第一个有效字符开始后的空格不受影响。
func stringHandling(_ string: String) -> String {
    var index0 = 0
    var index1 = 0
    var bool0 = false
    var bool1 = true
    for i in string {
        index1 += 1
        if i == " ", bool1 {
            bool0 = true
            bool1 = false
        }
        if i != " ", bool0 {
            bool0 = false
            index0 = index1 - 1
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
func authorModuleBuild(_ string: String, _ view: UIView) {
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
        shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.7).cgColor
        shapeLayer.lineWidth = 5.0
        view.layer.addSublayer(shapeLayer)
    default:
        break
    }
    return newOriginY
}

/// 创建代码块显示模块
///
/// 输入代码数组和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter stringArray: 代码块内容的数组
/// - Parameter view: 底层视图
/// - Parameter originY: 代码块的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func codeModuleBuild(_ stringArray: Array<String>, _ view: UIView, originY: CGFloat) -> CGFloat {
    var codeArray = stringArray
    var index = 0
    for item in codeArray {
        index += 1
        if item == "" {
            codeArray[index - 1] = " "
        }
    }
    var newOriginY = originY
    let codeScroll = UIScrollView(frame: CGRect(x: spacedForScreen, y: originY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 0))
    codeScroll.backgroundColor = UIColor.systemFill
    codeScroll.layer.cornerRadius = 5
    codeScroll.alwaysBounceHorizontal = true
    view.addSubview(codeScroll)
    var codeContentArray: Array<UILabel> = []
    var maxX = CGFloat(0)
    for i in 0 ..< codeArray.count {
        let code = UILabel()
        code.frame.origin = CGPoint(x: 10, y: 10)
        let attString = NSMutableAttributedString(string: codeArray[i])

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
            code.frame.origin.y = codeContentArray[i - 1].frame.maxY + 4
        }
        if code.frame.maxX > maxX {
            maxX = code.frame.maxX
        }
        codeContentArray.append(code)
        codeScroll.addSubview(code)
    }
    
    codeScroll.frame.size.height = codeContentArray[codeArray.count - 1].frame.maxY + 10
    codeScroll.contentSize = CGSize(width: maxX + 10, height: codeContentArray[codeArray.count - 1].frame.maxY + 10)
    
    newOriginY = codeScroll.frame.maxY
    
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
    return newOriginY
}

/// 创建文本显示模块
///
/// 输入代码数组和底层视图后将自动创建一个显示三级标题的视图
/// - Parameter stringArray: 代码块内容的数组
/// - Parameter view: 底层视图
/// - Parameter originY: 代码块的Y轴坐标
/// - Returns: 返回一个新的Y轴坐标
/// - Note: 返回的Y轴坐标是用来给后续创建内容控件定位使用的，所以需要将返回值赋值给原Y轴坐标。
func textModuleBuild(_ string: String, _ view: UIView, originY: CGFloat) -> CGFloat {
    let text = UILabel()
    text.frame.size.width = screenWidth - spacedForScreen * 2
    text.text = string
    text.numberOfLines = 0
    text.font = UIFont.systemFont(ofSize: basicFont)
    text.sizeToFit()
    text.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl)
    view.addSubview(text)
    return text.frame.maxY
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
            let originImage = imageView.frame.origin
            let proportion = imageView.frame.size.height / imageView.frame.size.width
            imageView.frame.origin = originImage
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
//                if code.text?.prefix(2) == "//" {
//                    code.textColor = #colorLiteral(red: 0.1764705882, green: 0.5215686275, blue: 0.01568627451, alpha: 1)
//                }
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
        underlyScrollView.contentSize = CGSize(width: screenWidth, height: originY + spacedForControl)
    }
}


