//
//  SingleViewController.swift
//  HuiYanKill
//
//  Created by QHuiYan on 2023/3/25.
//

import UIKit

class SingleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonArray = navigationBarBuild(view: view, direction: false, buttonCount: 2, buttonContent: [["person", ""], []])
    }

}
