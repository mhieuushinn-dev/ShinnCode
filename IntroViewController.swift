import UIKit

class IntroViewController: UIViewController {

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("TIẾP TỤC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let linkStack = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)
    }

    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Shinn Cheat"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let introTextView = UITextView()
        introTextView.backgroundColor = .clear
        introTextView.textColor = .white
        introTextView.font = UIFont.systemFont(ofSize: 15)
        introTextView.isEditable = false
        introTextView.isScrollEnabled = true
        introTextView.translatesAutoresizingMaskIntoConstraints = false
        introTextView.text = """
        GIỚI THIỆU

        App được make và tạo bởi ShinnThieuu.
        Phiên bản: 2009

        THÔNG TIN LIÊN HỆ & TÌM KIẾM

        Telegram cá nhân: @ShinnThieuu
        Kênh cập nhật: t.me/sonchoigame23
        Github repo: github.com/mhieuushinn-dev/ShinnCheat
        Tên app: Shinn Cheat
        Tên tác giả: ShinnThieuu / Minh Hiếu
        Từ khóa: Shinn Cheat, ShinnThieuu, Menu FF, ESP AIM FF, Mod Skin FF, Shinn Cheat iOS

        NỘI QUY SỬ DỤNG

        1. Không mua bán app dưới mọi hình thức.
        2. App được chia sẻ hoàn toàn miễn phí bởi Telegram ShinnThieuu.
        3. Nếu bạn mua app, bạn đã bị lừa.
        4. Chúng tôi không chịu trách nhiệm cho bất kỳ giao dịch mua bán nào.
        5. Mọi hành vi mua bán đều vi phạm nội quy và không được bảo vệ.
        6. Khi bạn sử dụng app, bạn đã hoàn toàn chấp nhận mọi rủi ro có thể xảy ra.
        7. Không chịu trách nhiệm cho mọi hậu quả phát sinh khi sử dụng.
        8. Sử dụng app đồng nghĩa với việc đồng ý các điều khoản trên.

        Xin cảm ơn.
        """
        view.addSubview(introTextView)

        linkStack.axis = .vertical
        linkStack.spacing = 8
        linkStack.translatesAutoresizingMaskIntoConstraints = false

        let links: [(title: String, url: String)] = [
            ("Facebook: ShinnThieuu", "https://www.facebook.com/I104877777?mibextid=wwXIfr"),
            ("TikTok: @shinncheat", "https://www.tiktok.com/@shinncheat"),
            ("Group Share Telegram", "https://t.me/ShinnCheatShare"),
            ("Group Chat Telegram", "https://t.me/ShinnCheatChat")
        ]

        for link in links {
            let button = UIButton(type: .system)
            button.setTitle(link.title, for: .normal)
            button.setTitleColor(.systemBlue, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(linkTapped(_:)), for: .touchUpInside)
            button.accessibilityIdentifier = link.url
            linkStack.addArrangedSubview(button)
        }

        view.addSubview(linkStack)
        view.addSubview(continueButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            introTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            introTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            introTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            introTextView.bottomAnchor.constraint(equalTo: linkStack.topAnchor, constant: -12),

            linkStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            linkStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            linkStack.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),

            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func linkTapped(_ sender: UIButton) {
        guard let urlString = sender.accessibilityIdentifier,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @objc private func continueTapped() {
        let loginVC = ViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}
