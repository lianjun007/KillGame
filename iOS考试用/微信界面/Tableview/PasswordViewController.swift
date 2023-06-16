//
//  PasswordViewController.swift
//  Tableview
//
//  Created by QHuiYan on 2023/6/15.
//

import UIKit

class PasswordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 加载userName.plist中的数据
    let userDataDict = userData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userDataDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let lable1 = UILabel()
        lable1.text = userDataDict["qhuiyan"]
        cell.addSubview(lable1)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    

}
