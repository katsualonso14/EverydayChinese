
import Foundation
import UIKit


class QuickNotesViewController: UIViewController {
    let tableView = UITableView()
    let conteinerView = UIView()
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "QuickNotes"
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
        tableView.backgroundColor = .systemGray6

        self.words = UserDefaults.standard.stringArray(forKey: "quick word") ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyNotesCell.self, forCellReuseIdentifier: "MyNotesCell")
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
extension QuickNotesViewController: UITableViewDataSource, UITableViewDelegate {
    // テーブルビューのセクション数を返す
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    // テーブルビューのセルの中身
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNotesCell") as! MyNotesCell
         cell.layer.cornerRadius = 16
         cell.layer.masksToBounds = true
         cell.backgroundColor = .systemBackground
         cell.layer.borderWidth = 5
         cell.layer.borderColor = UIColor.systemGray6.cgColor
         
        cell.label.text = words[indexPath.row]
        return cell
    }
    
    //セルの高さ
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //タップ処理
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print("tapped")
    //    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete && !words.isEmpty) {
            var currentWord = UserDefaults.standard.array(forKey: "quick word") ?? []
            currentWord.remove(at: indexPath.row)
            UserDefaults.standard.setValue(currentWord, forKey: "quick word")
            words.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}




