//
//  ViewController.swift
//  pickerview
//
//  Created by QHuiYan on 2023/3/27.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: 100, width: 300, height: 100))
        view.addSubview(picker)
        picker.delegate = self
        picker.dataSource = self
    }


}

