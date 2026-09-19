import UIKit

class ViewController: UIViewController {

    private let uidLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shinn Cheat"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nhập mật khẩu"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        tf.textColor = .white
        tf.layer.cornerRadius = 8
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor(white: 0.3, alpha: 1.0).cgColor
        tf.textAlignment = .center
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ĐĂNG NHẬP", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giới thiệu & Nội quy", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var selectedRole: UserRole = .member

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        uidLabel.text = "UID: \(DeviceManager.getDeviceUID())"
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    private func setupUI() {
        view.addSubview(uidLabel)
        view.addSubview(titleLabel)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(backButton)

        let roleStack = UIStackView()
        roleStack.axis = .horizontal
        roleStack.distribution = .fillEqually
        roleStack.spacing = 8
        roleStack.translatesAutoresizingMaskIntoConstraints = false

        let roles: [UserRole] = [.owner, .admin, .support, .member]
        for role in roles {
            let button = UIButton(type: .system)
            button.setTitle(role.rawValue, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            button.layer.cornerRadius = 6
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            button.addTarget(self, action: #selector(roleSelected(_:)), for: .touchUpInside)
            button.tag = roles.firstIndex(of: role) ?? 0
            roleStack.addArrangedSubview(button)
        }

        selectedRole = .member
        if let memberButton = roleStack.arrangedSubviews.last as? UIButton {
            memberButton.backgroundColor = .systemBlue
        }

        view.addSubview(roleStack)

        NSLayoutConstraint.activate([
            uidLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            uidLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            uidLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            titleLabel.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            roleStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            roleStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            roleStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            roleStack.heightAnchor.constraint(equalToConstant: 40),

            passwordField.topAnchor.constraint(equalTo: roleStack.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 48),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 48),

            backButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func roleSelected(_ sender: UIButton) {
        let roles: [UserRole] = [.owner, .admin, .support, .member]
        selectedRole = roles[sender.tag]
        if let stack = sender.superview as? UIStackView {
            for case let btn as UIButton in stack.arrangedSubviews {
                btn.backgroundColor = (btn == sender) ? .systemBlue : UIColor(white: 0.2, alpha: 1.0)
            }
        }
    }

    @objc private func loginTapped() {
        guard let password = passwordField.text, !password.isEmpty else { return }
        if AuthManager.authenticate(role: selectedRole, password: password) {
            let mainVC = MainViewController()
            mainVC.role = selectedRole
            mainVC.modalPresentationStyle = .fullScreen
            present(mainVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Lỗi", message: "Mật khẩu không đúng", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    @objc private func backTapped() {
        dismiss(animated: true, completion: nil)
    }
}
