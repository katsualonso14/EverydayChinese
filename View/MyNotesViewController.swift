import UIKit

class MyNotesViewController: UITableViewController {
    
    var words = [String]()
    var sentences = [String]()
    var isFirstViewDidLoad = false // 初回画面フラグ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.words = UserDefaults.standard.stringArray(forKey: "word") ?? []
        self.sentences = UserDefaults.standard.stringArray(forKey: "sentence") ?? []
        navigationItem.title = "MyNotes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyNotesCell.self, forCellReuseIdentifier: "MyNotesCell")
        isFirstViewDidLoad = true
    }
    
    
    //MARK: - TableView DataSource
    // テーブルビューのセクション数を返す
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isFirstViewDidLoad) {
            return 3
        } else {
            return words.count
        }
    }
    
    // テーブルビューのセルの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNotesCell") as! MyNotesCell
        
        // if epmty
        if (isFirstViewDidLoad) {
            cell.label.text = "Word: "
            cell.secondLabel.text = "Sentence: "
            return cell
        } else {
            cell.label.text = "Word: \(words[indexPath.row])"
            cell.secondLabel.text = "Sentence: \(sentences[indexPath.row])"
            return cell
        }
    }
    
    //セルの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //タップ処理
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tapped")
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete && !words.isEmpty && !sentences.isEmpty ) {
                // Word
                var currentWord = UserDefaults.standard.array(forKey: "word") ?? []
                currentWord.remove(at: indexPath.row)
                UserDefaults.standard.setValue(currentWord, forKey: "word")
                words.remove(at: indexPath.row)
                // Sentence
                var currentSentence = UserDefaults.standard.array(forKey: "sentence") ?? []
                currentSentence.remove(at: indexPath.row)
                UserDefaults.standard.setValue(currentSentence, forKey: "sentence")
                sentences.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    
    //MARK: - Function
    @objc func addTapped() {
        //add new cell
        let aleat = UIAlertController(title: "New Notes", message: "add word and sentence", preferredStyle: .alert)
        
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter word..."
        }
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter sentence..."
        }
        
        aleat.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        aleat.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            self?.isFirstViewDidLoad = false
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
                        var currentWord = UserDefaults.standard.array(forKey: "word") ?? []
                        currentWord.append(text)
                        UserDefaults.standard.setValue(currentWord, forKey: "word")
                        self?.words.append(text)
                        self?.tableView.reloadData()
                    }
                }
            }
            
            if let filed2 = aleat.textFields?.last {
                if let text2 = filed2.text, !text2.isEmpty {
                    DispatchQueue.main.async {
                        var currentSentence = UserDefaults.standard.array(forKey: "sentence") ?? []
                        currentSentence.append(text2)
                        UserDefaults.standard.setValue(currentSentence, forKey: "sentence")
                        self?.sentences.append(text2)
                        self?.tableView.reloadData()
                    }
                }
            }
            
        }))
        
        present(aleat, animated: true)
    }
}


