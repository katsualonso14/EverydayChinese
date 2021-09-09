//初心者ページ
import UIKit
import SnapKit
import AVFoundation

class BiginnerViewController: UITableViewController,AVAudioPlayerDelegate {
    
    let titleName: String
    let sentenceView = SentenceViewController()
    let soundsView = SoundsViewController()
    var audioPlayer: AVAudioPlayer!
    
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
        let audioPath  = Bundle.main.path(forResource: "bell03", ofType: "mp3")!
        let audioUrl  = URL(fileURLWithPath: audioPath)
        //音声データのエラー時処理
        var audioError: NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        if let error = audioError {
            print("Error\(error.localizedDescription)")
        }
        
        audioPlayer.delegate = self
        
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
        //cellの文字
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
        print("selected")
        audioPlayer.play()
        
    }
    
    
}
