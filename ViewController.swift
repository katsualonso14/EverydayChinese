//  ViewController.swift
//  ChineseApp
//  Created by 玉井　勝也 on 2021/06/25.
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .red
        button.setTitle("Test", for: .normal)
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }


}

