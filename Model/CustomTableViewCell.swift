//カスタムセル
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    let sentenceLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 18)
           label.textColor = UIColor.black
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    let pronunciationLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 13)
            label.textColor = UIColor.lightGray
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
        addSubview(pronunciationLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/5).isActive = true
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //pronunciationLabelの配置
        pronunciationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        pronunciationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pronunciationLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5).isActive = true
        pronunciationLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(sentence: String, pronunciation: String) {
        sentenceLabel.text = sentence
        pronunciationLabel.text = pronunciation
        
    }
}
