
import UIKit

class RoleViewController: UIViewController, RoleChooseViewControllerDelegate {

    let roleImageBox = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化视图
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = backgroundColor

        let buttonCount = 4
        let navButtonArray:Array<UIButton> = navigationBarBuild(view: view, direction: true, buttonCount: buttonCount, buttonContent: [["arrowshape.backward", "person", "figure.softball", "person.2"], ["返回首页", "角色选择", "模式选择", "角色图鉴"]], bounce: false)
        for i in 0 ..< buttonCount {
            navButtonArray[i].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
            navButtonArray[i].tag = i
        }

        // roleImageBox是插画显示区域
        roleImageBox.frame = CGRect(origin: roleImagePoint, size: roleBoxLargeSize)
        roleImageBox.backgroundColor = backgroundColor
        roleImageBox.layer.borderWidth = 7
        roleImageBox.layer.borderColor = borderColor
        roleImageBox.image = UIImage(named: "DefaultRole.jpeg")
        roleImageBox.contentMode = .scaleAspectFill
        roleImageBox.layer.cornerRadius = controlRoundSize
        roleImageBox.clipsToBounds = true
        view.addSubview(roleImageBox)

        // roleTextBox是角色选择后的信息预览区域的背景
        let roleTextBox = UIScrollView(frame: CGRect(origin: roleTextPoint, size: roleTextSize))
        roleTextBox.backgroundColor = backgroundColor
        roleTextBox.layer.borderColor = borderColor
        roleTextBox.layer.borderWidth = 7
        roleTextBox.layer.cornerRadius = controlRoundSize
        roleTextBox.contentSize = CGSize(width: roleTextSize.width, height: roleTextSize.height * 2) // 暂定
        view.addSubview(roleTextBox)
        
        // 角色信息预览区域
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: controlSpaced * 2, y: controlSpaced * 2), size: CGSizeZero))
        titleLabel.text = "属性"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.sizeToFit()
        roleTextBox.addSubview(titleLabel)

        // 开始游戏按钮
        let gameStart = ButtonBuild(image: "", title: "开始游戏", piont: CGPoint(x: roleTextSize.width - buttonSize.width - controlSpaced, y: roleTextSize.height - buttonSize.height - controlSpaced), view: roleTextBox)
        gameStart.tag = 4
        gameStart.addTarget(self, action: #selector(clickEvents), for: .touchUpInside)

    }

    @objc func clickEvents(sender: UIButton) {
        switch sender.tag {
        case 0: self.navigationController?.popViewController(animated: true)
        case 1:
            let roleChooseVC = RoleChooseViewController()
            roleChooseVC.delegate = self
            self.present(roleChooseVC, animated: false)
        case 2: self.present(ModeViewController(), animated: false)
        case 4: self.navigationController?.pushViewController(GameViewController(), animated: true)
        default:
            let alertController = UIAlertController(title: "敬请期待", message: "该功能正在制作中......", preferredStyle: .alert)
            let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
            }
            alertController.addAction(knownAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func passValue(value: Int) {
        print("接收到的值为：\(value)")
        let roleDate = roleData[value]
        roleImageBox.image = UIImage(named: roleDate["插画"]!)
    }
    
}

