import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllers = [
            UINavigationController(rootViewController: DiscussViewController().withTabBarItem(title: "课程", image: UIImage(systemName: "books.vertical"), selectedImage: UIImage(systemName: "books.vertical.fill"))),
            UINavigationController(rootViewController: CourseViewController().withTabBarItem(title: "讨论", image: UIImage(systemName: "person.2"), selectedImage: UIImage(systemName: "person.2.fill"))),
            UINavigationController(rootViewController: ViewController3().withTabBarItem(title: "收藏", image: UIImage(systemName: "star.square.on.square"), selectedImage: UIImage(systemName: "star.square.on.square.fill"))),
            UINavigationController(rootViewController: ViewController4().withTabBarItem(title: "搜索", image: UIImage(systemName: "rectangle.and.hand.point.up.left"), selectedImage: UIImage(systemName: "rectangle.and.hand.point.up.left.fill")))
        ]
        self.viewControllers = viewControllers
    }
}

extension UIViewController {
    func withTabBarItem(title: String, image: UIImage?, selectedImage: UIImage?) -> UIViewController {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        self.tabBarItem = tabBarItem
        return self
    }
}

// Main Interface
class DiscussViewController: UIViewController {
    
    let fsu: Array<String> = ["Swift基础", "iOS初级开发", "HTML5和CSS3基础", "JavaScript入门"]
    
    var offset = CGFloat()
    // var navHeight = CGFloat()
    
    let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth - screenSpaced * 2, height: navHeight / 5 * 4))
    var navTitleImg = UIImageView(image: UIImage(systemName: "books.vertical"))
    let discussTableView = UITableView(frame: CGRect(origin: CGPointZero, size: CGSizeZero), style: .grouped) // 创建一个UITableView作为DiscussViewController的主体
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navImgHeight = screenHeight / 25
        let navImgWidth = navImgHeight / (navTitleImg.image?.size.height ?? navImgHeight) * (navTitleImg.image?.size.width ?? navImgHeight)
        // 初始化导航栏
        navTitleImg.frame = CGRect(x: screenSpaced, y: navHeight / 2, width: navHeight / 5 * 6, height: navImgHeight)
        navTitleImg.contentMode = .scaleAspectFit
        navTitleImg.contentMode = .left
        self.navigationController?.navigationBar.addSubview(navTitleImg)
        
        navTitleLabel.text = "课程"
        navTitleLabel.font = UIFont.systemFont(ofSize: navTitleLabel.frame.height, weight: .bold)
        navTitleLabel.frame.origin.x = (navTitleImg.image?.size.width)!
        navTitleImg.addSubview(navTitleLabel)
        self.navigationItem.title = "课程"
        
        // 初始化tableview
        discussTableView.frame.size = self.view.bounds.size
        discussTableView.rowHeight = screenHeight / 5
        discussTableView.separatorStyle = .none
        discussTableView.backgroundColor = .systemBackground
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 3))
        scrollView.contentSize = CGSize(width: scrollView.frame.height * 2, height: scrollView.frame.height)
        discussTableView.tableHeaderView = scrollView
        
        let view0 = UIView()
        view0.backgroundColor = .blue
        scrollView.addSubview(view0)
        view0.translatesAutoresizingMaskIntoConstraints = false
        view0.layer.cornerRadius = 15
        NSLayoutConstraint.activate([
            view0.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: navHeight * 2 - (navigationController?.navigationBar.frame.size.height ?? 40)),
            view0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: screenSpaced),
            view0.widthAnchor.constraint(equalToConstant: screenWidth - screenSpaced),
            view0.heightAnchor.constraint(equalToConstant: screenHeight / 2 - controlSpaced * 2)
        ])
        
        let imageView = UIImageView(image: UIImage(systemName: "book"))
        imageView.frame.size = CGSize(width: 200, height: 150)
        view0.addSubview(imageView)

        discussTableView.dataSource = self
        discussTableView.delegate = self
        
        view.addSubview(discussTableView)
        
    }
    
}

