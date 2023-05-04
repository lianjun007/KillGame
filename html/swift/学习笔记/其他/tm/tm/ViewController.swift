//
//  ViewController.swift
//  tm
//
//  Created by QHuiYan on 2023/3/10.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainInterfaceView: UIImageView!
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    

    @IBAction func mainCymbal(_ sender: UIButton) {
        images.removeAll()
        var num = 0
        var str = ""
        switch sender.tag {
        case 0:
            num = 80
            str = "drink"
        case 1:
            num = 39
            str = "eat"
            
        default: break
        }
        
        for i in 0 ... num {
                let imageName = "\(str)_\(i).jpg"
                if let image = UIImage(named: imageName) {
                    images.append(image)
                }
        }
        
        mainInterfaceView.animationImages = images
        mainInterfaceView.startAnimating()
    }
    
}

