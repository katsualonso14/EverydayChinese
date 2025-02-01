import Foundation
import UIKit

class PhrasesViewController: UIViewController {
    let tableView = UITableView()
    let conteinerView = UIView()
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Phrases"
        setView()
        setTableView()
        setAddButton()
    }
    //MARK: - View Layout
    func setView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(conteinerView)
        
        NSLayoutConstraint.activate([
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            conteinerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func setTableView() {
        conteinerView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none // Remove default separator

        self.words = UserDefaults.standard.stringArray(forKey: "quick word") ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhrasesCell.self, forCellReuseIdentifier: "PhrasesCell")
    }
    
    func setAddButton() {
        let addButton = UIButton()
        addButton.backgroundColor = AppColors.appMainColor

        addButton.setTitle("+", for: UIControl.State())
        addButton.setTitleColor(.white, for: UIControl.State())
        addButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        view.addSubview(addButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.1),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.02),
            addButton.widthAnchor.constraint(equalToConstant: 60),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    //MARK: - Function
    @objc func addTapped() {
        //add new cell
        let aleat = UIAlertController(title: "Quick Notes", message: "add word", preferredStyle: .alert)
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter word..."
        }
        
        aleat.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        aleat.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            // 文字がない場合はエラーメッセージ
            if aleat.textFields?.first?.text == "" || aleat.textFields?.last?.text == "" {
                let alert = UIAlertController(title: "Error", message: "Please enter word and sentence", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
                return
            }
 
            if let filed = aleat.textFields?.first {
                if let text = filed.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentWord = UserDefaults.standard.array(forKey: "quick word") ?? []
                        currentWord.append(text)
                        UserDefaults.standard.setValue(currentWord, forKey: "quick word")
                        self?.words.append(text)
                        self?.tableView.reloadData()
                    }
                }
            }
        }))
        
        present(aleat, animated: true)
    }
}


//MARK: - TableView DataSource
extension PhrasesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return words.count
    }
    // 各セクションに対して1つだけ入れるように設定(スペースのため）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //TODO: もう少し間を短くする
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        //最小限の高さを間に指定
        NSLayoutConstraint.activate([
            headerView.heightAnchor.constraint(equalToConstant: 1)
            ])
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhrasesCell") as! PhrasesCell
        // Cell design
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        cell.backgroundColor = .systemBackground
        // Background view for selection
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        selectedBackgroundView.layer.cornerRadius = 16
        selectedBackgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = selectedBackgroundView
        cell.label.text = words[indexPath.section]
        // Delete button
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal) // Trash icon
        deleteButton.tintColor = AppColors.appMainColor
        deleteButton.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)
        deleteButton.tag = indexPath.section // Set the section index as the tag
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10),
            deleteButton.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 30),
            deleteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete && !words.isEmpty) {
            var currentWord = UserDefaults.standard.array(forKey: "quick word") ?? []
            currentWord.remove(at: indexPath.section)
            UserDefaults.standard.setValue(currentWord, forKey: "quick word")
            words.remove(at: indexPath.section)
            
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
    
    @objc func deleteTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this word?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] (_) in
            // タグの判別
            let index = sender.tag
            var currentWord = UserDefaults.standard.array(forKey: "quick word") ?? []
            currentWord.remove(at: index)
            UserDefaults.standard.setValue(currentWord, forKey: "quick word")
            self?.words.remove(at: index)
            self?.tableView.deleteSections([index], with: .fade)
        }))
        present(alert, animated: true)
    }
    
}




