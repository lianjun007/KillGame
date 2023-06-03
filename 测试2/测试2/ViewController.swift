//
//  ViewController.swift
//  测试2
//
//  Created by QHuiYan on 2023/5/29.
//

import UIKit

class ViewController: UIViewController, UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: {
            let previewController = UIViewController()
            previewController.view.backgroundColor = .red
            return previewController
        }) { suggestedActions in
            
            let action1 = UIAction(title: "阅读", image: UIImage(systemName: "book")) { action in
                // Show system share sheet
            }
            
            let action2 = UIAction(title: "收藏", image: UIImage(systemName: "star"), attributes: .keepsMenuPresented) { action in
            }
            
            // Create and return a UIMenu with the share action
            return UIMenu(title: "基础操作", children: [action1, action2])
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 300, height: 500))
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        view.addSubview(button)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        button.addInteraction(interaction)

    }
    
}
