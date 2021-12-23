//上級者ぺージ
import UIKit
import SnapKit
import AVFoundation

class AdvancedViewController: UITableViewController,AVAudioPlayerDelegate, AVSpeechSynthesizerDelegate {

    let titleName: String
    let sentenceView = SentenceViewController()
    let  synthesizer = AVSpeechSynthesizer()
    //     マナーモード時音鳴らすための宣言 AVAudioSession
    let audioSession = AVAudioSession.sharedInstance()
    
    
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
        //        タイトル
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
        
        tableView.dataSource = self
        tableView.delegate  = self
        //CustomCellの登録
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
    }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    //cellの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sentenceView.sentence.count
    }
    //cellの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //CustomTableViewCellの追加
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        cell.advancedVC = self
        
        let contact = sentenceView.AdvancedSentenceArray[0].names[indexPath.row]
        //cellの文字指定
        cell.setCell(sentence: sentenceView.AdvancedSentence[indexPath.row], pronunciation: sentenceView.AdvancedPronunciation[indexPath.row], japanese: sentenceView.AdvancedJananase[indexPath.row
        ])
        
        cell.tintColor = contact.hasFavorited ? .red : .gray
            return cell
        }
//    セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //中国語の読み上げ設定
        let utterance = AVSpeechUtterance.init(string: sentenceView.AdvancedSentence[indexPath.row])
        let voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        utterance.voice = voice
        synthesizer.speak(utterance)
        
//        print("tap")
    }
    
    //お気に入りボタンを押したときの処理
    func CustomCellTapButtonCall(cell: UITableViewCell) {
        //タップしたcellの値
        guard let indexPathTapped = tableView.indexPath(for: cell) else
        {return}
        
        let contact = sentenceView.AdvancedSentenceArray[indexPathTapped.section].names[indexPathTapped.row]
        print(contact)
        let hasFavorited = contact.hasFavorited
        
        sentenceView.AdvancedSentenceArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorited = !hasFavorited

        tableView.reloadRows(at: [indexPathTapped], with: .fade)
    }
        
}
    
    

