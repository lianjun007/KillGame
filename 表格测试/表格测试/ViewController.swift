import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let items = ["Item 1", "Item 2", "Item 3"]
//    // 设置 UICollectionView 的行高和行宽
    let layout = UICollectionViewFlowLayout()
    
    
//
//    // 设置 UICollectionView 的行间距
//    layout.minimumLineSpacing = 10.0
//    layout.minimumInteritemSpacing = 10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionView = UICollectionView(frame: CGRect(x: 20, y: 120, width: 400, height: 300), collectionViewLayout: layout)
        
        layout.minimumInteritemSpacing = 0
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.systemFill
        collectionView.layer.borderWidth = 1
        view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.layer.borderWidth = 0.5
        let label = UILabel(frame: CGRectZero)
        label.text = items[indexPath.row]
        label.sizeToFit()
        layout.itemSize = label.frame.size
        cell.addSubview(label)
        return cell
    }

}
