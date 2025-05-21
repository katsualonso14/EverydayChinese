import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var greetingsVC: GreetingsViewController?
    var personalpronounsVC: PersonalPronounsViewController?
    var demonstrativepronounsVC: DemonstrativePronounsViewController?
    var interrogativepronounsVC: InterrogativePronounsViewController?
    var dailyConversationVC: DailyTalkViewController?
    var tripVC: TripViewController?
    var dramaVC: DramaViewController?
    var restaurantVC: RestaurantViewController?
    var shoppingVC: ShoppingViewController?
    var phoneVC: PhoneViewController?
    var weatherVC: WeatherViewController?
    var healthVC: HealthViewController?
    var businessVC: BusinessViewController?
    
    let containerView = UIView()
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
    
    let reviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        button.tintColor = AppColors.appMainColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showBottomModal), for: .touchUpInside)
        return button
    }()
    
    let heartButton = UIButton(type: .system)
    let heartButton2 = UIButton(type: .system)
    let heartButton3 = UIButton(type: .system)
    let heartButton4 = UIButton(type: .system)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .systemGray6
        
        setupLayout()
        setupVerticalStack()
    }
    //    初期化
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Layout
    func setupLayout() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = AppColors.backgroundColorCheckMode

         NSLayoutConstraint.activate([
             containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
             containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
             containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
             containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
         ])

        containerView.layer.cornerRadius = 12
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 4
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        // カードっぽくする
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
     }
    
    func setupVerticalStack() {
        let verticalStack = UIStackView(arrangedSubviews: [sentenceLabel, soundsLabel, japaneseLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(verticalStack)
        containerView.addSubview(reviewButton)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            verticalStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -60),

            reviewButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            reviewButton.centerYAnchor.constraint(equalTo: verticalStack.centerYAnchor)
        ])
    }
    
    func setCell(sentence: String, pronunciation: String , japanese: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
    }
    
    // リマインド設定完了のモーダルを表示
    func showRemindCompletedAlert() {
        let alert = UIAlertController(
            title: NSLocalizedString("remind_completed_title", comment: ""),
            message: NSLocalizedString("remind_completed_message", comment: ""),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // モーダルを表示
        if let viewController = self.window?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: objc
    @objc func showBottomModal() {
        let actionSheet = UIAlertController(
            title: NSLocalizedString("remind_bottom_sheet_title", comment: ""),
            message: NSLocalizedString("remind_bottom_sheet_message", comment: ""),
            preferredStyle: .actionSheet)
        // 1時間後設定
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("remind_bottom_sheet_1hour", comment: ""),style: .default, handler: { _ in
                self.tapButton()
                self.showRemindCompletedAlert()
          }))
        // 3時間後設定
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("remind_bottom_sheet_3hour", comment: ""), style: .default, handler: { _ in
                self.tapButton2()
                self.showRemindCompletedAlert()
          }))
        // 1日後設定
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("remind_bottom_sheet_1day", comment: ""), style: .default, handler: { _ in
                self.tapButton3()
                self.showRemindCompletedAlert()
          }))
          actionSheet.addAction(
            UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
          )
            if let viewController = self.window?.rootViewController {
                viewController.present(actionSheet, animated: true, completion: nil)
            }
      }
    
    @objc private func tapButton() {
        greetingsVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600) // 1 hour
        personalpronounsVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        demonstrativepronounsVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        interrogativepronounsVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        dailyConversationVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        restaurantVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        tripVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        dramaVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        shoppingVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        phoneVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        weatherVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        healthVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
        businessVC?.CustomCellTapButtonCall(cell: self, pushTime: 3600)
    }
    
    @objc private func tapButton2() {
        greetingsVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800) // 3 hour
        personalpronounsVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        demonstrativepronounsVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        interrogativepronounsVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        dailyConversationVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        restaurantVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        tripVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        dramaVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        shoppingVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        phoneVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        weatherVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        healthVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
        businessVC?.CustomCellTapButtonCall2(cell: self, pushTime: 10800)
    }
    
    @objc private func tapButton3() {
        greetingsVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400) // 1 day
        personalpronounsVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        demonstrativepronounsVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        interrogativepronounsVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        dailyConversationVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        restaurantVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        tripVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        dramaVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        shoppingVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        phoneVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        weatherVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        healthVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
        businessVC?.CustomCellTapButtonCall3(cell: self, pushTime: 86400)
    }
    
}
