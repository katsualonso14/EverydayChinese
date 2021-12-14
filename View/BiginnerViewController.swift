//初心者ページ
import UIKit
import SnapKit
import AVFoundation
import UserNotifications

class BiginnerViewController: UITableViewController,AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate  {
    
    let titleName: String
    let sentenceView = SentenceViewController()
    let synthesizer = AVSpeechSynthesizer()
    //     マナーモード時音鳴らすための宣言 AVAudioSession
    let audioSession = AVAudioSession.sharedInstance()
    var flag = false
    // 通知の編集を可能にする定数宣言
    let content = UNMutableNotificationContent()
    
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
        //お気に入りボタンのフラグを立てる
        flag = false
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
        
        tableView.dataSource = self
        tableView.delegate  = self
        //CustomCellの登録
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    //MARK: -Function
    //cellの設定
    func CustomCellTapButtonCall(cell: UITableViewCell) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}

        tableView.reloadRows(at: [indexPathTapped], with: .fade)
        //cellの値を取得
        let tapSentence = sentenceView.sentence[indexPathTapped.row]
        print(tapSentence)
        //タップしてときの値をpushメッセージに記載
        content.title = "remind"
        content.body = tapSentence
        content.sound = UNNotificationSound.default
    }
    
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceView.sentence.count
    }
    //cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CustomTableViewCellの追加
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.BiginnerVC = self
        cell.tintColor = flag ? .red : .gray
        
        //cellの文字指定
        cell.setCell(sentence: sentenceView.sentence[indexPath.row], pronunciation: sentenceView.Pronunciation[indexPath.row], japanese: sentenceView.japanese[indexPath.row])

            return cell
        }
//    セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //中国語の読み上げ設定
        let utterance = AVSpeechUtterance.init(string: sentenceView.sentence[indexPath.row])
        let voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        utterance.voice = voice
        synthesizer.speak(utterance)

    }
        
    //MARK:- Push
    //プッシュ通知登録
    func pushRegister() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        var dateComponetsDay = DateComponents()
        dateComponetsDay.hour = 20
        dateComponetsDay.minute = 00
        
//        content.title = "remind"
//        content.body = "アラーム"
//        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponetsDay, repeats: true)
        //通知のID(identifier,タイトル,内容、トリガーを設定 )
        let request = UNNotificationRequest(identifier: content.title, content: content, trigger: trigger)
        print("request is \(request.content.title)")
        
        notificationCenter.add(request) {
            (error) in
            if error != nil {
//                print(error.debugDescription)
            }
        }
        print("flag is \(flag)")
    }
    //push通知削除
    func pushDelete() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: ["remind"])

        print("request is \(content.title)")
        print("flag is \(flag)")
    }
    
}
    
    
