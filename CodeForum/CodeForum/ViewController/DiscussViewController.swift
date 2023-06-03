
import UIKit

class DiscussViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "发现更多"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.frame = view.frame
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        let index = indexPath.row % 7
        let cellView = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: mediumControl))
        cellView.setImage(UIImage(named: index1[index]["name"]!), for: .normal)
        cellView.imageView?.contentMode = .scaleAspectFill
        cellView.layer.cornerRadius = basicCornerRadius(cellView.frame.size)
        cellView.clipsToBounds = true
        cellView.tag = index + 7
        cellView.addTarget(self, action: #selector(click), for: .touchUpInside)
        cell.addSubview(cellView)
        
        // 设置精选文章信息区域的高斯模糊背景
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        if index == 2 || index == 3 || index == 4 {
            blurView.frame = CGRect(x: cellView.frame.width / 5 * 2, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
        } else {
            blurView.frame = CGRect(x: 0, y: 0, width: cellView.frame.width - cellView.frame.width / 5 * 2, height: cellView.frame.height + 1)
        } // 判断模糊应该在左边还是右边
        blurView.isUserInteractionEnabled = false
        cellView.addSubview(blurView)
        
        // 创建封面图视图
        let imageView = UIImageView(image: UIImage(named: index1[index]["name"]!))
        imageView.frame = CGRect(x: blurView.frame.origin.x == 0 ? blurView.frame.origin.x + blurView.frame.width - 1: 0, y: 0, width: cellView.frame.width - blurView.frame.width + 1, height: cellView.frame.height)
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cellView.addSubview(imageView)
        
        // 设置精选文章的标题
        let essayLabel = UILabel(frame: CGRect(x: blurView.frame.origin.x + spacedForControl, y: 0, width: blurView.frame.width - spacedForControl * 2, height: 0))
        essayLabel.text = index1[index]["name"]
        essayLabel.font = UIFont.systemFont(ofSize: CGFloat(titleFont3), weight: .bold)
        // 根据字符串长度赋予不同行数,最多为两行
        if isTruncated(essayLabel) {
            essayLabel.numberOfLines += 1
        }
        essayLabel.sizeToFit()
        essayLabel.frame.size.width = blurView.frame.width - spacedForControl * 2
        essayLabel.isUserInteractionEnabled = false
        cellView.addSubview(essayLabel)
        
        // 设置精选文章的作者名
        let essayLabel2 = UILabel()
        essayLabel2.text = index1[index]["author"]
        essayLabel2.font = UIFont.systemFont(ofSize: basicFont, weight: .regular)
        essayLabel2.sizeToFit()
        essayLabel2.isUserInteractionEnabled = false
        cellView.addSubview(essayLabel2)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return mediumControl
    }
    
    @objc func click(_ sender: UIButton) {
        let b = CourseViewController()
        let a = PaperViewController()
        if sender.tag < 7 {
            self.navigationController?.pushViewController(b, animated: true)
        } else {
            self.navigationController?.pushViewController(a, animated: true)
        }
    }
    
}
