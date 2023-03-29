import UIKit

class RoleChooseViewController: UIViewController, UIScrollViewDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建摆放选择角色框(chooseRoleBox)的滚动展示柜(roleShowcase)
        let roleShowcase = UIScrollView(frame: CGRect(origin: CGPoint(x: safePoint.x, y: 0), size: CGSize(width: safeSize.width, height: screenHeight)))
        roleShowcase.contentSize = CGSize(width: safeSize.width, height: CGFloat((safeSize.width - controlSpaced * 5) / 4 + controlSpaced) * CGFloat((roleData.count - roleData.count % 6) / 6 + roleData.count % 6 == 0 ? 0: 1) + buttonSize.height + safePoint.y)
        roleShowcase.showsVerticalScrollIndicator = false
        view.addSubview(roleShowcase)
        
        roleShowcase.delegate = self
        roleShowcaseOffsetY = roleShowcase.contentOffset.y
        
        // 创建选择角色框(chooseRoleBox)
        for i in 0 ..< roleData.count {
            
            // 兼容没有设置角色名和插画名的半成品角色
            var roleData = roleData[i]
            if roleData["插画"]!.isEmpty {
                roleData["插画"] = "DefaultRole.jpeg"
            } else if roleData["角色"]!.isEmpty {
                roleData["角色"] = "敬请期待"
            }
            
            // 基本设置()
            let borderWidth = CGFloat(3) // 方便同步修改角色选择框(chooseRoleBox)的边框宽度和角色选择框的名称标签(nameLabelOfChooseRoleBox)的自动布局
            let chooseRoleBox = UIButton(frame: CGRect(origin: displayMode == 0 ? CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced): CGPoint(x: 0, y: safePoint.y + buttonSize.height + controlSpaced), size: roleBoxSize))
            chooseRoleBox.backgroundColor = backgroundColor
            chooseRoleBox.setImage(UIImage(named: roleData["插画"]!), for: .normal)
            chooseRoleBox.layer.masksToBounds = true
            chooseRoleBox.layer.cornerRadius = controlRoundSize
            chooseRoleBox.layer.borderWidth = borderWidth
            chooseRoleBox.layer.borderColor = frameColor
            
            chooseRoleBox.imageView?.contentMode = .scaleAspectFill
            chooseRoleBox.alpha = 0
            chooseRoleBox.tag = i
            
            // 设置角色选择框(chooseRoleBox)的origin
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
            
            chooseRoleBoxArray.append(chooseRoleBox)
      
            
            
            
            
            roleShowcase.addSubview(chooseRoleBox)
            
            // Role Title
            let nameLabelOfChooseRoleBox = UILabel()
            nameLabelOfChooseRoleBox.backgroundColor = UIColor(cgColor: frameColor)
            nameLabelOfChooseRoleBox.text = roleData["角色"]
            nameLabelOfChooseRoleBox.textAlignment = .center
            nameLabelOfChooseRoleBox.textColor = fontColor
            chooseRoleBox.addSubview(nameLabelOfChooseRoleBox)
            nameLabelOfChooseRoleBox.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nameLabelOfChooseRoleBox.topAnchor.constraint(equalTo: chooseRoleBox.topAnchor, constant: chooseRoleBox.frame.size.height / 4 * 3),
                nameLabelOfChooseRoleBox.leadingAnchor.constraint(equalTo: chooseRoleBox.leadingAnchor, constant: borderWidth),
                nameLabelOfChooseRoleBox.trailingAnchor.constraint(equalTo: chooseRoleBox.trailingAnchor, constant: -borderWidth),
                nameLabelOfChooseRoleBox.bottomAnchor.constraint(equalTo: chooseRoleBox.bottomAnchor, constant: -(chooseRoleBox.frame.size.height / 8))
            ])
            
        }
        
        for i in 0 ..< roleData.count {
            if i < 8 {
                chooseRoleBoxArray[i].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
            } else {
                chooseRoleBoxArray[i].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
            }
        }
        
        navButtonArray = navigationBarBuild(view: view, direction: true, buttonCount: buttonCount, buttonContent: [["arrowshape.backward", "person"], ["返回首页", "角色选择"]], bounce: false)
        navButtonArray[0].addTarget(self, action: #selector(clickEvents), for: .touchUpInside)
        navButtonArray[1].addTarget(self, action: #selector(stayTuned), for: .touchUpInside)
        
    }
    

   
    
    @objc func clickEvents(sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @objc func stayTuned() {
        print(#function)
        let alertController = UIAlertController(title: "敬请期待", message: "正在制作中......", preferredStyle: .alert)
        let knownAction = UIAlertAction(title: "知道了", style: .cancel) { (action) in
        }
        alertController.addAction(knownAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var navButtonArray: Array<UIButton> = []
    let buttonCount = 2
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取UIScrollView的偏移量
        let offsetY = roleShowcaseOffsetY
        let alpha = (offsetY - (controlSpaced)) / navButtonArray[1].frame.height
        if offsetY >= controlSpaced {
            for i in 0 ... buttonCount {
                navButtonArray[i].alpha = 1 - alpha / 2
            }
        } else if navButtonArray[buttonCount].alpha == 0 {
            navButtonArray[buttonCount].isUserInteractionEnabled = false
            navigationBar.isUserInteractionEnabled = false
        } else {
            for i in 0 ... buttonCount {
                navButtonArray[i].alpha = 1
                navButtonArray[i].isUserInteractionEnabled = true
                navigationBar.isUserInteractionEnabled = true
            }
        }
    }
    
}
