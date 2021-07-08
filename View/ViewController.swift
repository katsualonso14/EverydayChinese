//  ViewController.swift
//  ChineseApp

import UIKit

class ViewController: UIViewController {

    let centerLabel: UILabel = {
        let label = UILabel()
        label.text = "First"
        label.font = UIFont.boldSystemFont(ofSize: 70.0)
        label.textColor = UIColor.blue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView()
        view.backgroundColor = .white
        
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerLabel)
        NSLayoutConstraint.activate([
                                        centerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                        centerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

