//初心者ページ
import UIKit
import SnapKit
import AVFoundation
import UserNotifications

class DramaViewController: UITableViewController,AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate {
    
    let titleName: String
    let sentenceView = SentenseList()
    let synthesizer = AVSpeechSynthesizer()
    //     マナーモード時音鳴らすための宣言 AVAudioSession
    let audioSession = AVAudioSession.sharedInstance()
    // 通知の編集を可能にする定数宣言
    let content = UNMutableNotificationContent()
    let favoritesLocalKey = "favoriteContacts_drama"
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //　　　　viewのセット
    private lazy var container: UIScrollView = {
        let container = UIScrollView()
        container.backgroundColor = UIColor.white
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = titleName
        self.view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview() //中心点を親Viewと合わせる、全画面に窓を固定
        }
        
        container.snp.makeConstraints { make in
            make.width.equalTo(container.frameLayoutGuide)
            make.edges.equalTo(container.contentLayoutGuide)
        }
       
        do {
            // マナーモードでも音を鳴らすようにする
            try audioSession.setCategory(.playback)

        } catch {
            print("Audio Setting Failed.")
            return
        }
        
        // TableViewのcontentInsetを調整して、広告スペースを確保
        let bannerHeight: CGFloat = 50 // AdMobバナーの高さ
        tableView.contentInset.bottom = bannerHeight
        tableView.scrollIndicatorInsets.bottom = bannerHeight
        
        loadFavorites() // 起動時にハートボタンの色の状態を取得
        tableView.dataSource = self
        tableView.delegate  = self
        tableView.separatorStyle = .none
        //CustomCellの登録
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    //MARK: -Function
    //cellの設定
    func CustomCellTapButtonCall(cell: UITableViewCell, pushTime: TimeInterval) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)
        let hasFavorited = contact.hasFavorited
        
        sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        saveFavorites() // ハートボタンの色の状態を保存
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "drama"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row) // リマインドリストに追加
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row) // リマインドリストから削除
        }
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン2をタップした際の設定
    func CustomCellTapButtonCall2(cell: UITableViewCell, pushTime: TimeInterval) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited2
        
        sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited2 = !hasFavorited
        saveFavorites() // ハートボタンの色の状態を保存
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "drama"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row) // リマインドリストに追加
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row) // リマインドリストから削除
        }
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン3をタップした際の設定
    func CustomCellTapButtonCall3(cell: UITableViewCell, pushTime: TimeInterval) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited3
        
        sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited3 = !hasFavorited
        saveFavorites() // ハートボタンの色の状態を保存
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "drama"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row) // リマインドリストに追加
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row) // リマインドリストから削除
        }
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン4をタップした際の設定
    func CustomCellTapButtonCall4(cell: UITableViewCell, pushTime: TimeInterval) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited4
        
        sentenceView.dramaSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited4 = !hasFavorited
        saveFavorites() // ハートボタンの色の状態を保存
        //タップしてときの値をpushメッセージに記載
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "drama"]
        //通知設定
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row) // リマインドリストに追加
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row) // リマインドリストから削除
        }
        
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタンの状態をローカルに保存
    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(sentenceView.dramaSentenceArray[0].names) {
            UserDefaults.standard.set(encoded, forKey: favoritesLocalKey)
        }
    }
    // ハートボタンの状態をローカルから取得
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesLocalKey),
           let decoded = try? JSONDecoder().decode([Contact].self, from: savedData) {
            sentenceView.dramaSentenceArray = [ExpandableNames(isExpanded: true, names: decoded)]
        }
    }
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceView.dramaSentenceArray[0].names.count
    }
    //cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CustomTableViewCellの追加
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.dramaVC = self
        
        let contact = sentenceView.dramaSentenceArray[0].names[indexPath.row]
        //cellの文字指定
        cell.setCell(sentence: sentenceView.dramaSentence[indexPath.row], pronunciation: sentenceView.dramaPronunciation[indexPath.row], japanese: sentenceView.dramaEnglish[indexPath.row])
        
        cell.heartButton.tintColor = contact.hasFavorited ? .red : .gray
        cell.heartButton2.tintColor = contact.hasFavorited2 ? .orange : .gray
        cell.heartButton3.tintColor = contact.hasFavorited3 ? .systemBlue : .gray
        cell.heartButton4.tintColor = contact.hasFavorited4 ? .systemGreen : .gray

            return cell
        }
//    セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(145)
    }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //中国語の読み上げ設定
        let utterance = AVSpeechUtterance.init(string: sentenceView.dramaSentence[indexPath.row])
        let voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        utterance.voice = voice
        synthesizer.speak(utterance)

    }
    //MARK:- Push
    //プッシュ通知登録
    func pushRegister(pushTime: TimeInterval) {
        let notificationCenter = UNUserNotificationCenter.current()
        // 受け取った時間をリピート通知
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: pushTime, repeats: true)
        //通知のID(identifier,タイトル,内容、トリガーを設定 )
        let request = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
        print("request is \(request.content.title)")
        
        notificationCenter.add(request) {
            (error) in
            if error != nil {
            print(error.debugDescription)
            }
        }
    }
    //push通知削除
    func pushDelete() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [content.title])
        
        print("request is \(content.title)")
    }
    
    //RemindListへの追加
    func addRemindList(tappedRow: Int) {
        // 別VCへの値渡し
        let data = ["sentence": sentenceView.dramaSentence[tappedRow]]
        NotificationCenter.default.post(name: Notification.Name("addRemind"), object: nil, userInfo: data)
        
        //ローカルへの保存
        if var savedRemindData = UserDefaults.standard.stringArray(forKey: "remind") {
            savedRemindData.append(sentenceView.dramaSentence[tappedRow])
            UserDefaults.standard.set(savedRemindData, forKey: "remind")
        } else {
            UserDefaults.standard.set([sentenceView.dramaSentence[tappedRow]], forKey: "remind")
        }
        
    }
    //RemindListからの削除
    func deleteRemindList(tappedRow: Int) {
        let dataToDelete = ["sentence": sentenceView.dramaSentence[tappedRow]]
        NotificationCenter.default.post(name: Notification.Name("deleteRemind"), object: nil, userInfo: dataToDelete)
        
        //ローカルからの削除
        if var savedRemindData = UserDefaults.standard.stringArray(forKey: "remind") {
            savedRemindData.removeAll { $0 == sentenceView.dramaSentence[tappedRow] }
            UserDefaults.standard.set(savedRemindData, forKey: "remind")
        } else {
            print("No data to delete")
        }
    }
}
    
    