extension DiscussViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        // cell.selectionStyle = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let view = UIView(frame: CGRect(x: screenSpaced, y: 0, width: screenWidth - screenSpaced * 2, height: screenHeight / 5 - controlSpaced))
        view.backgroundColor = .systemCyan
        view.layer.cornerRadius = 15
        
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 500, height: 100))
        label.text = fsu[indexPath.row]
        view.addSubview(label)
        cell.contentView.addSubview(view)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offset = discussTableView.contentOffset.y
        print(offset, navHeight)
        self.navTitleLabel.alpha = 1 - (offset / navHeight / 2)
    }
}

class CourseViewController: UIViewController {
    
    let textLabel = ["ActivityIndicator", "ProgressView", "Control", "Picker", "ScrollView", "lunbotu", "DataView", "ScrollView"]
    
    var buttonArray: Array<UIButton> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "讨论"
        
        let safeView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .insetGrouped)
        safeView.rowHeight = screenHeight / 5
        safeView.separatorStyle = .none
        safeView.backgroundColor = .systemBackground
        // safeView.isEditing = true
        
        safeView.dataSource = self
        safeView.delegate = self
        
        view.addSubview(safeView)
        
    }
    
}

extension CourseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        // cell.selectionStyle = .gray
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        .insert
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let view = UIView()
        print(cell.bounds.size.width, screenWidth)
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

class ViewController3: UIViewController {
    
}

class ViewController4: UIViewController {
    
}

class ActivityIndicatorViewController: UIViewController {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var a = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        // UIActivityIndicatorView()
        activityIndicator.frame.size = CGSize(width: 100, height: 100)
        activityIndicator.center = view.center
        activityIndicator.color = UIColor.white
        activityIndicator.backgroundColor = UIColor.systemGray
        activityIndicator.layer.cornerRadius = 30
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = false // 默认为true：控件停止动画时隐藏
        activityIndicator.isUserInteractionEnabled = true // 默认为false：控件不可交互
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        activityIndicator.addGestureRecognizer(tap) // UITapGestureRecognizer是一个轻触手势
        view.addSubview(activityIndicator)
        
    }
    
    // activityIndicator关联的方法
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            if a == 0 {
                a = 1
                activityIndicator.stopAnimating()
            } else {
                a = 0
                activityIndicator.startAnimating()
            }
        }
    }
    
}

class ProgressViewViewController: UIViewController {
    
    let progressView = UIProgressView(progressViewStyle: .default)
    var num = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        // UIProgressView()
        progressView.frame = CGRect(x: 20, y: 100, width: 300, height: 100)
        progressView.progressTintColor = UIColor.white // 设置进度条的颜色
        progressView.trackTintColor = UIColor.gray // 设置进度条的背景颜色
        progressView.layer.borderColor = UIColor.black.cgColor
        progressView.layer.borderWidth = 0.2
        progressView.layer.cornerRadius = 0
        
        progressView.progress = 0.0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(increaseProgress))
        progressView.addGestureRecognizer(tap)
        
        view.addSubview(progressView)
        
    }
    
    @objc func increaseProgress(_ sender: Any) {
        
        num += 0.1
        progressView.setProgress(Float(num), animated: true)
        
    }
    
}

class Control: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let switchControl = UISwitch()
        switchControl.frame = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 50, height: 30))
        switchControl.isOn = false
        switchControl.tintColor = UIColor.blue
        switchControl.onTintColor = UIColor.red // 打开时候的颜色
        switchControl.thumbTintColor = UIColor.systemCyan // 滑块颜色
        switchControl.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        view.addSubview(switchControl)
        
        let slider = UISlider()
        slider.frame = CGRect(origin: CGPoint(x: 50, y: 150), size: CGSize(width: 300, height: 50))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.addSubview(slider)
        
        let stepper = UIStepper()
        stepper.frame = CGRect(origin: CGPoint(x: 50, y: 250), size: CGSize(width: 300, height: 100))
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.value = 5
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        view.addSubview(stepper)
        
        let segmentControl = UISegmentedControl(items: ["Option 1", "Option 2", "Option 3"])
        segmentControl.frame = CGRect(origin: CGPoint(x: 50, y: 350), size: CGSize(width: 300, height: 50))
        segmentControl.selectedSegmentIndex = 0 // 初始选定段
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        view.addSubview(segmentControl)
        
        let colorWell = UIColorWell()
        colorWell.frame = CGRect(origin: CGPoint(x: 50, y: 450), size: CGSize(width: 300, height: 50))
        colorWell.selectedColor = .red
        colorWell.addTarget(self, action: #selector(colorWellValueChanged(_:)), for: .valueChanged)
        view.addSubview(colorWell)
        
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is ON")
        } else {
            print("Switch is OFF")
        }
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        print("Slider value changed to \(sender.value)")
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        print("Stepper value changed to \(sender.value)")
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        print("Segment control value changed to \(sender.selectedSegmentIndex)")
    }
    
    @objc func colorWellValueChanged(_ sender: UIColorWell) {
        print("Color well value changed to \(String(describing: sender.selectedColor))")
    }
    
}

