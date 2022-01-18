//カスタムセル
import UIKit


class CustomTableViewCell: UITableViewCell {
    
    var BiginnerVC: BiginnerViewController?
    var IntermediateVC: IntermediateViewController?
    var advancedVC: AdvancedViewController?
    var SentenceVC: SentenceViewController?
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let soundsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let japaneseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(sentenceLabel)
        addSubview(soundsButton)
        addSubview(japaneseLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //soundsButtonの配置
        soundsButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        soundsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        soundsButton.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        //japaneseLabelの配置
        japaneseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        japaneseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        japaneseLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        japaneseLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        
        //pushTriggerButton
        let button = UIButton(type: .system)
        let buttonImage = UIImage(named: "heart")
        button.setImage(buttonImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        accessoryView  = button
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    //セルのお気に入りボタンをタップしたとき処理
    @objc private func  tapButton() {
        BiginnerVC?.CustomCellTapButtonCall(cell: self)
        IntermediateVC?.CustomCellTapButtonCall(cell: self)
        advancedVC?.CustomCellTapButtonCall(cell: self)
        //通知設定
        if SentenceVC?.sentenceArray.hasFavorited == false {
            BiginnerVC?.pushRegister()
            
        } else {
            
        }
    }
    
    //    初期化
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(sentence: String, pronunciation: String , japanese: String) {
        sentenceLabel.text = sentence
        soundsButton.setTitle(pronunciation, for: UIControl.State.normal)
        japaneseLabel.text = japanese
    }
}
