import UIKit

class DailyConverViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPronounsButton()
        setupGreetingButton()
        setupDailyTalkButton()
    }
    
    
    //MARK: - Layout
    func setupPronounsButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Pronouns", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setImage(UIImage(named: "intermediate"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushPronounsButton), for: .touchUpInside)
    }
    
    func setupGreetingButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        //set layout
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Greetings", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)

        button.setImage(UIImage(named: "beginner"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushGreetingButton), for: .touchUpInside)
    }
    
    
    func setupDailyTalkButton() {
        let button:UIButton = UIButton()
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBackground
        
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 450).isActive = true
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        button.layer.cornerRadius = 25.0
        button.layer.masksToBounds = true
        
        button.setTitle("Daily Talk", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setImage(UIImage(named: "advanced"), for: .normal)
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
    
    @objc func pushPronounsButton(sender: UIButton){
        let pronounsVC = PronounsViewController(titleName: "Pronouns")
        navigationController?.pushViewController(pronounsVC, animated: true)
    }
    
    @objc func pushDailyTalkButton(sender: UIButton) {
        let dailyTalkVC = DailyTalkViewController(titleName: "Daily Talk")
        navigationController?.pushViewController(dailyTalkVC, animated: true)
    }
    
    
}
