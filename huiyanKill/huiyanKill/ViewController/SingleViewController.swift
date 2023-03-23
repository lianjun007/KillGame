//
//  ViewController.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/19.
//

import UIKit
import Foundation

protocol YourDelegate {
    func viewDidLoad()
}

class SingleViewController: UIViewController {
    
    @IBOutlet weak var gameStartButton: UIButton!
    @IBOutlet weak var ruleViewButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewDidLoad() // 界面出现时重新运行一遍viewDidLoad方法
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 清空所有控件
        for view in self.view.subviews {
            view.removeFromSuperview()
        }
        
        navigationItem.hidesBackButton = true
        // 每次载入后都加载坐标等数据(All ViewController)
        let safeSize = safeCG(displalyMode).0
        let safePoint = safeCG(displalyMode).1
        // 在此基础上修改
        let firstButtonPoint = CGPoint(x: safePoint.x, y: safePoint.y) // 返回主界面的坐标
        let secondButtonPoint = CGPoint(x: firstButtonPoint.x + buttonSize.width + controlSpaced, y: firstButtonPoint.y) // 顶栏第二个按钮的坐标
        let rightTopButton1Point = CGPoint(x: safeSize.width + safePoint.x - buttonRoundSize.width, y: firstButtonPoint.y) // 右上角按钮原点
        let rightTopButton2Point = CGPoint(x: rightTopButton1Point.x - buttonSize.width + buttonRoundSize.width, y: firstButtonPoint.y) // 右上角按钮原点
        let rightBottomButtonPiont = CGPoint(x: rightTopButton1Point.x, y: safeSize.height - buttonSize.height - controlSpaced)
        let roleImageBoxPoint = CGPoint(x: safePoint.x, y: safePoint.y + buttonSize.height + controlSpaced) // roleImageBox的原点
        let buttonRadius = buttonSize.height / 2
        let previewBoxPoint = CGPoint(x: safePoint.x + rolePreviewBoxSize.width + controlSpaced, y: safePoint.y)
        let previewBoxSize = CGSize(width: safeSize.width - rolePreviewBoxSize.width - controlSpaced, height: safeSize.height)
        let groundColor = UIColor.systemGray5 // 背景颜色
        let fontColor = UIColor.black // 字体颜色
        let fontSize = buttonSize.height / 2 // 字号大小
        
        // roleImageBox是插画显示区域
        let roleImageBox = UIImageView(frame: CGRect(origin: roleImageBoxPoint, size: rolePreviewBoxSize))
        roleImageBox.backgroundColor = .darkGray
        roleImageBox.layer.borderWidth = 5
        roleImageBox.layer.borderColor = UIColor.darkGray.cgColor
        roleImageBox.image = UIImage(named: "rolePreview.jpeg")
        roleImageBox.contentMode = .scaleAspectFit
        roleImageBox.layer.cornerRadius = 30
        roleImageBox.clipsToBounds = true
        view.addSubview(roleImageBox)
        
        // roleBrieflyBox是角色选择后的信息预览区域的背景
        let roleBrieflyBox = UIScrollView(frame: CGRect(x: safePoint.x + rolePreviewBoxSize.width + controlSpaced, y: 0, width: screenWidth - rolePreviewBoxSize.width - buttonSize.width - controlSpaced * 2, height: screenHeight))
        roleBrieflyBox.backgroundColor = groundColor
        roleBrieflyBox.indicatorStyle = .white
        roleBrieflyBox.contentSize = CGSize(width: screenWidth - rolePreviewBoxSize.width - buttonSize.width - controlSpaced * 2, height: 400 * 5)

        // roleDataLabel是角色选择后的信息预览区域中的文本框
        var roleDataLabel: [UILabel] = []
        for i in 0 ... 4 {
            roleDataLabel.append(UILabel(frame: CGRect(x: 20, y: i * 20 + 10, width: 200, height: 40)))
            roleDataLabel[i].textColor = .white
            roleDataLabel[i].text = ""
            roleBrieflyBox.addSubview(roleDataLabel[i])
        }
        view.addSubview(roleBrieflyBox)
        
