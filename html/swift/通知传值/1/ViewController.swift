import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(type: .system)
        button.setTitle("跳转", for: .normal)
        button.addTarget(self, action: #selector(presentSecondViewController), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func presentSecondViewController() {
        let vc = SecondViewController()
        vc.delegate = self
        present(vc, animated: false, completion: nil)
    }
}

extension ViewController: SecondViewControllerDelegate {
    func passValue(value: String) {
        print("接收到的值为：\(value)")
    }
}


