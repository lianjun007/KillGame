import UIKit

class SearchViewController: UIViewController {
    
    let searchControllerInstance = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "开始搜索"
        let pickerView = UISegmentedControl()

        navigationItem.searchController = searchControllerInstance
        searchControllerInstance.searchBar.searchTextField.inputView = pickerView
        navigationController?.navigationBar.prefersLargeTitles = true

        searchControllerInstance.searchBar.placeholder = "搜索所有内容"
        searchControllerInstance.obscuresBackgroundDuringPresentation = false
        searchControllerInstance.searchBar.searchTextField.backgroundColor = .systemBackground
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scroll.contentSize = CGSize(width: screenWidth, height: screenHeight * 2)
        view.addSubview(scroll)
        
    }

}
