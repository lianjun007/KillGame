//
//  ViewController.swift
//  TabBarStoryboard
//
//  Created by QHuiYan on 2023/5/16.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        
    }


}

