//
//  GameFile.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/24.
//

import Foundation
import UIKit

var player = 2

var button111 = UIButton()
let firstButtonPoint = CGPoint(x: safePointAll.x, y: safePointAll.y) // 返回主界面的坐标
class gameProcess {
    func gameBefore() {
        print(#function)
    }
    func playerAction() {
        button111 = UIButton(frame: CGRect(origin: firstButtonPoint, size: buttonSize))
        button111.layer.cornerRadius = 15
        button111.tintColor = .black
        button111.setImage(UIImage(systemName: "person.fill.questionmark.rtl"), for: .normal)
        button111.setTitle("角色", for: .normal)
        button111.titleLabel?.adjustsFontSizeToFitWidth = true
        button111.backgroundColor = .systemGray5
        button111.addTarget(self, action: #selector(gameProcess.huihejieshu), for: .touchUpInside)
        view.addSubview(button111)
        print(#function)
    }
    static func playerAction2() {
        let button = UIButton(frame: CGRect(origin: safePointAll, size: buttonSize))
        button.setTitle("回合2", for: .normal)
        button.addTarget(self, action: #selector(gameProcess.huihejieshu), for: .touchUpInside)
    }
    @objc static func huihejieshu() {
        gameProcess.playerAction2()
    }
}
