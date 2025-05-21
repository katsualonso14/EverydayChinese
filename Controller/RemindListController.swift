
import UIKit
import FirebaseFirestore


class RemindListController: UITableViewController {
    var sentences: [String] = []
    var pronunciations: [String] = []
    var meanings: [String] = []
    
    // 各カテゴリのViewControllerをインスタンス化
    let greetingVC = GreetingsViewController(titleName: "Greetings")
    let personalPronounsVC = PersonalPronounsViewController(titleName: "Personal Pronouns")
    let dailyVC = DailyTalkViewController(titleName: "Daily conversation")
    let tripVC = TripViewController(titleName: "Trip")
    let restaurantVC = RestaurantViewController(titleName: "Restaurant")
    let dramaVC = DramaViewController(titleName: "Drama")
    let shoppingVC = ShoppingViewController(titleName: "Shopping")
    let phoneVC = PhoneViewController(titleName: "Phone")
    let weatherVC = WeatherViewController(titleName: "Weather")
    let healthVC = HealthViewController(titleName: "Health")
    let businessVC = BusinessViewController(titleName: "Business")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("remind_list_title", comment: "")
        
        setupFeedBackForm()
        setupNavLeftButton()
        loadRemind()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name("addRemind"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteData(_:)), name: Notification.Name("deleteRemind"), object: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RemindListCell.self, forCellReuseIdentifier: "remindCell")
    }
    
    //MARK: -Layout
    func setupFeedBackForm() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            style: .plain,
            target: self,
            action: #selector(openFeedbackModal)
        )
        navigationItem.rightBarButtonItem?.tintColor = AppColors.appMainColor
    }
    
    func setupNavLeftButton() {
        let calendarButton = UIBarButtonItem(
            image: UIImage(systemName: "calendar"),
            style: .plain,
            target: self,
            action: #selector(openCalendarModal)
        )
        
        let deleteButton = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(openAllNotifDeleteAleart)
        )
        
        calendarButton.tintColor = AppColors.appMainColor
        deleteButton.tintColor = AppColors.appMainColor
        navigationItem.leftBarButtonItems = [calendarButton, deleteButton]
    }

    //MARK: -Function
    // Store feedback to Firestore
    func saveFeedbackToFirestore(feedback: String) {
        let db = Firestore.firestore()
        db.collection("feedbacks").addDocument(data: [
            "feedback": feedback,
            "timestamp": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving feedback: \(error.localizedDescription)")
            } else {
                print("Feedback successfully saved!")
            }
        }
    }
    
    //リマインドのローカルからの読み込み
    func loadRemind() {
        if let remindArray = UserDefaults.standard.stringArray(forKey: "remind") {
            print("remindArray: \(remindArray)")
            sentences = remindArray
        }
        tableView.reloadData()
    }
    
    //MARK - Delete Notification
    //全ての通知を削除する処理
    func deleteAllNotif() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
        //全ての通知を削除しましたのダイアログ表示
        let alert = UIAlertController(
            title: NSLocalizedString("delete_all_notif_finish_title", comment: ""),
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // 全てのハートボタンの状態を削除
    func deleteAllFavorites() {
        UserDefaults.standard.removeObject(forKey: greetingVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: personalPronounsVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: dailyVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: tripVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: restaurantVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: dramaVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: shoppingVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: phoneVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: weatherVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: healthVC.favoritesLocalKey)
        UserDefaults.standard.removeObject(forKey: businessVC.favoritesLocalKey)
        
    }
    
    // RemidListから全データ削除
    func deleteAllRemindList() {
        UserDefaults.standard.set([], forKey: "remind")
        sentences.removeAll()
        tableView.reloadData()
    }
    
    //MARK: -objc
    @objc func openFeedbackModal() {
        let alert = UIAlertController(title: NSLocalizedString("feedback_title", comment: ""),
                                      message: NSLocalizedString("feedback_message", comment: ""),
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Feedback"
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("submit", comment: ""), style: .default, handler: { _ in
            if let feedback = alert.textFields?.first?.text {
                // Save feedback to Firestore
                self.saveFeedbackToFirestore(feedback: feedback)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func openCalendarModal() {
        let calendarVC = CalendarViewController()
        navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    @objc func updateData(_ notification: Notification) {
        guard let data = notification.userInfo as? [String: String] else { return }
        //TODO: 複数を許容するか要確認
            sentences.append(data["sentence"]!)
            tableView.reloadData()
    }
    
    @objc func deleteData(_ notification: Notification) {
        guard let tapSentence = notification.userInfo?["sentence"] as? String else { return }
        guard let rowIndex = sentences.firstIndex(of: tapSentence) else { return }
        sentences.remove(at: rowIndex)
        // TableViewの行を削除
        tableView.deleteRows(at: [IndexPath(row: rowIndex, section: 0)], with: .automatic)
    }
    
    // 全てのリマインドを削除
    @objc func openAllNotifDeleteAleart(){
        let alert = UIAlertController(title: NSLocalizedString("delete_all_remind_title", comment: ""),
                                      message: NSLocalizedString("delete_all_remind_message", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("delete", comment: ""),
                style: .destructive,
                handler: { [self] _ in
                    deleteAllNotif()
                    deleteAllFavorites()
                    deleteAllRemindList()
                }))
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("cancel", comment: ""),
                style: .cancel,
                handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentences.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindCell") as! RemindListCell
        cell.setCell(sentence: sentences[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //TODO: タップ時に発音を
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
    
}



