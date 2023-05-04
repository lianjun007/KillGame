

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func passValue(value: String)
}


class SecondViewController: UIViewController {

    weak var delegate: SecondViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let button = UIButton(type: .system)
        button.setTitle("返回", for: .normal)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func dismissSelf() {
        delegate?.passValue(value: "传递的值")
        dismiss(animated: true, completion: nil)
    }
}

