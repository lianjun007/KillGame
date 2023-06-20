import Foundation
import UIKit

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
    author0.frame.origin = CGPoint(x: spacedForScreen + 10, y: spacedForControl - 2)
    author0.layer.cornerRadius = 5
    author0.clipsToBounds = true
    underlyScrollView.addSubview(author0)
    
    let author = UILabel()
    author.frame.size.width = screenWidth - spacedForScreen * 2
    author.text = data["author"] as? String
    author.font = UIFont.systemFont(ofSize: basicFont, weight: .bold)
    author.sizeToFit()
    author.frame.origin = CGPoint(x: author0.frame.maxX, y: spacedForControl - 2)
    author.layer.cornerRadius = 5
    author.frame.size.width += 7
    author.textAlignment = .center
    author.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.2)
    author.clipsToBounds = true
    underlyScrollView.addSubview(author)
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: spacedForScreen + 3, y: author.frame.minY + 1))
    path.addLine(to: CGPoint(x: spacedForScreen + 3, y: author.frame.maxY - 1))
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.7).cgColor
    shapeLayer.lineWidth = 5.0
    underlyScrollView.layer.addSublayer(shapeLayer)
    
    for i in 0 ..< content.count {
        switch header[i] {
        case "title2":
            let title2 = UILabel()
            title2.frame.size.width = screenWidth - spacedForScreen * 2
            title2.text = content[i]
            title2.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
            title2.sizeToFit()
            title2.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForModule)
            underlyScrollView.addSubview(title2)
            originY = title2.frame.maxY
            
            switch settingEssayTitle2DisplayMode {
            case 0:
                let path = UIBezierPath()
                path.move(to: CGPoint(x: spacedForScreen, y: title2.frame.maxY + 3))
                path.addLine(to: CGPoint(x: screenWidth - spacedForScreen, y: title2.frame.maxY + 3))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.5).cgColor
                shapeLayer.lineWidth = 1.0
                underlyScrollView.layer.addSublayer(shapeLayer)
                originY += 5
            case 1:
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
            title3.text = content[i]
            title3.font = UIFont.systemFont(ofSize: titleFont3, weight: .medium)
            title3.sizeToFit()
            title3.frame.origin = CGPoint(x: spacedForScreen + 13, y: originY + spacedForModule2)
            underlyScrollView.addSubview(title3)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: spacedForScreen + 5, y: title3.frame.minY + 3))
            path.addLine(to: CGPoint(x: spacedForScreen + 5, y: title3.frame.maxY - 3))
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.strokeColor = UIColor.systemIndigo.withAlphaComponent(0.7).cgColor
            shapeLayer.lineWidth = 5.0
            underlyScrollView.layer.addSublayer(shapeLayer)
            
            originY = title3.frame.maxY
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
            codeScroll.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.2)
            codeScroll.layer.cornerRadius = 5
            codeScroll.alwaysBounceHorizontal = true
            underlyScrollView.addSubview(codeScroll)
            let code = UILabel()
            code.frame.origin = CGPoint(x: 10, y: 10)
            code.text = content[i]
            code.numberOfLines = 0
            code.font = UIFont(name: "Menlo", size: basicFont)
            code.sizeToFit()
            codeScroll.frame.size.height = code.frame.maxY + 10
            codeScroll.contentSize = CGSize(width: code.frame.maxX + 10, height: code.frame.maxY + 10)
            codeScroll.addSubview(code)
            originY = codeScroll.frame.maxY
        default:
            break
        }
        underlyScrollView.contentSize = CGSize(width: screenWidth, height: originY + spacedForControl)
    }
}


