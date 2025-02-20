import UIKit
import WebKit

class WebModalViewController: UIViewController {
    private let webContainer = WebViewContainer()
    var selectedWord: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        webContainer.frame = view.bounds
        // search google about selected word
        if let selectedWord = selectedWord {
            webContainer.loadURL("https://www.google.com/search?q=\(selectedWord)")
        }
        view.addSubview(webContainer)
    }

    //TODO: - Closeボタンの実装
//    private func setupCloseButton() {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
//        button.frame = CGRect(x: self.view.frame.width - 53, y: 0, width: 50, height: 50)
//        button.tintColor = AppColors.appMainColor
//        button.addTarget(self, action: #selector(close), for: .touchUpInside)
//        view.addSubview(button)
//    }
//    
//    @objc private func close() {
//        dismiss(animated: true, completion: nil)
//    }
}

