import Foundation
import UIKit

class MyCardsViewController: UIViewController, MyCardsInputDelegate {
    let tableView = UITableView()
    let conteinerView = UIView()
    var myCards: [MyCard] = []
    var filteredMyCards: [MyCard] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching = false // 検索中かどうか判定
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Cards"
        setView()
        setDescriptionButton()
        setTableView()
        setAddButton()
        setResearchButton()
        setupSearchController()
        // 説明ダイアログが必要か確認
        checkIsDescription()
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
        loadFromUserDefaults()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MyCardsCell.self, forCellReuseIdentifier: "MyCardsCell")
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
    
    func setResearchButton() {
        let researchButton = UIButton()
        researchButton.backgroundColor = .systemBlue
        let searchImage = UIImage(systemName: "magnifyingglass")
        researchButton.setImage(searchImage, for: .normal)
        researchButton.tintColor = .white
        researchButton.addTarget(self, action: #selector(checkSearchWord), for: .touchUpInside)
        researchButton.layer.cornerRadius = 30
        researchButton.layer.masksToBounds = true
        view.addSubview(researchButton)
        
        researchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            researchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.frame.height * -0.19),
            researchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: view.frame.width * -0.02),
            researchButton.widthAnchor.constraint(equalToConstant: 60),
            researchButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setDescriptionButton() {
        let descriptionButton = UIButton(type: .system)
        descriptionButton.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
        descriptionButton.tintColor = AppColors.appMainColor
        // QuickMemoからの遷移は1ページ目を初期表示に設定
        let data = ["discriptNumber": 1]
        NotificationCenter.default.post(name: Notification.Name("addDescription"), object: nil, userInfo: data)
        print("send data \(data)")
        descriptionButton.addTarget(self, action: #selector(setDiscrptionView), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: descriptionButton)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("search_placeholder", comment: "")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    //MARK: - Helper Function
    func checkIsDescription() {
        if !UserDefaults.standard.bool(forKey: "isDescription") {
            setDiscrptionView()
        }
    }
    
    // メモの編集処理
    func openEditMyCard(editingCard: MyCard) {
        let modal = MyCardsInputViewController()
        modal.delegate = self
        modal.editMode = true
        modal.myWordsField.text = editingCard.word
        modal.sentenceField.text = editingCard.sentence
        present(modal, animated: true)
    }
    
    func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "myCards"),
           let decoded = try? JSONDecoder().decode([MyCard].self, from: data) {
            myCards = decoded
        }
    }

    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(myCards) {
            UserDefaults.standard.set(encoded, forKey: "myCards")
        }
    }
    
    // MARK: - MemoInputDelegate
    func didSaveMyCards(frontText: String, backText: String) {
        myCards.append(MyCard(word: frontText, sentence: backText))
        saveToUserDefaults()
        tableView.reloadData()
    }
    
    func editMyCards(frontText: String, backText: String) {
        if let index = myCards.firstIndex(where: { $0.word == frontText }) {
            myCards[index].word = frontText
            myCards[index].sentence = backText
            saveToUserDefaults()
            tableView.reloadData()
        }
    }
    // フィルター時の編集内容を即時反映
    func saveEditFilterdMyCards() {
        if isSearching, let searchText = searchController.searchBar.text {
            filteredMyCards = myCards.filter {
                $0.word.contains(searchText) || $0.sentence.contains(searchText)
            }
        }
        tableView.reloadData()
    }
    
    //MARK: - objc
    @objc func checkSearchWord() {
        let modal = SelectSearchWordModal(frame: CGRect(x: 0, y: 0, width: 300, height: 300), parentVC: self)
        modal.searchWord = myCards.map { $0.word }
        modal.center = view.center
        view.addSubview(modal)
    }

    @objc func setDiscrptionView() {
        let vc = DescriptionViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @objc func addTapped() {
        let modal = MyCardsInputViewController()
        modal.delegate = self
        present(modal, animated: true)
    }
}

//MARK: - TableView DataSource
extension MyCardsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return filteredMyCards.count
        } else {
            return myCards.count
        }
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
        return 90
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCardsCell") as! MyCardsCell
        // Background view for selection
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        selectedBackgroundView.layer.cornerRadius = 16
        selectedBackgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = selectedBackgroundView
        
        
        if isSearching {
            cell.label.text = filteredMyCards[indexPath.section].word
            cell.backViewLabel.text = filteredMyCards[indexPath.section].sentence.isEmpty ? NSLocalizedString("no_sentence", comment: "") :
            filteredMyCards[indexPath.section].sentence
        } else {
            cell.label.text = myCards[indexPath.section].word
            cell.backViewLabel.text = myCards[indexPath.section].sentence.isEmpty ? NSLocalizedString("no_sentence", comment: "") :
            myCards[indexPath.section].sentence
        }
        
        return cell
    }
    //タップ処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MyCardsCell {
            cell.flip()
        }
    }
    
    //Cellの編集と削除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集
        let editAction = UIContextualAction(style: .normal, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex =
                self.myCards.firstIndex(where: { $0.word == self.filteredMyCards.map { $0.word }[indexPath.section] }) ?? indexPath.section
                self.openEditMyCard(editingCard: self.myCards[originalIndex])
            } else {
                self.openEditMyCard(editingCard: self.myCards[indexPath.section])
            }
            completionHandler(true)
        }

        // 削除
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
            // 検索中の場合、フィルター時のインデックス指定
            if(self.isSearching) {
                let originalIndex =
                self.myCards.firstIndex(where: { $0.word == self.filteredMyCards.map { $0.word }[indexPath.section] }) ?? indexPath.section
                self.myCards.remove(at: originalIndex)
                self.filteredMyCards.remove(at: indexPath.section)
            } else {
                self.myCards.remove(at: indexPath.section)
                print("Delete myCards: \(self.myCards)")
            }
    
            self.saveToUserDefaults()
            tableView.deleteSections([indexPath.section], with: .fade) // セクションで設定しているため、セクション削除
            completionHandler(true)
        }
        
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = UIColor.systemBlue
        
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

//MARK: - Search
extension MyCardsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredMyCards.removeAll()

        for (index, card) in myCards.enumerated() {
            // wordにsearchTextが含まれているかどうか
            if card.word.lowercased().contains(searchText.lowercased()) {
                filteredMyCards.append(card)
            }
        }

        tableView.reloadData()
    }
}




