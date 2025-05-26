import UIKit

class MyCardsCell: UITableViewCell {
    let frontView = UIView()
    let backView = UIView()
    let label = UILabel()
    let backViewLabel = UILabel()
    let backViewSubLabel = UILabel()
    
    var isFlipped = false

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFrontView()
        setupBackView()
        
        setupLabel()
        setupBackViewLabel()
        setupBackViewSubLabel()
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
    
    // Set up front view
    func setupFrontView() {
        frontView.backgroundColor = AppColors.backgroundColorCheckMode
        frontView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(frontView)
        
        frontView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        frontView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        frontView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        frontView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    // Set up back view
    func setupBackView() {
        backView.backgroundColor = AppColors.backgroundColorCheckMode
        backView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(backView)
        
        backView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        backView.isHidden = true
    }
    
    
    func setupLabel() {
        label.textColor = AppColors.textColor
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        frontView.addSubview(label)
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupBackViewLabel() {
        backViewLabel.textColor = AppColors.textColor
        //TODO: ここの挙動確認
        backViewLabel.font = backViewLabel.text?.isEmpty == false ? .boldSystemFont(ofSize: 20) : .systemFont(ofSize: 16)
        backViewLabel.numberOfLines = 0
        backViewLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(backViewLabel)
        
        backViewLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        backViewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        backViewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func setupBackViewSubLabel() {
        backViewSubLabel.textColor = AppColors.textColor
        backViewSubLabel.font = .systemFont(ofSize: 16)
        backViewSubLabel.translatesAutoresizingMaskIntoConstraints = false
        backView.addSubview(backViewSubLabel)
        
        backViewSubLabel.topAnchor.constraint(equalTo: backViewLabel.bottomAnchor, constant: 10).isActive = true
        backViewSubLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
    }
    
    // MARK: Helper
    // cellの裏返し
    func flip() {
        let fromView = isFlipped ? backView : frontView
        let toView = isFlipped ? frontView : backView

        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.6,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews],
                          completion: nil)

        isFlipped.toggle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
