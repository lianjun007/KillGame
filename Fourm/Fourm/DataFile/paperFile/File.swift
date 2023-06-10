//
//  File.swift
//  Fourm
//
//  Created by QHuiYan on 2023/6/7.
//

import Foundation

func FeaturedPaperFile0() -> Array<String> {
    return ["title",
            "iOS开发之ReplayKit录屏",
            
            "title2",
            "介绍",
            
            "body",
            """
            iOS中使用`RPScreenRecorder`进行专门的录屏操作。
            开始录屏时会弹出授权对话框，录制过程中是无感的，停止录制之后可以弹出录制的预览界面，然后可以保存到相册。录屏的同时可以录制麦克风的声音与摄像头的内容。
            需要导入`ReplayKit模块`。
            """,
    
            "title2",
            "案例",
            
            "code",
            """
            import ReplayKit
            import UIKit

            class ViewController: UIViewController {
                // 显示摄像头
                var cameraView: UIView?

                override func viewDidLoad() {
                    super.viewDidLoad()

                    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "开始录屏",
                                                                        style: .plain,
                                                                        target: self,
                                                                        action: #selector(startRecording))
                }

                @objc func startRecording() {
                    guard RPScreenRecorder.shared().isAvailable else { return }
                    // 获取RPScreenRecorder
                    let recorder = RPScreenRecorder.shared()
                    // 开启麦克风
                    recorder.isMicrophoneEnabled = true
                    // 开启摄像头
                    recorder.isCameraEnabled = true
                    // 摄像头类型（前、后摄像头）
                    recorder.cameraPosition = .front
                    // 开始录制
                    recorder.startRecording { [unowned self] error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "停止录屏",
                                                                                     style: .plain,
                                                                                     target: self,
                                                                                     action: #selector(self.stopRecording))
                            // 设置摄像头
                            guard let cameraView = recorder.cameraPreviewView else { return }
                            cameraView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
                            cameraView.center = view.center
                            view.addSubview(cameraView)
                            self.cameraView = cameraView
                        }
                    }
                }

                @objc func stopRecording() {
                    let recorder = RPScreenRecorder.shared()
                    // 停止录制
                    recorder.stopRecording { [unowned self] preview, _ in
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "开始录屏",
                                                                                 style: .plain,
                                                                                 target: self,
                                                                                 action: #selector(self.startRecording))
                        if let preview = preview {
                            // 设置代理
                            preview.previewControllerDelegate = self
                            self.present(preview, animated: true)
                        }
                    }
                    cameraView?.removeFromSuperview()
                }
            }

            extension ViewController: RPPreviewViewControllerDelegate {
                // MARK: 完成预览
                func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
                    dismiss(animated: true)
                }
            }
            """,
            "body",
            "注意：需要在真机运行测试。"
    ]
}
