

import Foundation
import UIKit

class RemindListCell: UITableViewCell {
    
    let sentenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UITraitCollection.current.userInterfaceStyle == .dark ? .white : .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let soundsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let japaneseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.blue
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(sentenceLabel)
        addSubview(soundsLabel)
        addSubview(japaneseLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //soundsButtonの配置
        soundsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true
        soundsLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        //japaneseLabelの配置
        japaneseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        japaneseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        japaneseLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true
        japaneseLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(sentence: String, pronunciation: String , japanese: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
    }
}
