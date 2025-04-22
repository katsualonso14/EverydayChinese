

import UIKit
import SnapKit
import AVFoundation
import UserNotifications

class PhoneViewController: UITableViewController, AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate {
    
    let titleName: String
    let sentenceView = SentenseList()
    let synthesizer = AVSpeechSynthesizer()
    let audioSession = AVAudioSession.sharedInstance()
    let content = UNMutableNotificationContent()
    let favoritesLocalKey = "favoriteContacts_phone"
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
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
            make.edges.equalToSuperview()
        }
        
        container.snp.makeConstraints { make in
            make.width.equalTo(container.frameLayoutGuide)
            make.edges.equalTo(container.contentLayoutGuide)
        }
       
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("Audio Setting Failed.")
            return
        }
        
        let bannerHeight: CGFloat = 50
        tableView.contentInset.bottom = bannerHeight
        tableView.scrollIndicatorInsets.bottom = bannerHeight
        
        loadFavorites()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func CustomCellTapButtonCall(cell: UITableViewCell, pushTime: TimeInterval) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited
        
        sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        saveFavorites()
        
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "phone"]
        
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row)
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row)
        }
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン2を押した際の処理
    func CustomCellTapButtonCall2(cell: UITableViewCell, pushTime: TimeInterval) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited2
        
        sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited2 = !hasFavorited
        saveFavorites()
        
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "phone"]
        
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row)
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row)
        }
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン3を押した際の処理
    func CustomCellTapButtonCall3(cell: UITableViewCell, pushTime: TimeInterval) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited3
        
        sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited3 = !hasFavorited
        saveFavorites()
        
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "phone"]
        
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row)
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row)
        }
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    // ハートボタン4を押した際の処理
    func CustomCellTapButtonCall4(cell: UITableViewCell, pushTime: TimeInterval) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited4
        
        sentenceView.phoneSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited4 = !hasFavorited
        saveFavorites()
        
        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "phone"]
        
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            addRemindList(tappedRow: indexPathTapped.row)
        } else {
            pushDelete()
            deleteRemindList(tappedRow: indexPathTapped.row)
        }
        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
    
    
    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(sentenceView.phoneSentenceArray[0].names) {
            UserDefaults.standard.set(encoded, forKey: favoritesLocalKey)
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesLocalKey),
           let decoded = try? JSONDecoder().decode([Contact].self, from: savedData) {
            sentenceView.phoneSentenceArray = [ExpandableNames(isExpanded: true, names: decoded)]
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceView.phoneSentenceArray[0].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.phoneVC = self
        
        let contact = sentenceView.phoneSentenceArray[0].names[indexPath.row]
        cell.setCell(sentence: sentenceView.phoneSentence[indexPath.row], pronunciation: sentenceView.phonePronunciation[indexPath.row], japanese: sentenceView.phoneEnglish[indexPath.row])
        
        cell.heartButton.tintColor = contact.hasFavorited ? .red : .gray
        cell.heartButton2.tintColor = contact.hasFavorited2 ? .orange : .gray
        cell.heartButton3.tintColor = contact.hasFavorited3 ? .systemBlue : .gray
        cell.heartButton4.tintColor = contact.hasFavorited4 ? .systemGreen : .gray

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utterance = AVSpeechUtterance.init(string: sentenceView.phoneSentence[indexPath.row])
        let voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        utterance.voice = voice
        synthesizer.speak(utterance)
    }
    
    func pushRegister(pushTime: TimeInterval) {
        let notificationCenter = UNUserNotificationCenter.current()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: pushTime, repeats: true)
        let request = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
    
    func pushDelete() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [content.title])
    }
    
    func addRemindList(tappedRow: Int) {
        let data = ["sentence": sentenceView.phoneSentence[tappedRow]]
        NotificationCenter.default.post(name: Notification.Name("addRemind"), object: nil, userInfo: data)
        
        if var savedRemindData = UserDefaults.standard.stringArray(forKey: "remind") {
            savedRemindData.append(sentenceView.phoneSentence[tappedRow])
            UserDefaults.standard.set(savedRemindData, forKey: "remind")
        } else {
            UserDefaults.standard.set([sentenceView.phoneSentence[tappedRow]], forKey: "remind")
        }
    }
    
    func deleteRemindList(tappedRow: Int) {
        let dataToDelete = ["sentence": sentenceView.phoneSentence[tappedRow]]
        NotificationCenter.default.post(name: Notification.Name("deleteRemind"), object: nil, userInfo: dataToDelete)
        
        if var savedRemindData = UserDefaults.standard.stringArray(forKey: "remind") {
            savedRemindData.removeAll { $0 == sentenceView.phoneSentence[tappedRow] }
            UserDefaults.standard.set(savedRemindData, forKey: "remind")
        } else {
            print("No data to delete")
        }
    }
}
