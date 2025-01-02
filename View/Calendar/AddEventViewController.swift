
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
        Button()
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
            textView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 0).isActive = true
            
        } else {
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        }
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    func Button() {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        button.setTitle("Save", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.addTarget(self, action: #selector(saveMemo), for: .touchUpInside)
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        view.addSubview(button)
        //autoLayout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.topAnchor,constant: 470).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 120).isActive = true

    }

    func DatePicker() {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        //autoLayout
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: 400).isActive = true
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
