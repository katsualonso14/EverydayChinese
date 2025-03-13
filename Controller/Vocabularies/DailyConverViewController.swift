import UIKit

class DailyConverViewController: UIViewController {
    let sentenceVC = SentenceViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Daily Conversation"
        setupPersonalPronounsButton()
        setupDemonstrativePronounsButton()
        setupInterrogativePronounsButton()
        //TODO: Greetingの出しわけ
        setupGreetingButton()
        setupDailyTalkButton()
    }
    
    
    //MARK: - Layout
    func setupGreetingButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        //set layout
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Greetings", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)

        button.setImage(UIImage(named: "Greetings"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushGreetingButton), for: .touchUpInside)
    }
    
    func setupPersonalPronounsButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Personal Pronouns", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        let subTitleLabel = UILabel()
        subTitleLabel.text = sentenceVC.personalPronounsSentence[0] + ", " + sentenceVC.personalPronounsSentence[1] + ", " + sentenceVC.personalPronounsSentence[2] + "..."
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subTitleLabel)
        
        button.setImage(UIImage(named: "Personal Pronouns"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushPersonalPronounsButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 280),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            
            subTitleLabel.topAnchor.constraint(equalTo: button.titleLabel!.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: button.titleLabel!.leadingAnchor, constant: 0),
        ])
    }
    
    func setupDemonstrativePronounsButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Demonstrative Pronouns", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        let subTitleLabel = UILabel()
        subTitleLabel.text = sentenceVC.demonstrativePronounsSentence[0] + ", " + sentenceVC.demonstrativePronounsSentence[1] + ", " + sentenceVC.demonstrativePronounsSentence[2] + "..."
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subTitleLabel)
        
        button.setImage(UIImage(named: "Demonstrative Pronouns"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushDemonstrativePronounsButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 410),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            
            subTitleLabel.topAnchor.constraint(equalTo: button.titleLabel!.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: button.titleLabel!.leadingAnchor, constant: 0),
        ])
    }
    
    func setupInterrogativePronounsButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Interrogative Pronouns", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        let subTitleLabel = UILabel()
        subTitleLabel.text = sentenceVC.interrogativePronounsSentence[0] + ", " + sentenceVC.interrogativePronounsSentence[1] + ", " + sentenceVC.interrogativePronounsSentence[2] + "..."
        subTitleLabel.font = .systemFont(ofSize: 13)
        subTitleLabel.textColor = .systemGray
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(subTitleLabel)
        
        button.setImage(UIImage(named: "Interrogative Pronouns"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushInterrogativePronounsButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 540),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1),
            
            subTitleLabel.topAnchor.constraint(equalTo: button.titleLabel!.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: button.titleLabel!.leadingAnchor, constant: 0),
        ])
    }
    
    func setupDailyTalkButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 670).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Daily Talk", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setImage(UIImage(named: "Daily Talk"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushDailyTalkButton), for: .touchUpInside)
    }
    

    //MARK: -objc
    @objc func pushGreetingButton(sender: UIButton){
        let greetingVC = GreetingsViewController(titleName: "Greeting")
        navigationController?.pushViewController(greetingVC, animated: true)
    }
    
    @objc func pushPersonalPronounsButton(sender: UIButton){
        let pronounsVC = PersonalPronounsViewController(titleName: "Personal Pronouns")
        navigationController?.pushViewController(pronounsVC, animated: true)
    }
    
    @objc func pushDemonstrativePronounsButton(sender: UIButton){
        let pronounsVC = DemonstrativePronounsViewController(titleName: "Demonstrative Pronouns")
        navigationController?.pushViewController(pronounsVC, animated: true)
    }
    
    @objc func pushInterrogativePronounsButton(sender: UIButton){
        let pronounsVC = InterrogativePronounsViewController(titleName: "Interrogative Pronouns")
        navigationController?.pushViewController(pronounsVC, animated: true)
    }
    
    @objc func pushDailyTalkButton(sender: UIButton) {
        let dailyTalkVC = DailyTalkViewController(titleName: "Daily Talk")
        navigationController?.pushViewController(dailyTalkVC, animated: true)
    }
    
    
}
