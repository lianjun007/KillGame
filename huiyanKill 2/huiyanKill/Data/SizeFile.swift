//
//  SizeFile.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/22.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width // 屏幕宽度
let screenHeight = UIScreen.main.bounds.height // 屏幕高
let screenSpaced = screenHeight / 20 // 与屏幕的边距

var displayAdaptationData = 0 // 显示模式适配模式码
// 获取窗口和安全视图指南
let window = UIApplication.shared.windows.first //
var safeArea = window?.safeAreaInsets ?? UIEdgeInsets.zero
// 默认模式下的安全尺寸和安全原点
var safeSizeAll = CGSize(width: screenWidth - (safeArea.left + safeArea.right), height: screenHeight - screenSpaced * 2)
var safePointAll = CGPoint(x: safeArea.left, y: screenSpaced)
// 根据displayAdaptationData去改变safeSizeAll和safePointAll
func safeCG(_ dpAdData: Int) -> (CGSize, CGPoint) {
    safeArea = window?.safeAreaInsets ?? safeArea
    if safeArea.left == 0, safeArea.right == 0 {
        safePointAll = CGPoint(x: screenSpaced, y: 0)
        safeSizeAll = CGSize(width: screenWidth - screenSpaced * 2, height: screenHeight - screenSpaced)
    }
    switch dpAdData {
    case 0:
        return (safeSizeAll, safePointAll)
    case 1:
        safeSizeAll.width += safeArea.right // 刘海在左侧的方案
    case 2:
        safeSizeAll.width += safeArea.left
        safePointAll = CGPointZero // 刘海在右侧的方案
    case 3:
        safeSizeAll.width = screenWidth
        safePointAll = CGPointZero // 忽略刘海的方案
    case 4:
        safeSizeAll = CGSize(width: screenWidth, height: screenHeight)
        safePointAll = CGPointZero // 全屏方案
    default:
        break
    }
    return (safeSizeAll, safePointAll)
}

let rlPrBoxHt = safeSizeAll.height - controlSpaced - btnSizeHt // rolePreviewBox的标准高度
let btnSizeHt = safeSizeAll.height / 10
let controlSpaced = btnSizeHt / 3 // 控件之间的间距
let rolePreviewBoxSize = CGSize(width: rlPrBoxHt * 2 / 3, height: rlPrBoxHt) // 角色框大尺寸
let buttonSize = CGSize(width: (rlPrBoxHt * 2 / 3 - controlSpaced) / 2, height: btnSizeHt) // 按钮标准尺寸
let buttonRoundSize = CGSize(width: buttonSize.height, height: buttonSize.height)


