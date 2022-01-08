
import UIKit
import RealmSwift

class AddEventViewController: UIViewController {

    let datePickerText = UILabel()
    let textView  = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextView()
        Button()
        DatePicker()
        view.backgroundColor = .white
    }
    
    
    //MARK: -ViewFunction
    func TextView() {
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        view.addSubview(textView)
        //autolayout
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func Button() {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("保存", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.addTarget(self, action: #selector(saveMemo), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        view.addSubview(button)
        //autoLayout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true

    }

    func DatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale(identifier: "ja-JP")
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        //autoLayout
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: 500).isActive = true
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
        
//        print("DB register done")
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        dismiss(animated: true, completion: nil)
        let calenderVC = CalendarViewController()
        navigationController?.pushViewController(calenderVC, animated: true)
    }
    //他の場面を触ったらキーボードが消える
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
}