        // previewBox是信息预览区域的背景框
        let previewBox = UIView(frame: CGRect(origin: previewBoxPoint, size: previewBoxSize))
        previewBox.layer.borderWidth = 5
        previewBox.layer.borderColor = CGColor(red: 0, green: 0, blue: 1, alpha: 1)
        previewBox.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0))
        previewBox.isUserInteractionEnabled = false
        previewBox.layer.cornerRadius = 30
        view.addSubview(previewBox)
        
        // 还没做的返回按钮
        let backStartButton = UIButton(frame: CGRect(origin: firstButtonPoint, size: buttonRoundSize))
        backStartButton.setImage(UIImage(systemName: "arrowshape.backward"), for: .normal)
        backStartButton.setTitle("", for: .normal)
        backStartButton.tintColor = groundColor
        backStartButton.backgroundColor = groundColor
        backStartButton.layer.cornerRadius = buttonRadius
        view.addSubview(backStartButton)
        
        // roleChooseButton是角色选择按钮
        let roleChooseButton = UIButton(frame: CGRect(origin: firstButtonPoint, size: buttonSize))
        roleChooseButton.layer.cornerRadius = buttonRadius
        roleChooseButton.tintColor = fontColor
        roleChooseButton.setImage(UIImage(systemName: "person.fill.questionmark.rtl"), for: .normal)
        roleChooseButton.setTitle("角色", for: .normal)
        let fontRoChBtnSize = Int(fontSize) * 2 / (roleChooseButton.titleLabel?.text?.count ?? 2)
        roleChooseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: CGFloat(fontRoChBtnSize))
        roleChooseButton.titleLabel?.adjustsFontSizeToFitWidth = true
        roleChooseButton.setTitleColor(fontColor, for: .normal)
        roleChooseButton.backgroundColor = groundColor
        view.addSubview(roleChooseButton)
        
        // 给roleChooseButton按钮添加菜单
        var roleChooseArray: [UIAction] = []
        for i in 0 ..< roleDate.count {
            let roleChooseAction = UIAction(title: roleDate[i]?["角色"] ?? "未知", image: UIImage(systemName: "person")) { [self] _ in
                roleChoose = i
                roleIsChoose = true
                roleChooseButton.setTitle("\(roleDate[i]?["角色"] ?? "未知")", for: .normal)
                roleChooseButton.setImage(UIImage(systemName: "person.fill.checkmark.rtl"), for: .normal)
                // 改变角色插画显示区域的图片
                let roleImageName = roleDate[i]?["插画"] ?? ""
                let roleImage = UIImage(named: roleImageName)
                roleImageBox.image = roleImage
                // 改变信息预览区域的文本
                roleDataLabel[0].text = "角色：\(roleDate[i]?["角色"] ?? "未知")"
                roleDataLabel[1].text = "生命：\(roleDate[i]?["生命"] ?? "未知")"
                roleDataLabel[2].text = "体力：\(roleDate[i]?["体力"] ?? "未知")"
                roleDataLabel[3].text = "攻击：\(roleDate[i]?["攻击"] ?? "未知")"
                roleDataLabel[4].text = "防御：\(roleDate[i]?["防御"] ?? "未知")"
            }
            roleChooseArray.append(roleChooseAction)
        }
        let roleChooseMenu = UIMenu(title: "选择本局游戏你要使用的角色", children: roleChooseArray)
        roleChooseButton.menu = roleChooseMenu
        roleChooseButton.showsMenuAsPrimaryAction = true
        
        // roleCountButton是人数选择按钮
        let roleCountButton = UIButton(frame: CGRect(origin: secondButtonPoint, size: buttonSize))
        roleCountButton.layer.cornerRadius = buttonRadius
        roleCountButton.setImage(UIImage(systemName: "person.fill.checkmark.rtl"), for: .normal)
        roleCountButton.setTitle("设定", for: .normal)
        roleCountButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        roleCountButton.setTitleColor(fontColor, for: .normal)
        roleCountButton.tintColor = fontColor
        roleCountButton.backgroundColor = groundColor
        view.addSubview(roleCountButton)
        
        // 给roleCountButton按钮添加菜单
        var roleCountArray: [UIAction] = []
        for i in 0 ... 6 {
            let roleCountAction = UIAction(title: "游戏人数：\(i + 2)", image: UIImage(systemName: "person")) { [self] _ in
                roleIsCount = true
                roleCount = i + 2
                // 改变roleCountButton的显示内容
                roleCountButton.setTitle("人数:\(i + 2)", for: .normal)
                roleCountButton.backgroundColor = .darkText
            }
            roleCountArray.append(roleCountAction)
        }
        let roleCountMenu = UIMenu(title: "选择本局游戏的参与人数", children: roleCountArray)
        roleCountButton.menu = roleCountMenu
        roleCountButton.showsMenuAsPrimaryAction = true
        
        // roleViewButton是转到roleViewController的按钮
        ruleViewButton.frame = CGRect(origin: rightTopButton2Point, size: buttonRoundSize)
        ruleViewButton.layer.cornerRadius = buttonRadius
        ruleViewButton.setImage(UIImage(systemName: "books.vertical"), for: .normal)
        ruleViewButton.setTitle("", for: .normal)
        ruleViewButton.tintColor = .white
        ruleViewButton.backgroundColor = groundColor
        view.addSubview(ruleViewButton)
        
        // settingViewButton是转到SettingViewController的按钮
        let settingViewButton = UIButton(frame: CGRect(origin: rightTopButton1Point, size: buttonRoundSize))
        settingViewButton.layer.cornerRadius = buttonRadius
        settingViewButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingViewButton.setTitle("", for: .normal)
        settingViewButton.tintColor = fontColor
        settingViewButton.backgroundColor = groundColor
        settingViewButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        view.addSubview(settingViewButton)
        
        // gameStartButton是转到GameViewController的按钮
        gameStartButton.frame = CGRect(origin: rightBottomButtonPiont, size: buttonSize)
        gameStartButton.layer.cornerRadius = buttonRadius
        gameStartButton.setTitle("开始游戏", for: .normal)
        gameStartButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        gameStartButton.tintColor = .white
        gameStartButton.backgroundColor = groundColor
        view.addSubview(gameStartButton)
        
    }
    
    // 跨界面传递临时变量
    var roleCount = 0
    var roleChoose = 0
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            let gameViewController = segue.destination as! GameViewController
            gameViewController.roleChoose = self.roleChoose
            gameViewController.roleCount = self.roleCount
        }
    }
    
    // 点击按钮弹出界面
    @objc func clickButton() {
        self.present(SettingViewController(), animated: true, completion: nil)
    }
    
    var roleIsChoose = false // 判断是否选择了角色
    var roleIsCount = false // 判断是否选择了人数
    // 重写shouldPerformSegue方法实现手动控制跳转界面
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // 如果游戏设置项目完成
        if identifier == "toGame" {
            if roleIsChoose && roleIsCount {
                return true
            }
        } else if identifier == "toRule" {
            return true
        }
        // 如果游戏设置项目未完成
        var tipsMessage = ""
        if !roleIsChoose {
            tipsMessage.append("请选择本局游戏你要使用的角色")
        }
        if !roleIsCount {
            if !tipsMessage.isEmpty {
                tipsMessage.append("\n")
            }
            tipsMessage.append("请选择本局游戏的参与人数")
        }
        // gameSettingTips是游戏设置项目未完成时触发segue(toGame)后弹出的对话框
        let gameSettingTips = UIAlertController(title: "无法开始游戏", message: tipsMessage, preferredStyle: .alert)
        gameSettingTips.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
        self.present(gameSettingTips, animated: true, completion: nil)
        return false
    }
    
}
