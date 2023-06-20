
import UIKit

// 创建讨论界面
class DiscussViewController: UIViewController {
    
    let textLabel = ["ActivityIndicator", "ProgressView", "Control", "Picker", "ScrollView", "lunbotu", "DataView", "ScrollView"]
    
    var buttonArray: Array<UIButton> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "讨论"
        
        let safeView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .insetGrouped)
        // safeView.rowHeight = screenHeight / 5
        safeView.separatorStyle = .none
        safeView.backgroundColor = .systemBackground
        // safeView.isEditing = true
        
        safeView.dataSource = self
        safeView.delegate = self
        
        view.addSubview(safeView)
        
    }
    
}

extension DiscussViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        // cell.selectionStyle = .gray
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let view = UIView()
        view.frame.size = CGSize(width: cell.bounds.size.width, height: screenHeight / 5 - controlSpaced)
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 15
        cell.contentView.addSubview(view)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(ActivityIndicatorViewController(), animated: true)
        case 1: self.present(ProgressViewViewController(), animated: true)
        case 2: self.present(Control(), animated: true)
        case 3: self.present(Picker(), animated: true)
        case 4:
            let SVC = ScrollView()
            SVC.modalPresentationStyle = .currentContext
            self.present(SVC, animated: true)
        case 5: self.present(lunbotu(), animated: true)
        case 6:
            let SVC = DataViewController()
            SVC.modalPresentationStyle = .currentContext
            self.present(SVC, animated: true)
        case 7:
            let SVC = ScrollViewController()
            SVC.modalPresentationStyle = .currentContext
            self.present(SVC, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        controlSpaced
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
}
