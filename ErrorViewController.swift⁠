import UIKit

class ErrorViewController: UIViewController {

    private let titleText: String
    private let messageText: String

    init(title: String, message: String) {
        self.titleText = title
        self.messageText = message
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
    }

    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.textColor = .systemRed
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let messageLabel = UILabel()
        messageLabel.text = messageText
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        let exitButton = UIButton(type: .system)
        exitButton.setTitle("Thoát", for: .normal)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.backgroundColor = .systemRed
        exitButton.layer.cornerRadius = 8
        exitButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        exitButton.addTarget(self, action: #selector(exitTapped), for: .touchUpInside)
        exitButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(exitButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            exitButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.widthAnchor.constraint(equalToConstant: 160),
            exitButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func exitTapped() {
        exit(0)
    }
}
