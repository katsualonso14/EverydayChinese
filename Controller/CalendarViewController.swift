
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
//        saveToday()
        setCalendar()
        setAddButton()
        setMemoButton()
    }
    
    //MARK: -Layout
    func setCalendar() {
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
        self.calendar = calendar
    }
    // チェックマーク設定
    //TODO: noCheckMarkとの出し分け
    func setCheckMark() {
        let checkMark = UIImage(systemName: "checkmark.circle")
        let checkMarkView = UIImageView(image: checkMark)
        checkMarkView.contentMode = .scaleAspectFit
        view.addSubview(checkMarkView)
        
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: view.frame.height * 0.01),
            checkMarkView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMarkView.widthAnchor.constraint(equalToConstant: 60),
            checkMarkView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setNoCheckMark() {
        let checkMark = UIImage(systemName: "star")
        let checkMarkView = UIImageView(image: checkMark)
        checkMarkView.contentMode = .scaleAspectFit
        view.addSubview(checkMarkView)
        
        checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: view.frame.height * 0.01),
            checkMarkView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkMarkView.widthAnchor.constraint(equalToConstant: 60),
            checkMarkView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setMemoButton() {
        view.addSubview(memoButton)
        memoButton.layer.cornerRadius = 25
        memoButton.layer.masksToBounds = true
        memoButton.backgroundColor = UIColor.systemBackground
        memoButton.setTitleColor(UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black, for: .normal)
        memoButton.titleLabel?.font = .systemFont(ofSize: 20)
        memoButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
        
        memoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: view.frame.height * 0.1),
            memoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            memoButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            memoButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1)
        ])
    }
    
    func setAddButton() {
        let addButton = UIButton()
        addButton.backgroundColor =  UIColor.systemRed
        addButton.setTitle("Add", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        addButton.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: view.frame.height * -0.23),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            addButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.07)
        ])
    }
    
    func updateCalendar() {
        calendar.reloadData()
    }
    //MARK: -Function
    //ボタンを押したときの処理
    @objc func tapAddButton() {
        let addEventVC = AddEventViewController()
        addEventVC.onEventUpdate = {[weak self] in
            self?.updateCalendar()
        }
        let navController = UINavigationController(rootViewController: addEventVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func tapDeleteButton() {
        let deleteEventVC = DeleteEventViewController()
        deleteEventVC.onEventUpdate = {[weak self] in
            self?.updateCalendar()
        }
        let navController = UINavigationController(rootViewController: deleteEventVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
   
    //MARK: -CalendarSupport
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "CELL", for: date, at: position)
        return cell
    }
    // 日付を選択したときの処理
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let mmmm = String(format: "%02d", month)
        let dddd = String(format: "%02d", day)
        
        let workDay = "\(year)/\(mmmm)/\(dddd)"
        
        let realm = try! Realm()
        let eventModel = realm.objects(EventModel.self)
        
        // メモを表示
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
    
    // 今日の日付を保存
    func saveToday() {
        let realm = try! Realm()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        try! realm.write{
            let Events = [EventModel(value: ["date": formatter.string(from: Date()), "event": "Study Chinese"])]
            realm.add(Events)
        }
    }
    
    
}



