
import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    fileprivate weak var calendar: FSCalendar!
    //memoLabel
    let memoLabel = UILabel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Calendar"
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "CELL")
        //Auto Layout以前に使われていた制約を解除しないといけない
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        
        //レイアウト制約
        calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 275).isActive = true
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
       
        view.addSubview(memoLabel)
        memoLabel.translatesAutoresizingMaskIntoConstraints = false
        memoLabel.bottomAnchor.constraint(equalTo: calendar.bottomAnchor,constant: 30).isActive = true
        memoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.calendar = calendar
        view.backgroundColor = .white
        addButton()
        deleteButton()
        
    }
    
    //MARK: -Function
    
    func addButton() {
        let addButton = UIButton()
//        let addButton = UIButton()
        addButton.backgroundColor = .orange
        addButton.setTitle("+", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        addButton.layer.cornerRadius = 40
        addButton.layer.masksToBounds = true
        view.addSubview(addButton)
        //autoLayout
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -190).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func deleteButton() {
        let deleteButton = UIButton()
        deleteButton.backgroundColor = .blue
        deleteButton.setTitle("-", for: UIControl.State())
        deleteButton.setTitleColor(.white, for: UIControl.State())
        deleteButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 40
        deleteButton.layer.masksToBounds = true
        view.addSubview(deleteButton)
        //autoLayout
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    //ボタンを押したときの処理
    @objc func tapAddButton() {
        let addEventVC = AddEventViewController()
//        present(addEventVC, animated: true, completion: nil)
        navigationController?.pushViewController(addEventVC, animated: true)
    }
    
    @objc func tapDeleteButton() {
        let deleteEventVC = DeleteEventViewController()
//        present(deleteEventVC, animated: true, completion: nil)
        navigationController?.pushViewController(deleteEventVC, animated: true)
    }
    
   
    //MARK: -CalendarSupport
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let mmmm = String(format: "%02d", month)
        let dddd = String(format: "%02d", day)
        
        let workDay = "\(year)/\(mmmm)/\(dddd)"
        print("\(workDay)")
        
        memoLabel.text = "MEMO"
        memoLabel.textColor = .lightGray
        memoLabel.font = UIFont.systemFont(ofSize: 20.0)
        
        view.addSubview(memoLabel)
        
        
        let realm = try! Realm()
        let eventModel = realm.objects(EventModel.self)
        
        for memo in eventModel {
            if memo.date == workDay {
                memoLabel.text = memo.event
                memoLabel.textColor = .black
                view.addSubview(memoLabel)
                
            }
        }
    }
    
//    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
//        var hasEvent = false
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
//        let workDay = formatter.string(from: date)
//
//        let realm = try! Realm()
//        var result = realm.objects(EventModel.self)
//        result = result.filter("date = '\(workDay)'")
//
//        for event in result {
//            if event.date == workDay {
//                hasEvent = true
//            }
//        }
//        if hasEvent {
//            cell.eventIndicator.numberOfEvents = 1
//            cell.eventIndicator.isHidden = false
//            cell.eventIndicator.color = UIColor.blue
//        } else {
//            cell.eventIndicator.numberOfEvents = 0
//        }
//    }
    
    //点マークをつける関数
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        var hasEvent = false
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let workDay = formatter.string(from: date)

        let realm = try! Realm()
        var result = realm.objects(EventModel.self)
        result = result.filter("date = '\(workDay)'")

        for event in result {
            if event.date == workDay {
                hasEvent = true
            }
        }
        if hasEvent {
            return 1
        } else {
            return 0
        }
    }
    
}



