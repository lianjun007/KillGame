//
//  SizeFile.swift
//  huiyanKill
//
//  Created by QHuiYan on 2023/3/22.
//

import Foundation
import UIKit

// 框架的基本属性
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let screenSpaced = screenHeight / 20
let controlSpaced = screenSpaced / 2

// 定义safePoint和safeSize
let window = UIApplication.shared.windows.first //
var safeAreaInset = window?.safeAreaInsets ?? UIEdgeInsets.zero
// 判定显示模式
var safePoinAxisX = safeAreaInset.left
var displayMode = 0
func getDisplayMode() {
    if safeAreaInset.left <= screenSpaced {
        safePoinAxisX = screenSpaced
    } else {
        displayMode = 0
    }
}
var safePoint = CGPoint(x: safeAreaInset.left, y: screenSpaced)
var safeSize = CGSize(width: screenWidth - (safeAreaInset.left + safeAreaInset.right), height: screenHeight - screenSpaced * 2)



// 默认模式下的安全尺寸和安全原点
var safeSizeAll = CGSize(width: screenWidth - (safeAreaInset.left + safeAreaInset.right), height: screenHeight - screenSpaced * 2)
var safePointAll = CGPoint(x: safeAreaInset.left, y: screenSpaced)
// 根据displayAdaptationData去改变safeSizeAll和safePointAll
func safeCG(_ dpAdData: Int) -> (CGSize, CGPoint) {
    safeAreaInset = window?.safeAreaInsets ?? safeAreaInset
    print(safeAreaInset)
    if safeAreaInset.left == 0, safeAreaInset.right == 0 {
        safePointAll = CGPoint(x: screenSpaced, y: 0)
        safeSizeAll = CGSize(width: screenWidth - screenSpaced * 2, height: screenHeight - screenSpaced)
    }
    switch dpAdData {
    case 0:
        return (safeSizeAll, safePointAll)
    case 1:
        safeSizeAll.width += safeAreaInset.right // 刘海在左侧的方案
    case 2:
        safeSizeAll.width += safeAreaInset.left
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

let rolePreviewBoxSize = CGSize(width: rlPrBoxHt * 2 / 3, height: rlPrBoxHt) // 角色框大尺寸
let buttonSize = CGSize(width: (rlPrBoxHt * 2 / 3 - controlSpaced) / 2, height: btnSizeHt) // 按钮标准尺寸
let buttonRoundSize = CGSize(width: buttonSize.height, height: buttonSize.height)


