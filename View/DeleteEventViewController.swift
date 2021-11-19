//
//  DeleteEventViewController.swift
//  CalendarTest
//
//  Created by 玉井　勝也 on 2021/11/18.
//

import UIKit
import RealmSwift

class DeleteEventViewController: UIViewController {

    let datePickerText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Button()
        DatePicker()
        view.backgroundColor = .white
    }
    
    //MARK: -Function
    func Button() {
        let button = UIButton(frame: CGRect(x: 150, y: 700, width: 100, height: 100))
        button.backgroundColor = .blue
        button.setTitle("削除", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.addTarget(self, action: #selector(deleteMemo), for: .touchUpInside)
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
    @objc func deleteMemo(){
        let realm = try! Realm()
        let result = realm.objects(EventModel.self).filter("date == '\(datePickerText.text!)'")

        try! realm.write{
            realm.delete(result)
            
            

        }

        print("\(result)")
        
        dismiss(animated: true, completion: nil)
//        print(datePickerText.text!)
    }
   
    

}
