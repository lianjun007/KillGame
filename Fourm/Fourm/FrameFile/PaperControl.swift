//
//  PaperControl.swift
//  Fourm
//
//  Created by QHuiYan on 2023/6/7.
//

import Foundation
import UIKit

func controlBuild(body: Array<String>, ViewController: UIViewController) {
    let scroll = UIScrollView(frame: ViewController.view.bounds)
    ViewController.view.addSubview(scroll)
    
    var header: Array<String> = []
    var content: Array<String> = []
    for i in 0 ..< body.count {
        if i % 2 == 0 {
            header.append(body[i])
        } else {
            content.append(body[i])
        }
    }
    
    var originY = spacedForModule2
    for i in 0 ..< content.count {
        switch header[i] {
        case "title":
            ViewController.navigationItem.title = content[i]
        case "title2":
            let title2 = UILabel()
            title2.frame.size.width = screenWidth - spacedForScreen * 2
            title2.text = content[i]
            title2.font = UIFont.systemFont(ofSize: titleFont2, weight: .bold)
            title2.sizeToFit()
            title2.frame.origin = CGPoint(x: spacedForScreen, y: (originY == spacedForModule2 ? originY: originY + spacedForModule))
            scroll.addSubview(title2)
            originY = title2.frame.maxY
        case "body":
            let body = UILabel()
            body.frame.size.width = screenWidth - spacedForScreen * 2
            body.text = content[i]
            body.numberOfLines = 0
            body.font = UIFont.systemFont(ofSize: basicFont)
            body.sizeToFit()
            body.frame.origin = CGPoint(x: spacedForScreen, y: originY + spacedForControl)
            scroll.addSubview(body)
            originY = body.frame.maxY
        case "code":
            let codeScroll = UIScrollView(frame: CGRect(x: spacedForScreen, y: originY + spacedForControl, width: screenWidth - spacedForScreen * 2, height: 0))
            codeScroll.layer.borderWidth = 0.25
            codeScroll.layer.cornerRadius = 5
            scroll.addSubview(codeScroll)
            let code = UILabel()
            code.text = content[i]
            code.numberOfLines = 0
            code.font = UIFont.systemFont(ofSize: basicFont, weight: .thin)
            code.sizeToFit()
            codeScroll.frame.size.height = code.frame.height
            codeScroll.contentSize = CGSize(width: code.frame.width, height: codeScroll.frame.height)
            codeScroll.addSubview(code)
            originY = codeScroll.frame.maxY
        default:
            break
        }
        scroll.contentSize = CGSize(width: screenWidth, height: originY + spacedForControl)
    }
}
