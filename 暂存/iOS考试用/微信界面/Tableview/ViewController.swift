import UIKit

class ViewController: UIViewController {
    let userNameTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let skipLoginButton = UIButton()
    let userDataButton = UIButton()
    let userDataDict = userData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置用户名文本框
        userNameTextField.placeholder = "请输入用户名"
        userNameTextField.borderStyle = .roundedRect
        view.addSubview(userNameTextField)
        
        // 设置密码文本框
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        
        // 设置登录按钮
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemIndigo
        loginButton.layer.cornerRadius = 15
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        // 设置跳过登录按钮
        skipLoginButton.setTitle("跳过登录", for: .normal)
        skipLoginButton.setTitleColor(.white, for: .normal)
        skipLoginButton.backgroundColor = .systemGray2
        skipLoginButton.layer.cornerRadius = 15
        skipLoginButton.addTarget(self, action: #selector(skipLoginButtonTapped), for: .touchUpInside)
        view.addSubview(skipLoginButton)
        
        // 设置查看密码本按钮
        userDataButton.setTitle("密码本", for: .normal)
        userDataButton.setTitleColor(.white, for: .normal)
        userDataButton.backgroundColor = .systemGray2
        userDataButton.layer.cornerRadius = 15
        userDataButton.addTarget(self, action: #selector(lookPasswordClick), for: .touchUpInside)
        view.addSubview(userDataButton)
        
        // 布局子视图
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        skipLoginButton.translatesAutoresizingMaskIntoConstraints = false
        userDataButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: spacedForScreen),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacedForScreen),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacedForScreen),
            userNameTextField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: spacedForScreen),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacedForScreen),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacedForScreen),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: spacedForScreen),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacedForScreen),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacedForScreen),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
            skipLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: spacedForScreen),
            skipLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacedForScreen),
            skipLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(spacedForScreen + screenWidth) / 2),
            skipLoginButton.heightAnchor.constraint(equalToConstant: 44),
            
            userDataButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: spacedForScreen),
            userDataButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (spacedForScreen + screenWidth) / 2),
            userDataButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacedForScreen),
            userDataButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
    }
    
    // 跳转界面
    @objc func loginButtonTapped(sender: UIButton) {
        var userName = userNameTextField.text!
        let password = passwordTextField.text!
        if userDataDict["userName"] == nil {
            userName = "default"
        }
        
        if userDataDict["\(userName)"] == password, userName != "default" {
            let vc = TabBarController()
            userTips = "尊敬的用户：\(userName)"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        } else {
            if userName == "default", userDataDict["\(userName)"] == password {
                let alert = UIAlertController(title: "您没有管理员权限", message: "请使用非默认(任意用户名&密码123456)账号和密码登录", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "账号或密码错误", message: "请输入正确的账号和密码", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
            
        }
    }
    @objc func skipLoginButtonTapped() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    @objc func lookPasswordClick() {
        let vc = PasswordViewController()
        self.present(vc, animated: true)
    }
}
