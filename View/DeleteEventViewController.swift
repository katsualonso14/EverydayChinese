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
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Button()
        DatePicker()
        view.backgroundColor = .white
    }
    
    //MARK: -Function
    func Button() {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("削除", for: UIControl.State())
        button.setTitleColor(.white, for: UIControl.State())
        button.addTarget(self, action: #selector(deleteMemo), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        view.addSubview(button)
        //autoLayout
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true
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
        datePicker.topAnchor.constraint(equalTo: view.topAnchor,constant: 400).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
  
       
    }
    
    func DatePickerText() {
        view.addSubview(datePickerText)
        
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
}
