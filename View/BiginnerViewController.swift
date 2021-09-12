//初心者ページ
import UIKit
import SnapKit
import AVFoundation

class BiginnerViewController: UITableViewController,AVAudioPlayerDelegate {
    
    let titleName: String
    let sentenceView = SentenceViewController()
    let soundsView = SoundsViewController()
    let AudioVC = AudioViewController()
    
    
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
        //音声データのパス指定
        let audioPath  = Bundle.main.path(forResource: AudioVC.soundList[0], ofType: "mp3")!
        let audioUrl  = URL(fileURLWithPath: audioPath)
        
        let audioPath1  = Bundle.main.path(forResource: AudioVC.soundList[1], ofType: "mp3")!
        let audioUrl1  = URL(fileURLWithPath: audioPath1)
        
        let audioPath2  = Bundle.main.path(forResource: AudioVC.soundList[2], ofType: "mp3")!
        let audioUrl2  = URL(fileURLWithPath: audioPath2)
        
        let audioPath3  = Bundle.main.path(forResource: AudioVC.soundList[3], ofType: "mp3")!
        let audioUrl3 = URL(fileURLWithPath: audioPath3)
        
        let audioPath4  = Bundle.main.path(forResource: AudioVC.soundList[4], ofType: "mp3")!
        let audioUrl4  = URL(fileURLWithPath: audioPath4)
        
        let audioPath5  = Bundle.main.path(forResource: AudioVC.soundList[5], ofType: "mp3")!
        let audioUrl5  = URL(fileURLWithPath: audioPath5)
        
        let audioPath6 = Bundle.main.path(forResource: AudioVC.soundList[6], ofType: "mp3")!
        let audioUrl6  = URL(fileURLWithPath: audioPath6)
        
        let audioPath7  = Bundle.main.path(forResource: AudioVC.soundList[7], ofType: "mp3")!
        let audioUrl7  = URL(fileURLWithPath: audioPath7)
        
        let audioPath8 = Bundle.main.path(forResource: AudioVC.soundList[8], ofType: "mp3")!
        let audioUrl8  = URL(fileURLWithPath: audioPath8)
        
        //音声データのエラー時処理
        var audioError: NSError?
        do {
            AudioVC.audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer = nil
        }
        
        do {
            AudioVC.audioPlayer1 = try AVAudioPlayer(contentsOf: audioUrl1)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer1 = nil
        }
        
        do {
            AudioVC.audioPlayer2 = try AVAudioPlayer(contentsOf: audioUrl2)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer2 = nil
        }
        do {
            AudioVC.audioPlayer3 = try AVAudioPlayer(contentsOf: audioUrl3)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer3 = nil
        }
        do {
            AudioVC.audioPlayer4 = try AVAudioPlayer(contentsOf: audioUrl4)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer4 = nil
        }
        do {
            AudioVC.audioPlayer5 = try AVAudioPlayer(contentsOf: audioUrl5)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer5 = nil
        }
        do {
            AudioVC.audioPlayer6 = try AVAudioPlayer(contentsOf: audioUrl6)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer6 = nil
        }
        do {
            AudioVC.audioPlayer7 = try AVAudioPlayer(contentsOf: audioUrl7)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer7 = nil
        }
        do {
            AudioVC.audioPlayer8 = try AVAudioPlayer(contentsOf: audioUrl8)
        } catch let error as NSError {
            audioError = error
            AudioVC.audioPlayer8 = nil
        }
  
        
        if let error = audioError {
            print("Error\(error.localizedDescription)")
        }
        
        AudioVC.audioPlayer.delegate = self
        
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
        //cellの文字指定
        cell.setCell(sentence: sentenceView.sentence[indexPath.row], pronunciation: sentenceView.Pronunciation[indexPath.row], japanese: sentenceView.japanese[indexPath.row
        ])
        
            return cell
        }
//    セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(180)
    }
    //cellをタップした時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            AudioVC.audioPlayer.play()
        } else if indexPath.row == 1{
            AudioVC.audioPlayer1.play()
        } else if indexPath.row == 2{
            AudioVC.audioPlayer2.play()
        } else if indexPath.row == 3{
            AudioVC.audioPlayer3.play()
        } else if indexPath.row == 4{
            AudioVC.audioPlayer4.play()
        } else if indexPath.row == 5{
            AudioVC.audioPlayer5.play()
        } else if indexPath.row == 6{
            AudioVC.audioPlayer6.play()
        } else if indexPath.row == 7{
            AudioVC.audioPlayer7.play()
        } else if indexPath.row == 8{
            AudioVC.audioPlayer8.play()
        } else {
            print("ミス")
        }
    }
        
}
    
    
