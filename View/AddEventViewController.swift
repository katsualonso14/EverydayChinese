
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
        textView.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 10.0
        view.addSubview(textView)
        
    }
    
    func Button() {
        let button = UIButton(frame: CGRect(x: 150, y: 700, width: 100, height: 100))
        button.backgroundColor = .orange
        button.setTitle("保存", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.addTarget(self, action: #selector(saveMemo), for: .touchUpInside)
        button.layer.cornerRadius = button.bounds.width / 2
        button.layer.masksToBounds = true
        view.addSubview(button)
    }

    func DatePicker() {
        let datePicker = UIDatePicker(frame: CGRect(x: 150, y: 300, width: 300, height: 300))
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        view.addSubview(datePicker)
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
        
        print("DB register done")
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        dismiss(animated: true, completion: nil)
    }
    //他の場面を触ったらキーボードが消える
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
}
