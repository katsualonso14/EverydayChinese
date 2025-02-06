import UIKit

class PhraseStoreCell: UITableViewCell {
    
    let label = UILabel()
    let secondLabel = UILabel()
    let thirdLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.textColor = AppColors.appMainColor
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        secondLabel.textColor = .orange
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(secondLabel)
        
        thirdLabel.textColor = .systemBlue
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thirdLabel)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        secondLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        secondLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
        thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 30).isActive = true
        thirdLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
