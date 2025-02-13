import Foundation
import UIKit

class QuickMemoViewController: UIViewController {
    let tableView = UITableView()
    let conteinerView = UIView()
    var QuickMemo = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredWords = [String]()
    var isSearching = false // 検索中かどうか判定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Quick Memo"
        setView()
        setDescriptionButton()
        setTableView()
        setAddButton()
        setupSearchController()
        // 説明ダイアログが必要か確認
        checkIsDescription()
        setRewordAdButton()
    }
    //MARK: - View Layout
    func setRewordAdButton() {
        let button = UIBarButtonItem(title: "Ads Hide Settings", style: .plain, target: self, action: #selector(showRewardAlert))
        navigationItem.rightBarButtonItem = button
    }
    
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
        self.QuickMemo = UserDefaults.standard.stringArray(forKey: "quick word") ?? []
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuickMemoCell.self, forCellReuseIdentifier: "QuickMemoCell")
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
    
    func setDescriptionButton() {
        let descriptionButton = UIButton(type: .system)
        descriptionButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        descriptionButton.tintColor = AppColors.appMainColor
        descriptionButton.addTarget(self, action: #selector(setDiscrptionView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: descriptionButton)
    }
    
    func checkIsDescription() {
        if !UserDefaults.standard.bool(forKey: "isDescription") {
            setDiscrptionView()
        }
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
    
    func getReword() {
        Task {
            await AdManager.shared.setupReword(viewController: self)
        }
    }
    
    //MARK: - Function
    @objc func addTapped() {
        //add new cell
        let aleat = UIAlertController(title: "Save Quick Memo", message: "Add word", preferredStyle: .alert)
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
                        self?.QuickMemo.append(text)
                        self?.tableView.reloadData()
                    }
                }
            }
        }))
        
        present(aleat, animated: true)
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
            self?.QuickMemo.remove(at: index)
            self?.tableView.deleteSections([index], with: .fade)
        }))
        present(alert, animated: true)
    }
    
    @objc func setDiscrptionView() {
        let explanationView = DescriptionView(frame: CGRect(x: 50, y: 170, width: 300, height: 350))
        explanationView.center = view.center
        view.addSubview(explanationView)
    }
    
    @objc func showRewardAlert() {
        let alert = UIAlertController(
            title: "Reward Ad",
            message: "If you watch the reward ad, the ad at the bottom of the screen will be hidden for 24 hours.\nWould you like to see it?",
            preferredStyle: .alert
            )

        let watchAction = UIAlertAction(title: "Watch", style: .default) { _ in
            self.getReword()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(watchAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
    
}

//MARK: - TableView DataSource
extension QuickMemoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return QuickMemo.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickMemoCell") as! QuickMemoCell
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
        // Delete button
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
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
        cell.label.text = QuickMemo[indexPath.section]
        
        return cell
    }
    
    // スワイプ処理
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete && !QuickMemo.isEmpty) {
            var currentWord = UserDefaults.standard.array(forKey: "quick word") ?? []
            currentWord.remove(at: indexPath.section)
            UserDefaults.standard.setValue(currentWord, forKey: "quick word")
            QuickMemo.remove(at: indexPath.section)
            
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
}

//MARK: - Search
extension QuickMemoViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredWords.removeAll()
        
        for (index, word) in QuickMemo.enumerated() {
            // wordsにsearchTextが含まれているかどうか
            if word.lowercased().contains(searchText.lowercased()) {
                filteredWords.append(word)
            }
        }
        tableView.reloadData()
    }
}




