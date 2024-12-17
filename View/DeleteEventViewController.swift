
import UIKit
import RealmSwift
import GoogleMobileAds

class DeleteEventViewController: UIViewController, GADBannerViewDelegate {

    let datePickerText = UILabel()
    let formatter = DateFormatter()
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Button()
        DatePicker()
        view.backgroundColor = .white
        
        // Admob広告設定
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
        let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
        bannerView = GADBannerView(adSize: adaptiveSize)
        
        addBannerViewToView(bannerView)
        bannerView.delegate = self
        
        bannerView.adUnitID = "ca-app-pub-2751119101175618/2259631200"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    //MARK: -Function
    func Button() {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1.0)
        button.setTitle("Delete", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.addTarget(self, action: #selector(deleteMemo), for: .touchUpInside)
        button.layer.cornerRadius = 50
        button.layer.masksToBounds = true
        view.addSubview(button)
        //autoLayout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }

    func DatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        //autoLayout
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: 320).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    //MARK: -ActionFunction
    
    @objc func picker(_ sender: UIDatePicker) {
        formatter.dateFormat = "yyyy/MM/dd"
        datePickerText.text = formatter.string(from: sender.date)
    }
    
    //RealmDB書き込み処理
    @objc func deleteMemo(){
        let realm = try! Realm()
        try! realm.write{
            //pickerで選んだ日付を削除 pickerをスクロールしなければ今日の日付を削除
            if let selectPickerDay = datePickerText.text {
                let result = realm.objects(EventModel.self).filter("date == '\(selectPickerDay)'")
                realm.delete(result)
                
                print("\(result)")
                dismiss(animated: true, completion: nil)
            } else {
                formatter.dateFormat = "yyyy/MM/dd"
                let defaultDay = realm.objects(EventModel.self).filter("date == '\(formatter.string(from: Date()))'")
                
                realm.delete(defaultDay)
                
                print("\(defaultDay)")
//                dismiss(animated: true, completion: nil)
            }
        }
        let calenderVC = CalendarViewController()
        navigationController?.pushViewController(calenderVC, animated: true)
    }
    //MARK: -Admob
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        
        bannerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 630).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}
