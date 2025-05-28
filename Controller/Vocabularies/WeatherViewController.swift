import UIKit
import SnapKit
import AVFoundation
import UserNotifications

class WeatherViewController: UITableViewController, AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate {

    let titleName: String
    let sentenceView = SentenseList()
    let synthesizer = AVSpeechSynthesizer()
    let audioSession = AVAudioSession.sharedInstance()
    let content = UNMutableNotificationContent()
    let favoritesLocalKey = "favoriteContacts_weather"

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
        tableView.separatorStyle = .none
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Cellの設定
    func CustomCellTapButtonCall(cell: UITableViewCell, pushTime: TimeInterval) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else { return }
        
        let contact = sentenceView.weatherSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        let hasFavorited = contact.hasFavorited
        
        sentenceView.weatherSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited
        saveFavorites()

        content.title = contact.name
        content.body = contact.name
        content.sound = UNNotificationSound.default
        content.userInfo = ["page": "weather"]
        
        if hasFavorited == false {
            pushRegister(pushTime: pushTime)
            // リマインドリストに追加
            addRemindList(tappedRow: indexPathTapped.row, remindPattern: String(Int(pushTime)))
        } else {
            pushDelete()
        }

        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }

    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(sentenceView.weatherSentenceArray[0].names) {
            UserDefaults.standard.set(encoded, forKey: favoritesLocalKey)
        }
    }

    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesLocalKey),
           let decoded = try? JSONDecoder().decode([Contact].self, from: savedData) {
            sentenceView.weatherSentenceArray = [ExpandableNames(isExpanded: true, names: decoded)]
        }
    }

    // Cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceView.weatherSentenceArray[0].names.count
    }

    // Cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.weatherVC = self
        
        let contact = sentenceView.weatherSentenceArray[0].names[indexPath.row]
        cell.setCell(sentence: sentenceView.weatherSentence[indexPath.row], pronunciation: sentenceView.weatherPronunciation[indexPath.row], japanese: sentenceView.weatherEnglish[indexPath.row])
        
        cell.heartButton.tintColor = contact.hasFavorited ? .red : .gray
        cell.heartButton2.tintColor = contact.hasFavorited2 ? .orange : .gray
        cell.heartButton3.tintColor = contact.hasFavorited3 ? .systemBlue : .gray
        cell.heartButton4.tintColor = contact.hasFavorited4 ? .systemGreen : .gray
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(145)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utterance = AVSpeechUtterance.init(string: sentenceView.weatherSentence[indexPath.row])
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

    func addRemindList(tappedRow: Int, remindPattern: String) {
        let sentence = sentenceView.weatherSentence[tappedRow]
        RemindManager.addRemindItem(sentence: sentence, remindPattern: remindPattern)
    }


    func deleteRemindList(tappedRow: Int) {
        let dataToDelete = ["sentence": sentenceView.weatherSentence[tappedRow]]
        NotificationCenter.default.post(name: Notification.Name("deleteRemind"), object: nil, userInfo: dataToDelete)

        if var savedRemindData = UserDefaults.standard.stringArray(forKey: "remind") {
            savedRemindData.removeAll { $0 == sentenceView.weatherSentence[tappedRow] }
            UserDefaults.standard.set(savedRemindData, forKey: "remind")
        }
    }
}
