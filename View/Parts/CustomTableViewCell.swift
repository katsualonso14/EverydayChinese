//カスタムセル
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
        
        addSubview(sentenceLabel)
        addSubview(soundsLabel)
        addSubview(japaneseLabel)
        //namelabelの配置
        sentenceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        sentenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        sentenceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        sentenceLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        //soundsButtonの配置
        soundsLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        soundsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        soundsLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        //japaneseLabelの配置
        japaneseLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        japaneseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        japaneseLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -220).isActive = true // 通知ボタンと被るので途中で折り返す
        japaneseLabel.heightAnchor.constraint(equalTo: sentenceLabel.heightAnchor).isActive = true
        
        setupHeartButton()
        setupHeartButton2()
        setupHeartButton3()
        setupHeartButton4()
    }
    //    初期化
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -Layout
    //　ハートボタンの設定
    func setupHeartButton(){
        //pushTriggerButton
        let buttonImage = UIImage(named: "heart")
        heartButton.setImage(buttonImage, for: .normal)
        heartButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        // 説明ラベルの設定
        let explainLabel = UILabel()
        explainLabel.text = "Remind in 1 hour"
        explainLabel.font = UIFont.systemFont(ofSize: 17)
        explainLabel.textColor = .lightGray
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [heartButton, explainLabel])
        stackView.spacing = 10
        stackView.alignment = .leading // Set Start UI from HaertButton
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // StackViewの制約を設定
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            heartButton.widthAnchor.constraint(equalToConstant: 40),
            heartButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupHeartButton2(){
        let buttonImage = UIImage(named: "heart")
        heartButton2.setImage(buttonImage, for: .normal)
        heartButton2.addTarget(self, action: #selector(tapButton2), for: .touchUpInside)
        // 説明ラベルの設定
        let explainLabel = UILabel()
        explainLabel.text = "Remind in 3 hour"
        explainLabel.font = UIFont.systemFont(ofSize: 17)
        explainLabel.textColor = .lightGray
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [heartButton2, explainLabel])
        stackView.spacing = 10
        stackView.alignment = .leading // Set Start UI from HaertButton
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // StackViewの制約を設定
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 62),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            heartButton2.widthAnchor.constraint(equalToConstant: 40),
            heartButton2.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupHeartButton3(){
        let buttonImage = UIImage(named: "heart")
        heartButton3.setImage(buttonImage, for: .normal)
        heartButton3.addTarget(self, action: #selector(tapButton3), for: .touchUpInside)
        // 説明ラベルの設定
        let explainLabel = UILabel()
        explainLabel.text = "Remind in 1 day"
        explainLabel.font = UIFont.systemFont(ofSize: 17)
        explainLabel.textColor = .lightGray
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [heartButton3, explainLabel])
        stackView.spacing = 10
        stackView.alignment = .leading // Set Start UI from HaertButton
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // StackViewの制約を設定
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 102),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            heartButton3.widthAnchor.constraint(equalToConstant: 40),
            heartButton3.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupHeartButton4(){
        let buttonImage = UIImage(named: "heart")
        heartButton4.setImage(buttonImage, for: .normal)
        heartButton4.addTarget(self, action: #selector(tapButton4), for: .touchUpInside)
        // 説明ラベルの設定
        let explainLabel = UILabel()
        explainLabel.text = "Remind in 3 day"
        explainLabel.font = UIFont.systemFont(ofSize: 17)
        explainLabel.textColor = .lightGray
        explainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [heartButton4, explainLabel])
        stackView.spacing = 10
        stackView.alignment = .leading // Set Start UI from HaertButton
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        // StackViewの制約を設定
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 142),
            explainLabel.leadingAnchor.constraint(equalTo: heartButton.trailingAnchor, constant: 10),
            heartButton4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160),
            heartButton4.widthAnchor.constraint(equalToConstant: 40),
            heartButton4.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setCell(sentence: String, pronunciation: String , japanese: String) {
        sentenceLabel.text = sentence
        soundsLabel.text = pronunciation
        japaneseLabel.text = japanese
    }
    //MARK: -Function
    //セルのお気に入りボタンをタップしたとき処理
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
    
    //セルのお気に入りボタン2をタップしたとき処理
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
    
    //セルのお気に入りボタン3をタップしたとき処理
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
    
    //セルのお気に入りボタン4をタップしたとき処理
    @objc private func tapButton4() {
        greetingsVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200) // 3 day
        personalpronounsVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        demonstrativepronounsVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        interrogativepronounsVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        dailyConversationVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        restaurantVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        tripVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        dramaVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        shoppingVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        phoneVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        weatherVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        healthVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
        businessVC?.CustomCellTapButtonCall4(cell: self, pushTime: 259200)
    }
}
