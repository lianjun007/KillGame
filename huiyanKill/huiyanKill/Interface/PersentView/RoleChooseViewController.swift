
import UIKit

// 通知传值用的协议
protocol RoleChooseViewControllerDelegate: AnyObject {
    func passValue(value: Int)
}

class RoleChooseViewController: UIViewController, UIScrollViewDelegate {

    weak var delegate: RoleChooseViewControllerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // 跳转界面动画
        UIView.animate(withDuration: 0.5,delay: 0, options: [.curveEaseInOut], animations: { [self] in
            view.backgroundColor = backgroundColor
            navButtonArray[0].backgroundColor = buttonColor
            navButtonArray[0].setTitle("取消", for: .normal)
            navButtonArray[1].backgroundColor = buttonColor
            navButtonArray[1].setTitle("选择扩展", for: .normal)
            navButtonArray[1].frame.size.width = safeSize.width - buttonSize.width + controlSpaced
            navButtonArray[1].frame.origin.x = CGFloat(buttonSize.width + controlSpaced)
            for i in 0 ..< roleData.count {
                self.chooseRoleBoxArray[i].alpha = 1
            }
        })

    }

    var roleShowcaseOffsetY = CGFloat() // 接收滚动展示柜(roleShowcase)的Y轴偏移量
    var chooseRoleBoxArray: Array<UIButton> = [] // 接收选择角色框(chooseRoleBox)的数组
    var navbuttonCount = Int() // 传递导航栏(navigationBar)中的按钮数目

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建摆放选择角色框(chooseRoleBox)的角色滚动展示柜(roleScrollShowcase)
        let correctionValue = roleData.count % 6 == 0 ? 0: 1 // 修正角色滚动展示柜(roleScrollShowcase)的内容尺寸高度参数
        let roleScrollShowcase = UIScrollView(frame: CGRect(origin: CGPoint(x: safePoint.x, y: 0), size: CGSize(width: safeSize.width, height: screenHeight)))
        roleScrollShowcase.contentSize = CGSize(width: safeSize.width, height: CGFloat((safeSize.width - controlSpaced * 5) / 4 + controlSpaced) * CGFloat((roleData.count - roleData.count % 6) / 6 + correctionValue) + buttonSize.height + safePoint.y)
        roleScrollShowcase.showsVerticalScrollIndicator = false
        view.addSubview(roleScrollShowcase)

        roleScrollShowcase.delegate = self
        roleShowcaseOffsetY = roleScrollShowcase.contentOffset.y

        // 循环创建选择角色框(chooseRoleBox)和其上的名称标签(nameLabel)
        for i in 0 ..< roleData.count {

            // 兼容没有设置角色名和插画名的半成品角色
            var roleData = roleData[i]
            if roleData["插画"]!.isEmpty {
                roleData["插画"] = "DefaultRole.jpeg"
            } else if roleData["角色"]!.isEmpty {
                roleData["角色"] = "敬请期待"
            }

            // 创建角色框(chooseRoleBox)
            let chooseRoleBox = UIButton(frame: CGRect(origin: displayMode == 0 ? CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced): CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced), size: roleBoxSize))
            chooseRoleBox.backgroundColor = backgroundColor
            chooseRoleBox.setImage(UIImage(named: roleData["插画"]!), for: .normal)
            chooseRoleBox.imageView?.contentMode = .scaleAspectFill
            chooseRoleBox.layer.masksToBounds = true
            chooseRoleBox.layer.cornerRadius = controlRoundSize
            chooseRoleBox.layer.borderWidth = thinBorderWidth
            chooseRoleBox.layer.borderColor = borderColor

            chooseRoleBox.alpha = 0
            chooseRoleBox.tag = i

            // 重新排列选择角色框(chooseRoleBox)的原点
            switch i % 6 {
            case 0: chooseRoleBox.frame.origin.x += CGFloat(0) * (controlSpaced + chooseRoleBox.frame.width)
            case 1: chooseRoleBox.frame.origin.x += CGFloat(1) * (controlSpaced + chooseRoleBox.frame.width)
            case 2: chooseRoleBox.frame.origin.x += CGFloat(2) * (controlSpaced + chooseRoleBox.frame.width)
            case 3: chooseRoleBox.frame.origin.x += CGFloat(3) * (controlSpaced + chooseRoleBox.frame.width)
            case 4: chooseRoleBox.frame.origin.x += CGFloat(4) * (controlSpaced + chooseRoleBox.frame.width)
            case 5: chooseRoleBox.frame.origin.x += CGFloat(5) * (controlSpaced + chooseRoleBox.frame.width)
            default:
                break
            }
            let num = (i - i % 6) / 6
            chooseRoleBox.frame.origin.y += CGFloat(chooseRoleBox.frame.size.height + controlSpaced) * CGFloat(num)

            chooseRoleBox.addTarget(self, action: #selector(roleBoxClickEvents), for: .touchUpInside)
            chooseRoleBoxArray.append(chooseRoleBox)
            roleScrollShowcase.addSubview(chooseRoleBox)

            // 创建选择角色框(chooseRoleBox)上的名称标签(nameLabel)
            let nameLabel = UILabel()
            nameLabel.backgroundColor = UIColor(cgColor: borderColor)
            nameLabel.text = roleData["角色"]
            nameLabel.textColor = fontColor
            nameLabel.textAlignment = .center
            chooseRoleBox.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: chooseRoleBox.topAnchor, constant: chooseRoleBox.frame.size.height / 4 * 3),
                nameLabel.leadingAnchor.constraint(equalTo: chooseRoleBox.leadingAnchor, constant: thinBorderWidth),
                nameLabel.trailingAnchor.constraint(equalTo: chooseRoleBox.trailingAnchor, constant: -thinBorderWidth),
                nameLabel.bottomAnchor.constraint(equalTo: chooseRoleBox.bottomAnchor, constant: -(chooseRoleBox.frame.size.height / 8))
            ])

        }

        // 调用navigationBarBuild()函数创建顶部导航栏
        navbuttonCount = 2
        navButtonArray = navigationBarBuild(view: view, direction: true, buttonCount: navbuttonCount, buttonContent: [["arrowshape.backward", "person"], ["返回首页", "角色选择"]], bounce: false)
        for i in 0 ..< navbuttonCount {
            navButtonArray[i].tag = i
            navButtonArray[i].addTarget(self, action: #selector(navButtonClickEvents), for: .touchUpInside)
        }
        
    }

    // 选择角色框(chooseRoleBox)关联的角色框点击事件(roleBoxClickEvents)方法
    @objc func roleBoxClickEvents(sender: UIButton) {

        // 获取角色"状态"判断触发不同的点击事件
        if roleData[sender.tag]["状态"] == "可用" {
            delegate?.passValue(value: sender.tag)
            self.dismiss(animated: false)
        } else {
            let alertController = UIAlertController(title: "敬请期待", message: "角色正在赶来中......", preferredStyle: .alert)
            let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
            }
            alertController.addAction(knownAction)
            self.present(alertController, animated: true)
        }

    }
    
    @objc func navButtonClickEvents(sender: UIButton) {
        
        switch sender.tag {
        case 0: self.dismiss(animated: false)
        case 1:
            let alertController = UIAlertController(title: "敬请期待", message: "功能正在制作中......", preferredStyle: .alert)
            let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
            }
            alertController.addAction(knownAction)
            self.present(alertController, animated: true)
        default:
            break
        }
        
    }

    var navButtonArray: Array<UIButton> = []
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取UIScrollView的偏移量
        let offsetY = roleShowcaseOffsetY
        let alpha = (offsetY - (controlSpaced)) / navButtonArray[1].frame.height
        if offsetY >= controlSpaced {
            for i in 0 ... navbuttonCount {
                navButtonArray[i].alpha = 1 - alpha / 2
            }
        } else if navButtonArray[navbuttonCount].alpha == 0 {
            navButtonArray[navbuttonCount].isUserInteractionEnabled = false
            navigationBar.isUserInteractionEnabled = false
        } else {
            for i in 0 ... navbuttonCount {
                navButtonArray[i].alpha = 1
                navButtonArray[i].isUserInteractionEnabled = true
                navigationBar.isUserInteractionEnabled = true
            }
        }
    }

}