class Picker: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        print("Date picker value changed to \(dateFormatter.string(from: sender.date))")
    }
    
}

class ScrollView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: view.bounds.width, height: view.bounds.height))
        scrollView.contentSize = CGSize(width: view.bounds.width, height: (view.bounds.height - 100) * 2)
        view.addSubview(scrollView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        scrollView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        print("开始下拉刷新")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("松手后打印的内容")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("自动收回控件")
                sender.endRefreshing()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("收回控件后打印的内容")
                }
            }
        }
    }
    
    
}

class lunbotu: UIViewController {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: Timer!
    let imageWidth = UIScreen.main.bounds.width
    let imageHeight = UIScreen.main.bounds.width * 0.6
    let images = ["image1.jpg", "image2.jpg", "image3.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        scrollView.contentSize = CGSize(width: imageWidth * CGFloat(images.count), height: imageHeight)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        for i in 0 ..< images.count {
            let imageView = UIImageView(frame: CGRect(x: imageWidth * CGFloat(i), y: 0, width: imageWidth, height: imageHeight))
            imageView.image = UIImage(named: images[i])
            scrollView.addSubview(imageView)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: imageHeight - 50, width: imageWidth, height: 50))
        pageControl.numberOfPages = images.count
        pageControl.currentPageIndicatorTintColor = UIColor.red // 选中颜色
        pageControl.pageIndicatorTintColor = UIColor.white // 未选中颜色
        pageControl.addTarget(self, action: #selector(aaa), for: .valueChanged)
        view.addSubview(pageControl)
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector:#selector(autoScroll), userInfo:nil, repeats:true)
    }
    
    @objc func aaa() {
        let currentPage = pageControl.currentPage
        let offsetX = CGFloat(currentPage) * imageWidth
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc func autoScroll() {
        var currentPage = pageControl.currentPage
        currentPage += 1
        if currentPage == images.count {
            currentPage = 0
        }
        let offsetX = CGFloat(currentPage) * imageWidth
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

extension lunbotu: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let currentPage = Int(offsetX / imageWidth + 0.5)
        pageControl.currentPage = currentPage
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 5, target:self, selector:#selector(autoScroll), userInfo:nil, repeats:true)
    }
}

class DataViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let textView = UITextField()
    let pickerView = UIPickerView()
    
    let years = ["2003", "2004"]
    let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    let days = ["01", "02", "03", "04", "05", "06", "07", "08", "09",
                "10", "11", "12", "13", "14", "15", "16", "17",
                "18", "19", "20", "21", "22", "23", "24", "25",
                "26", "27", "28"]
    let days1 = ["01", "02", "03", "04", "05", "06", "07", "08", "09",
                 "10", "11", "12", "13", "14", "15", "16", "17",
                 "18", "19", "20", "21", "22", "23", "24", "25",
                 "26", "27", "28", "29", "30"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        textView.frame = CGRect(origin: CGPoint(x: 50, y: 100), size: CGSize(width: 200, height: 50))
        textView.backgroundColor = UIColor.systemGray
        view.addSubview(textView)
        textView.inputView = pickerView
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return years.count
        } else if component == 1 {
            return months.count
        } else {
            return days1.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return years[row]
        } else if component == 1 {
            return months[row]
        } else {
            return days1[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = years[pickerView.selectedRow(inComponent: 0)]
        let month = months[pickerView.selectedRow(inComponent: 1)]
        let day = days1[pickerView.selectedRow(inComponent: 2)]
        textView.text = "\(year)-\(month)-\(day)"
    }
}

class ScrollViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "image1.jpg"))
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 4.0
        view.addSubview(scrollView)
        
        setZoomScale()
        setupGestureRecognizer()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print(#function)
    }
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        print(#function)
    }
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(#function)
    }
    
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}
