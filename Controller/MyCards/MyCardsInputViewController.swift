import UIKit

protocol MyCardsInputDelegate: AnyObject {
    func didSaveMyCards(frontText: String, backText: String)
    func editMyCards(frontText: String, backText: String)
}

class MyCardsInputViewController: UIViewController {
    
    let frontLabel = UILabel()
    let backLabel = UILabel()
    let myWordsField = UITextField()
    let sentenceField = UITextField()
    let saveButton = UIButton(type: .system)
    let separator = UIView()
    var editMode = false
    weak var delegate: MyCardsInputDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupFrontLabel()
        setupMyWordTextField()
        setupSeparator()
        
        setupBackLabel()
        setupSentenceTextField()
        saveButtonSetup()
    }
    
    func setupMyWordTextField() {
        myWordsField.placeholder = NSLocalizedString("word_placeholder", comment: "")
        myWordsField.borderStyle = .roundedRect
        view.addSubview(myWordsField)
        myWordsField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myWordsField.topAnchor.constraint(equalTo: frontLabel.bottomAnchor, constant: 8),
            myWordsField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            myWordsField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupSentenceTextField() {
        sentenceField.placeholder = NSLocalizedString("example_sentence_placeholder", comment: "")
        sentenceField.borderStyle = .roundedRect
        view.addSubview(sentenceField)
        sentenceField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sentenceField.topAnchor.constraint(equalTo: backLabel.bottomAnchor, constant: 8),
            sentenceField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sentenceField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func saveButtonSetup() {
        saveButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: sentenceField.bottomAnchor, constant: 16),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func setupSeparator() {
        separator.backgroundColor = .separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: myWordsField.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupFrontLabel() {
        frontLabel.text = NSLocalizedString("front_label", comment: "")
        frontLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(frontLabel)
        
        NSLayoutConstraint.activate([
            frontLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            frontLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }
    
    func setupBackLabel() {
        backLabel.text = NSLocalizedString("back_label", comment: "")
        backLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backLabel)
        
        NSLayoutConstraint.activate([
            backLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 20),
            backLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
    }

    @objc func saveTapped() {
        let frontText = myWordsField.text ?? ""
        let backText = sentenceField.text ?? ""
        // 単語テキストフィールドがからの場合はアラートを表示
         // ただし、バックテキストが空の場合は許容する
        if frontText.isEmpty {
            let alert = UIAlertController(
                title: NSLocalizedString("error", comment: ""),
                message: NSLocalizedString("word_seeds_error_message", comment: ""),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return // dismiss しない
        }
        
        if (editMode) {
            delegate?.editMyCards(frontText: frontText, backText: backText)
        } else {
            delegate?.didSaveMyCards(frontText: frontText, backText: backText)
        }
        
        dismiss(animated: true, completion: nil)
    }
}
