//
//  ViewController1.swift
//  Tableview
//
//  Created by QHuiYan on 2023/6/15.
//

import UIKit

class ViewController1: UIViewController {
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置界面视图的背景色和导航栏的基础设置
        view.backgroundColor = .systemBackground
        navigationItem.title = "开始聊天"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension ViewController1: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let customView = mediumControlBuild(origin: CGPoint(x: spacedForScreen, y: 0), imageName: "aaa", title: "sefiiu", title2: "adcfiua", direction: false)
        cell.addSubview(customView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (screenWidth - spacedForScreen * 2) / 4 + spacedForScreen
    }
    
}
