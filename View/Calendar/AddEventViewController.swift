
import UIKit
import RealmSwift
import GoogleMobileAds

class AddEventViewController: UIViewController, GADBannerViewDelegate {

    let datePickerText = UILabel()
    let textView  = UITextView()
    let datePicker = UIDatePicker()
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextView()
        setAddButton()
        DatePicker()
        
        // Admob広告設定
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-2751119101175618/2259631200" // AdBanner ID
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    
    //MARK: -ViewFunction
    func TextView() {
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        view.addSubview(textView)
        //autolayout
        if #available(iOS 11, * ) {//safeAreaがある場合はsafeAreaからtopAnchorを始める
            let guide = view.safeAreaLayoutGuide
            textView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 30).isActive = true
            
        } else {
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        }
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            textView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3)
        ])
    }

    func setAddButton() {
        let addButton = UIButton()
        addButton.backgroundColor =  UIColor.systemRed
        addButton.setTitle("Add", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        addButton.addTarget(self, action: #selector(saveMemo), for: .touchUpInside)
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.topAnchor,constant: view.frame.height * 0.6),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            addButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.07)
        ])
    }

    func DatePicker() {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        //autoLayout
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: view.frame.height * 0.48).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func DatePickerText() {
        datePickerText.frame = CGRect(x: 50, y: 500, width: 300, height: 100)
        datePickerText.backgroundColor = .white
        datePickerText.textAlignment = .center
        view.addSubview(datePickerText)
        
    }
    //MARK: -ActionFunction
    
    @objc func picker(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        datePickerText.text = formatter.string(from: sender.date)
       
        view.addSubview(datePickerText)
        
    }
    //RealmDB書き込み処理
    @objc func saveMemo(){
        let realm = try! Realm()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        try! realm.write{
            // memoLabelmに未選択時に今日の日付、空文字を返す
            let Events = [EventModel(value: ["date": datePickerText.text ?? "\(formatter.string(from: Date()))", "event": textView.text ?? ""])]
            realm.add(Events)
            
        }
        
        let calenderVC = CalendarViewController()
        navigationController?.pushViewController(calenderVC, animated: true)
    }
    //他の場面を触ったらキーボードが消える
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    //MARK: -Admob
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        bannerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 610).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
