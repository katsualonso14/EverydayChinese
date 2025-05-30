import UIKit

class QuizViewController: UIViewController {

    // MARK: - UI Components
    let questionLabel = UILabel()
    let buttons: [UIButton] = (0..<4).map { _ in UIButton(type: .system) }

    // MARK: - Quiz Data
    let questions: [(question: String, choices: [String], correctIndex: Int)] = [
            (
                NSLocalizedString("quiz_meaning_thank_you", comment: "「谢谢」の意味を尋ねるクイズ"),
                [
                    NSLocalizedString("word_sorry", comment: ""),
                    NSLocalizedString("word_thank_you", comment: ""),
                    NSLocalizedString("word_good_morning", comment: ""),
                    NSLocalizedString("word_goodbye", comment: "")
                ],
                1
            ),
        (
            NSLocalizedString("quiz_which_is_good_morning", comment: "「おはよう」はどれかを尋ねるクイズ"),
            ["晚上好", "你好", "早上好", "再见"],
            2
        ),
        (
            NSLocalizedString("quiz_which_is_she", comment: "「彼女」はどれかを尋ねるクイズ"),
            ["他", "她", "它", "你"],
            1
        ),
        (
            NSLocalizedString("quiz_which_is_how_much_is_this", comment: "「これはいくらですか？」に対応する中国語を尋ねるクイズ"),
            ["多少钱？", "这个多少钱？", "你要买这个吗？", "有别的颜色吗？"],
            1
        ),
        (
            NSLocalizedString("quiz_which_is_where", comment: "「どこ？」に対応する中国語を尋ねるクイズ"),
            ["什么时候", "哪里", "谁", "怎么"],
            1
        )
    ]


    var currentQuestionIndex = 0

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("quiz_title", comment: "")
        setupViews()
        showQuestion()
        setupResetButton()
    }

    // MARK: - Setup UI
    func setupViews() {
        questionLabel.font = UIFont.boldSystemFont(ofSize: 24)
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center

        view.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // カードのUI設定
        let row1 = UIStackView(arrangedSubviews: [buttons[0], buttons[1]])
        let row2 = UIStackView(arrangedSubviews: [buttons[2], buttons[3]])

        [row1, row2].forEach { row in
            row.axis = .horizontal
            row.spacing = 16
            row.distribution = .fillEqually
        }

        let gridStack = UIStackView(arrangedSubviews: [row1, row2])
        gridStack.axis = .vertical
        gridStack.spacing = 16
        gridStack.distribution = .fillEqually

        view.addSubview(gridStack)
        gridStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gridStack.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            gridStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            gridStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            gridStack.heightAnchor.constraint(equalToConstant: 250)
        ])


        for (i, button) in buttons.enumerated() {
            button.tag = i
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = AppColors.appMainColor
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        }

    }
    
    // MARK: - Reset Button
    func setupResetButton() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("reset_quiz", comment: ""),
            style: .plain,
            target: self,
            action: #selector(resetQuiz)
        )
        navigationItem.rightBarButtonItem?.tintColor = AppColors.appMainColor
    }

    // MARK: - Show Question
    func showQuestion() {
        guard currentQuestionIndex < questions.count else {
            questionLabel.text = "Quiz Completed!"
            buttons.forEach { $0.isHidden = true }
            return
        }

        let current = questions[currentQuestionIndex]
        questionLabel.text = current.question
        for (i, choice) in current.choices.enumerated() {
            buttons[i].setTitle(choice, for: .normal)
            buttons[i].isHidden = false
        }
    }

    // MARK: - Handle Answer
    @objc func answerTapped(_ sender: UIButton) {
        let correctIndex = questions[currentQuestionIndex].correctIndex
        let isCorrect = sender.tag == correctIndex

        let alert = UIAlertController(
            title: isCorrect ? "Correct!" : "Wrong!",
            message: isCorrect ? "Good job!" : "Correct answer: \(questions[currentQuestionIndex].choices[correctIndex])",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { _ in
            self.currentQuestionIndex += 1
            self.showQuestion()
        }))
        present(alert, animated: true)
    }
    
    // Quize Reset
    @objc func resetQuiz() {
        currentQuestionIndex = 0
        showQuestion()
    }

}
