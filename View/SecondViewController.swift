//  SecondViewController.swift
//  ChineseApp

import UIKit

class SecondViewController: UIViewController {
    
    let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "Second"
        label.font = UIFont.boldSystemFont(ofSize: 70.0)
        label.textColor = UIColor.orange
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        view.backgroundColor = .white
        //falseでAotoLayoutでレイアウトが構築される
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLabel)
        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    

}
