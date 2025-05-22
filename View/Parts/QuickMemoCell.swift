import UIKit

class QuickMemoCell: UITableViewCell {
    let label = UILabel()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
    }
    
    //MARK: - Layout
    // Set up cell layout
    func setupLayout() {
        // layer
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        // contentView layer
        self.contentView.layer.cornerRadius = 16
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .systemBackground
        self.contentView.layer.borderColor = UIColor.systemGray6.cgColor
        self.contentView.layer.borderWidth = 3
        
        self.backgroundColor = .clear
     }
    
    func setupLabel() {
        label.textColor = AppColors.textColor
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
