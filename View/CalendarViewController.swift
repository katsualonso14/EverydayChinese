
import UIKit
import FSCalendar
import RealmSwift
import CalculateCalendarLogic

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    fileprivate weak var calendar: FSCalendar!
    let memoButton = UIButton() // memo contents
   
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
        calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        calendar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        calendar.heightAnchor.constraint(equalToConstant: 275).isActive = true
        calendar.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        
        view.addSubview(memoButton)
        memoButton.translatesAutoresizingMaskIntoConstraints = false
        memoButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 30).isActive = true
        memoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        memoButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        memoButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        memoButton.layer.cornerRadius = 25
        memoButton.layer.masksToBounds = true
        memoButton.backgroundColor = .systemGray6
        memoButton.titleLabel?.text = "MEMO"
        memoButton.setTitleColor(UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black, for: .normal)
        memoButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)

        self.calendar = calendar
        addButton()
    }
    
    //MARK: -Function
    
    func addButton() {
        let addButton = UIButton()
        addButton.backgroundColor =  UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        addButton.setTitle("+", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        addButton.layer.cornerRadius = 40
        addButton.layer.masksToBounds = true
        view.addSubview(addButton)
        //autoLayout
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -160).isActive = true
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
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
        
        let realm = try! Realm()
        let eventModel = realm.objects(EventModel.self)
        
        // 勉強したメモを表示
        for memo in eventModel {
            if memo.date == workDay {
                memoButton.setTitle(memo.event, for: .normal)
            }
        }
    }
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
    
    //MARK: -祝日設定
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
        fileprivate lazy var dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
        // 祝日判定を行い結果を返すメソッド(True:祝日)
        func judgeHoliday(_ date : Date) -> Bool {
            //祝日判定用のカレンダークラスのインスタンス
            let tmpCalendar = Calendar(identifier: .gregorian)
            // 祝日判定を行う日にちの年、月、日を取得
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)
            // CalculateCalendarLogic()：祝日判定のインスタンスの生成
            let holiday = CalculateCalendarLogic()

            return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
        }
        // date型 -> 年月日をIntで取得
        func getDay(_ date:Date) -> (Int,Int,Int){
            let tmpCalendar = Calendar(identifier: .gregorian)
            let year = tmpCalendar.component(.year, from: date)
            let month = tmpCalendar.component(.month, from: date)
            let day = tmpCalendar.component(.day, from: date)
            return (year,month,day)
        }
        //曜日判定(日曜日:1 〜 土曜日:7)
        func getWeekIdx(_ date: Date) -> Int{
            let tmpCalendar = Calendar(identifier: .gregorian)
            return tmpCalendar.component(.weekday, from: date)
        }
        // 土日や祝日の日の文字色を変える
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
            //祝日判定をする（祝日は赤色で表示する）
            if self.judgeHoliday(date){
                return UIColor.red
            }
            //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
            let weekday = self.getWeekIdx(date)
            if weekday == 1 {   //日曜日
                return UIColor.red
            }
            else if weekday == 7 {  //土曜日
                return UIColor.blue
            }
            // not current month for dark mode
            
            if(UITraitCollection.current.userInterfaceStyle == .dark ) {
                let today = Date()
                let year = self.gregorian.component(.year, from: date)
                let month = self.gregorian.component(.month, from: date)
                let todayYear = self.gregorian.component(.year, from: today)
                let todayMonth = self.gregorian.component(.month, from: today)
                
                if year == todayYear && month == todayMonth {
                    return UIColor.white
                }
                else {
                    return UIColor.lightGray
                }
            } else {
                return nil
            }

        }
}



