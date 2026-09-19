import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var role: UserRole = .member

    private let tableView = UITableView()

    private let roleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var packages: [RepoPackage] = []
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        roleLabel.text = "Vai trò: \(role.rawValue) - Repo: \((role == .owner || role == .admin) ? "Chính" : "Phụ")"
        setupUI()
        loadRepo()
    }

    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = "Shinn Cheat"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Đăng xuất", for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        view.addSubview(logoutButton)

        view.addSubview(roleLabel)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PackageCell.self, forCellReuseIdentifier: "PackageCell")
        view.addSubview(tableView)

        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshRepo), for: .valueChanged)
        tableView.refreshControl = refreshControl

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            logoutButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            roleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            roleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            tableView.topAnchor.constraint(equalTo: roleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadRepo() {
        RepoManager.fetchRepo(for: role) { [weak self] result in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            switch result {
            case .success(let repo):
                self.packages = repo.packages
                self.tableView.reloadData()
            case .failure(let error):
                let alert = UIAlertController(title: "Lỗi tải repo", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }

    @objc private func refreshRepo() {
        loadRepo()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageCell", for: indexPath) as! PackageCell
        cell.configure(with: packages[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pkg = packages[indexPath.row]
        if let url = URL(string: pkg.download) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func logoutTapped() {
        dismiss(animated: true, completion: nil)
    }
}
