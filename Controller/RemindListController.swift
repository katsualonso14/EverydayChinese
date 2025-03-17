
import UIKit
import FirebaseFirestore


class RemindListController: UITableViewController {
    var sentences: [String] = ["test1", "test2", "test3"]
    var pronunciations: [String] = ["pronunciation1", "pronunciation2", "pronunciation3"]
    var meanings: [String] = ["meaning1", "meaning2", "meaning3"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Remind List"
        setupFeedBackForm()
        setupCalendarButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RemindListCell.self, forCellReuseIdentifier: "remindCell")
    }
    
    //MARK: -Layout
    func setupFeedBackForm() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            style: .plain,
            target: self,
            action: #selector(openFeedbackModal)
        )
        navigationItem.rightBarButtonItem?.tintColor = AppColors.appMainColor
    }
    
    func setupCalendarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "calendar"),
            style: .plain,
            target: self,
            action: #selector(openCalendarModal)
        )
        navigationItem.leftBarButtonItem?.tintColor = AppColors.appMainColor
    }

    //MARK: -Function
    // Store feedback to Firestore
    func saveFeedbackToFirestore(feedback: String) {
        let db = Firestore.firestore()
        db.collection("feedbacks").addDocument(data: [
            "feedback": feedback,
            "timestamp": Timestamp(date: Date())
        ]) { error in
            if let error = error {
                print("Error saving feedback: \(error.localizedDescription)")
            } else {
                print("Feedback successfully saved!")
            }
        }
    }
    
    //MARK: -objc
    @objc func openFeedbackModal() {
        let alert = UIAlertController(title: "Feedback",
                                      message: "We would love to hear your feedback on this application. \nIf you have any feedback, please write it here and press the Submit button.",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Feedback"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            if let feedback = alert.textFields?.first?.text {
                // Save feedback to Firestore
                self.saveFeedbackToFirestore(feedback: feedback)
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func openCalendarModal() {
        let calendarVC = CalendarViewController()
        navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    //MARK: -Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "remindCell") as! RemindListCell
        cell.setCell(sentence: sentences[indexPath.row], pronunciation: pronunciations[indexPath.row], japanese: meanings[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    //TODO: タップ時に発音を
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
    
}



