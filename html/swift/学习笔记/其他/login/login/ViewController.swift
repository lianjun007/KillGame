//
//  ViewController.swift
//  login
//
//  Created by QHuiYan on 2023/3/15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userName.leftView = UIImageView(image: UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        userName.leftViewMode = .always
        userName.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        passWord.leftView = UIImageView(image: UIImage(systemName: "key")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        passWord.leftViewMode = .always
        passWord.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
    }
    
    @objc func textChanged(_ sender: UITextField) {
        print(sender.text!)
    }
    
    @IBAction func login(_ sender: Any) {
        let inputUserName = userName.text
        let inputPassWord = passWord.text
        
        // 用户名与密码存储数组
        let accountArray = ["administerator": "administerator077", "zhangsan": "123456", "lisi": "654321", "wangwu": "456789"]
        
        if let inputUserName = inputUserName, let inputPassWord = inputPassWord {
            if inputUserName.isEmpty {
                print("请输入用户名")
                return
            }
            if inputPassWord.isEmpty {
                print("请输入密码")
                return
            }
            
            if inputPassWord == accountArray[String(inputUserName)] {
                print("账户验证通过")
            }
            else {
                print("账户验证未通过")
            }
        }
    }
    
    @IBAction func rememberPassWord(_ sender: Any) {
        
    }
}

