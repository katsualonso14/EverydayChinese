import UIKit

class PhraseStoreViewController: UIViewController {
    let tableView = UITableView()
    let conteinerView = UIView()
    //TODO: UseDefaultsの値のみで良い場合は削除を検討
    var words = [String]()
    var sentences = [String]()
    var situation = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords = [String]()
    var filteredSentences = [String]()
    var filteredSituations = [String]()
    var isSearching = false // 検索中かどうか判定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Phrase Store"
        setView()
        setTableView()
        setAddButton()
        setupSearchController()
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
        
        self.words = UserDefaults.standard.stringArray(forKey: "word") ?? []
        self.sentences = UserDefaults.standard.stringArray(forKey: "sentence") ?? []
        self.situation = UserDefaults.standard.stringArray(forKey: "situation") ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhraseStoreCell.self, forCellReuseIdentifier: "PhraseStoreCell")
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
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Words"
        tableView.tableHeaderView = searchController.searchBar
        // Layout Setting
        tableView.tableHeaderView?.layer.cornerRadius = 16
        tableView.tableHeaderView?.layer.masksToBounds = true
        tableView.tableHeaderView?.layer.borderWidth = 5
        tableView.tableHeaderView?.layer.borderColor = UIColor.systemGray6.cgColor
        
        searchController.searchBar.backgroundImage = UIImage() // 背景を透明に設定
        searchController.searchBar.searchTextField.backgroundColor = AppColors.backgroundColorCheckMode
        definesPresentationContext = true
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
        aleat.addTextField{ (textField) in
            textField.placeholder = "Enter situation..."
        }
        
        aleat.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        aleat.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            // 文字がない場合はエラーメッセージ
            if aleat.textFields?.first?.text == "" || aleat.textFields?[1].text == "" || aleat.textFields?.last?.text == "" {
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
            
            if let filed2 = aleat.textFields?[1] {
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
            
            if let filed3 = aleat.textFields?.last {
                if let text3 = filed3.text, !text3.isEmpty {
                    DispatchQueue.main.async {
                        var currentSituation = UserDefaults.standard.array(forKey: "situation") ?? []
                        currentSituation.append(text3)
                        UserDefaults.standard.setValue(currentSituation, forKey: "situation")
                        self?.situation.append(text3)
                        self?.tableView.reloadData()
                    }
                }
            }
            
        }))
        
        present(aleat, animated: true)
    }
}


//MARK: - TableView DataSource
extension PhraseStoreViewController: UITableViewDataSource, UITableViewDelegate {
    // テーブルビューのセクション数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return min(filteredWords.count, filteredSentences.count, filteredSituations.count)
        } else {
            return min(words.count, sentences.count, situation.count)
        }
    }

    
    // テーブルビューのセルの中身
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhraseStoreCell") as! PhraseStoreCell
        // Layout Setting
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        cell.backgroundColor = .systemBackground
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.systemGray6.cgColor
        
        guard indexPath.row < (isSearching ? filteredWords.count : words.count),
              indexPath.row < (isSearching ? filteredSentences.count : sentences.count),
              indexPath.row < (isSearching ? filteredSituations.count : situation.count) else {
            return cell
        }
        
        let word = isSearching ? filteredWords[indexPath.row] : words[indexPath.row]
        let sentence = isSearching ? filteredSentences[indexPath.row] : sentences[indexPath.row]
        let situation = isSearching ? filteredSituations[indexPath.row] : situation[indexPath.row]

        cell.label.text = "Word: \(word)"
        cell.secondLabel.text = "Sentence: \(sentence)"
        cell.thirdLabel.text = "Situation: \(situation)"
        
        return cell
    }

    
    //セルの高さ
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if isSearching {
                let originalIndex = words.firstIndex(of: filteredWords[indexPath.row]) ?? indexPath.row
                words.remove(at: originalIndex)
                sentences.remove(at: originalIndex)
                situation.remove(at: originalIndex)
                
                filteredWords.remove(at: indexPath.row)
                filteredSentences.remove(at: indexPath.row)
                filteredSituations.remove(at: indexPath.row)
            } else {
                words.remove(at: indexPath.row)
                sentences.remove(at: indexPath.row)
                situation.remove(at: indexPath.row)
            }

            UserDefaults.standard.setValue(words, forKey: "word")
            UserDefaults.standard.setValue(sentences, forKey: "sentence")
            UserDefaults.standard.setValue(situation, forKey: "situation")

            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }

    
}
//MARK: - Search
extension PhraseStoreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredWords.removeAll()
        filteredSentences.removeAll()
        filteredSituations.removeAll()

        for (index, word) in words.enumerated() {
            let sentence = sentences[index]
            let situ = situation[index]

            // words, sentences, situation のどれかに検索ワードが含まれていたら追加
            if word.lowercased().contains(searchText.lowercased()) ||
               sentence.lowercased().contains(searchText.lowercased()) ||
               situ.lowercased().contains(searchText.lowercased()) {
                filteredWords.append(word)
                filteredSentences.append(sentence)
                filteredSituations.append(situ)
            }
        }
        tableView.reloadData()
    }


}




