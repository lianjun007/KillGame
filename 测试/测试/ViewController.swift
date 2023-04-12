import UIKit

// Main Interface
class ViewController: UIViewController {
    
    let textLabel = ["ActivityIndicator", "ProgressView", "Control", "Picker", "ScrollView", "lunbotu", "DataView", "ScrollView"]
    
    var buttonArray: Array<UIButton> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "你好"
        
        let safeView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight * 0.903), style: .insetGrouped)
        safeView.rowHeight = 100
        safeView.separatorStyle = .none
        safeView.backgroundColor = .systemBackground
        safeView.dataSource = self
        safeView.delegate = self
        
        view.addSubview(safeView)
        
        let tabBar = UITabBar()
        tabBar.frame.origin.y = screenHeight * 0.903
        tabBar.frame.size.width = screenWidth
        
        let a = UITabBarItem(title: "你好", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        let b = UITabBarItem(title: "12", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        let c = UITabBarItem(title: "12", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        let d = UITabBarItem(title: "12", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person"))
        tabBar.items = [a, b, c, d]
        
        view.addSubview(tabBar)
        
    }
    
    @objc func orientationDidChange() {
        print(UIDevice.current.orientation)
    }
    
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        800
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "a")
        
        guard let cell = cell else {
            
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: cell?.bounds.size.width ?? 0 , height: 90)
            view.backgroundColor = .black
            cell?.contentView.addSubview(view)
            
            return UITableViewCell(style: .default, reuseIdentifier: "a")
            
        }
        
        cell.selectionStyle = .gray
        cell.accessoryView = nil
        
        // cell.textLabel?.text = textLabel[indexPath.row]
        // cell.backgroundColor = .systemGray6
        // cell.imageView?.image = UIImage(systemName: "person")
        

        
        return cell
        
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "你好"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "不好"
    }
    
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
