//
//  CourseViewController.swift
//  CodeForum
//
//  Created by QHuiYan on 2023/6/3.
//


import UIKit
// import MarkdownKit

class CourseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "精选课程标题"
        navigationItem.largeTitleDisplayMode = .never
        
//        let markdownParser = MarkdownParser()
//        let markdown = """
//        # Hello, world!
//
//        This is a paragraph.
//
//        ```swift
//        let message = "Hello, world!"
//        print(message)
//        ```
//        """
//
//        let attributedString = markdownParser.parse(markdown)
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
//        label.numberOfLines = 0
//        label.attributedText = attributedString

        //view.addSubview(label)
    }
}
