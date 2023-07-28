
import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerInitialize(vc: self, navTitle: "偏好设置")
        

    }

}


//        // 通过方法moduleTitleBuild创建模块标题（该方法后期修改为结构体）
//        let moduleTitle = moduleTitleBuild(title, settingModule, 0, interaction: false)




/// 创建设置模块的单个控件的结构体
///
/// 单个设置的控件由说明、控件和提示组成，`Setting`依靠下面这个方法来生成设置控件
/// ```swift
/// controlBuild(caption: String, control: Array<controlMode>, tips: String) -> Array<UIView>
/// ```
///
/// - Note: `controlBuild(caption: String, control: Array<controlMode>, tips: String) -> Array<UIView>`有三个重载方法，分别可以省略`caption`、`tips`、`control`和`tips`
struct Setting {
    /// 设置行的类型枚举值
    enum controlMode: Int {
        // 继承Int协议目的是让custom1、custom2、custom3、custom4分别有对应的rawValue来判断高度倍数，切记顺序不可打乱
        /// 自定义设置行，`custom`后的数字对应高度倍数（44pt的倍数）
        case custom, custom1, custom2, custom3, custom4
        case forward, toggle
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter caption: `String`，说明，显示在控件的上方
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    /// - Parameter tips: `String`，提示，显示在控件的下方
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(caption: String, control: Array<controlMode>, tips: String) -> Array<UIView> {
        controlBuildCenter(caption, control, tips)
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法（不含提示`tips`）
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter caption: `String`，说明，显示在控件的上方
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(caption: String, control: Array<controlMode>) -> Array<UIView> {
        controlBuildCenter(caption, control, "")
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法（不含说明`caption`）
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    /// - Parameter tips: `String`，提示，显示在控件的下方
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(control: Array<controlMode>, tips: String) -> Array<UIView> {
        controlBuildCenter("", control, tips)
    }
    
    /// 创建设置模块的单个控件的结构体的传参方法（只有控件主体`control`）
    ///
    /// # 使用方法
    /// 暂无
    ///
    /// 通过引用其他方法来创建整个设置模块，需要传递一个该设置模块的标题以及若干个说明和提示
    /// - Parameter control: `Array<controlMode>`，控件主体，数组内是一个枚举值，`forward`表示跳转类型设置，`toggle`表示开关设置（传出标准尺寸的开关设置行），`custom`表示自定义设置
    ///
    /// - Note: 整个控件的主体部分的行数为`control`参数的元素数。返回值的数组的第`0`个元素为整个控件的`UIView`，其余按顺序为各行
    ///
    /// - Returns: `Array<UIView>`
    ///
    /// # 返回值介绍
    /// **整个控件**：`UIView`，一般在外界设置这个`UIView`的原点`UIView.frame.origin`
    ///
    /// **forward**：`UIButton`，标准尺寸跳转行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，并且用`addTarget()`关联上跳转界面的方法
    ///
    /// **toggle**：`UIButton`，标准尺寸的开关设置行的整行，一般调用`UIButton`的`setTitle()`方法添加内容，然后遍历其子视图找到`UISwitch`并且关联上方法
    ///
    /// **custom**：`UIView`，自定义设置块的整个视图，在这个`UIView`上做手脚
    static func controlBuild(control: Array<controlMode>) -> Array<UIView> {
        controlBuildCenter("", control, "")
    }
}

// Setting的扩展，扩展内的都是私有属性或方法(或者是不建议外部使用)
extension Setting {
    /// 创建设置模块的单个控件的结构体的枢纽方法
    private static func controlBuildCenter(_ caption: String,_ control: Array<controlMode>,_ tips: String) -> Array<UIView> {
        /// 作为返回值的数组（`returnArray`），接收所有返回值
        var returnArray: Array<UIView> = []
        
        /// 设置控件最底层的`UIView`
        let settingControl = UIView()
        settingControl.frame.origin = CGPointZero
        settingControl.frame.size.width = Screen.basicWidth()
        returnArray.append(settingControl) // 添加到返回值的数组(returnArray)
        
        /// 控件上方的说明（`caption`）部分
        let captionLabel = UILabel().fontAdaptive(caption, font: Font.tips())
        if !caption.isEmpty {
            captionLabel.frame.origin = CGPoint(x: Spaced.screen(), y: 0)
            captionLabel.frame.size.width = Screen.basicWidth() - Spaced.screen() * 2
            captionLabel.textColor = UIColor.black.withAlphaComponent(0.6)
            settingControl.addSubview(captionLabel)
        }
        
        /// 设置控件主体的`UIView`
        let settingTable = UIView()
        settingTable.frame.origin = CGPoint(x: 0, y: caption.isEmpty ? 0: captionLabel.frame.maxY + 6)
        settingTable.frame.size.width = Screen.basicWidth()
        settingTable.backgroundColor = Color.setting()
        settingTable.layer.cornerRadius = 12
        settingControl.addSubview(settingTable)

        // 通过循环创建每一行设置
        for (index, item) in control.enumerated() {
            var row = UIView()
            switch item {
            case .forward: row = forward() // 跳转界面类型的设置行
            case .toggle: row = toggle() // 开关类型的设置行
            case .custom: break
            default: row = custom(item) // 自定义设置行
            }
            // 配置这些行的通用参数
            row.frame.origin = CGPoint(x: 0, y: returnArray[index].frame.maxY)
            row.frame.size.width = Screen.basicWidth()
            settingTable.addSubview(row)
            returnArray.append(row) // 添加到返回值的数组(returnArray)
            
            // 创建各个设置行之间的分割线
            if index != 0 {
                // 固定Y轴的值
                let pointY = returnArray[index].frame.maxY - 0.25
                // 创建线条的首尾点
                let segmentedLinePath = UIBezierPath()
                segmentedLinePath.move(to: CGPoint(x: 20, y: pointY))
                segmentedLinePath.addLine(to: CGPoint(x: Screen.basicWidth(), y: pointY))
                // 创建线条并且设置相关属性
                let segmentedLine = CAShapeLayer()
                segmentedLine.path = segmentedLinePath.cgPath
                segmentedLine.strokeColor = Color.segmentedLine().cgColor
                segmentedLine.lineWidth = 0.5
                settingTable.layer.addSublayer(segmentedLine)
            }
        }
        
        /// 控件下方的提示（`tips`）部分
        let tipsLabel = UILabel().fontAdaptive(caption, font: Font.tips())
        if !caption.isEmpty {
            tipsLabel.frame.origin = CGPoint(x: Spaced.screen(), y: returnArray[control.count].frame.maxY + 6)
            captionLabel.frame.size.width = Screen.basicWidth() - Spaced.screen() * 2
            captionLabel.textColor = UIColor.black.withAlphaComponent(0.6)
            settingControl.addSubview(captionLabel)
        }
        
        // 设置底层和主体试图的height
        settingTable.frame.size.height = returnArray[control.count].frame.maxY
        settingControl.frame.size.height = tipsLabel.frame.maxY
        
        return returnArray
    }
    
    /// 创建设置控件的单行（跳转界面类型）
    private static func forward() -> UIButton {
        /// 设置控件的单行
        let row = UIButton()
        row.frame.size.height = 44
        
        /// 设置控件跳转类型行的跳转箭头图标
        let rowIcon = UIImageView(frame: CGRect(x: Screen.basicWidth() - 25, y: 14, width: 10, height: 16))
        rowIcon.image = UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        rowIcon.tintColor = UIColor.black.withAlphaComponent(0.5)
        row.addSubview(rowIcon)
        
        return row
    }
    /// 创建设置控件的单行（开关类型）
    private static func toggle() -> UIButton {
        /// 设置控件的单行
        let row = UIButton()
        row.frame.size.height = 44
        
        /// 设置控件开关类型行的开关
        let rowSwitch = UISwitch()
        rowSwitch.frame.origin = CGPoint(x: Screen.basicWidth() - 67, y: 7)
        row.addSubview(rowSwitch)
        
        return row
    }
    private static func custom(_ sender: Setting.controlMode) -> UIView {
        /// 匹配`custom`的原始值来判断高度倍数
        let parameter: CGFloat = CGFloat(sender.rawValue)
        
        /// 设置控件的单行
        let row = UIView()
        row.frame.size.height = 44 * parameter
        
        return row
    }
}
