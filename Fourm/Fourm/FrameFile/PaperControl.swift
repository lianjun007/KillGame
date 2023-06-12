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
    
    var originY = spacedForModule2
    ViewController.navigationItem.title = data["title"] as? String
    let author = UILabel()
    author.frame.size.width = screenWidth - spacedForScreen * 2
    author.text = data["author"] as? String
    author.font = UIFont.systemFont(ofSize: basicFont, weight: .bold)
    author.sizeToFit()
    author.frame.origin = CGPoint(x: spacedForScreen, y: 0)
    author.layer.cornerRadius = 5
    author.backgroundColor = .systemFill
    author.clipsToBounds = true
    underlyScrollView.addSubview(author)
    originY = author.frame.maxY
    
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
        case "title3":
            let title3 = UILabel()
            title3.frame.size.width = screenWidth - spacedForScreen * 2
            title3.text = content[i]
            title3.font = UIFont.systemFont(ofSize: titleFont3, weight: .bold)
            title3.sizeToFit()
            title3.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl)
            underlyScrollView.addSubview(title3)
            originY = title3.frame.maxY
        case "text":
            let text = UILabel()
            text.frame.size.width = screenWidth - spacedForScreen * 2
            text.text = content[i]
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
            codeScroll.backgroundColor = .systemFill
            codeScroll.layer.cornerRadius = 5
            underlyScrollView.addSubview(codeScroll)
            let code = UILabel()
            code.frame.origin = CGPoint(x: 5, y: 3)
            let spaces = String(repeating: " ", count: 2)
            let tab = " "
            let replacedString = content[i].replacingOccurrences(of: tab, with: spaces)
            code.text = replacedString
            code.numberOfLines = 0
            code.font = UIFont.systemFont(ofSize: basicFont, weight: .thin)
            code.sizeToFit()
            codeScroll.frame.size.height = code.frame.maxY + 10
            codeScroll.contentSize = CGSize(width: code.frame.maxX + 5, height: code.frame.maxY + 10)
            codeScroll.addSubview(code)
            originY = codeScroll.frame.maxY
        default:
            break
        }
        underlyScrollView.contentSize = CGSize(width: screenWidth, height: originY + spacedForControl)
    }
}


