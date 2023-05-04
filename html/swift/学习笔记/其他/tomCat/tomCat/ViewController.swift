//
//  ViewController.swift
//  tomCat
//
//  Created by QHuiYan on 2023/3/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainInterFace: UIImageView! // tomCat的主界面UIimageView
    
    var images: [UIImage] = [] // 储存动画图片的数组
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickedButton(_ sender: UIButton) {
        if mainInterFace.isAnimating {
            return
        } // 动画防打断
        
        images.removeAll() // 清空数组防干扰
        
        for i in 0 ... sender.tag {
            let imageName = String(format: "\(sender.titleLabel?.text ?? "")_%02d.jpg", i)
            if let image = UIImage(named: imageName) {
                images.append(image)
            }
        }
        mainInterFace.animationImages = images // 调用数组
        mainInterFace.animationRepeatCount = 1 // 播放次数限制
        mainInterFace.animationDuration = Double(sender.tag) * 0.05 // 播放速度限制
        mainInterFace.startAnimating() // 播放动画
        
    }
}

