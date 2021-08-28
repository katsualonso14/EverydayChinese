//カスタムセル
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    let sentenceLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 20)
           label.textColor = UIColor.black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    let soundsLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = UIColor.lightGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
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
        addSubview(soundsLabel)
        addSubview(japaneseLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //soundsLabelの配置
        soundsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        soundsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        soundsLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
       //japaneseLabelの配置
        japaneseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        japaneseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        japaneseLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        japaneseLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
    }
//    初期化
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(sentence: String, pronunciation: String , japanese: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
    }
}
