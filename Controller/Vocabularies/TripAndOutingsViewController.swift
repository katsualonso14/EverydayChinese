import UIKit

class TripAndOutingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTripButton()
        setupRestaurantButton()
    }
    
    
    //MARK: - Layout
    func setupTripButton() {
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
        
        button.setTitle("Trip", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setImage(UIImage(named: "trip"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushTripButton), for: .touchUpInside)
    }
    
    func setupRestaurantButton() {
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
        
        button.setTitle("Restaurant", for: .normal)
        button.setTitleColor(AppColors.textColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)

        button.setImage(UIImage(named: "restaurant"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.layer.cornerRadius = 15.0
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(pushRestaurantButton), for: .touchUpInside)
    }
    
    

    //MARK: -objc
    @objc func pushTripButton(sender: UIButton){
        let tripVC = TripViewController(titleName: "Trip")
        navigationController?.pushViewController(tripVC, animated: true)
    }
    
    @objc func pushRestaurantButton(sender: UIButton){
        let restaurantVC = RestaurantViewController(titleName: "Restaurant")
        navigationController?.pushViewController(restaurantVC, animated: true)
    }
    
    
    
}
