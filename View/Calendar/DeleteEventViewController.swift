
import UIKit
import RealmSwift
import GoogleMobileAds

class DeleteEventViewController: UIViewController, GADBannerViewDelegate {

    let datePickerText = UILabel()
    let formatter = DateFormatter()
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker()
        setDeleteButton()
        
        
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
    
    //MARK: -Function
    func setDeleteButton() {
        let deleteButton = UIButton()
        deleteButton.backgroundColor =  .systemBackground
        deleteButton.setTitle("Delete", for: UIControl.State())
        deleteButton.setTitleColor(UIColor.systemRed, for: UIControl.State())
        deleteButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        deleteButton.addTarget(self, action: #selector(deleteMemo), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 30
        deleteButton.layer.masksToBounds = true
        view.addSubview(deleteButton)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.bottomAnchor.constraint(equalTo: view.topAnchor,constant: view.frame.height * 0.6),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            deleteButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.07)
        ])
    }

    func DatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        //autoLayout
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: view.frame.height * 0.3),
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
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
