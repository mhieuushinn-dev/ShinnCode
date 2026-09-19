import Foundation

struct RepoPackage: Codable {
    let identifier: String
    let name: String
    let author: String
    let version: String
    let summary: String
    let description: String
    let category: String
    let tags: [String]
    let publishedAt: String
    let download: String
    let sha256: String
    let size: Int
    let featured: Bool
    let isPrivate: Bool
    let icon: String
}

struct RepoData: Codable {
    let schemaVersion: Int
    let identifier: String
    let name: String
    let description: String
    let accentColor: String
    let icon: String
    let packages: [RepoPackage]
}

class RepoManager {
    static let mainRepoURL = "https://raw.githubusercontent.com/mhieuushinn-dev/ShinnCheat/main/Shinn%20Chest.json"
    static let subRepoURL = "https://raw.githubusercontent.com/mhieuushinn-dev/ShinnCheat/main/ShinnThieuu.json"

    static func fetchRepo(urlString: String, completion: @escaping (Result<RepoData, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "RepoManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL không hợp lệ"])))
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.cachePolicy = .reloadIgnoringLocalCacheData
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "RepoManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Không có dữ liệu"]))) }
                return
            }
            do {
                let repo = try JSONDecoder().decode(RepoData.self, from: data)
                DispatchQueue.main.async { completion(.success(repo)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }

    static func fetchRepo(for role: UserRole, completion: @escaping (Result<RepoData, Error>) -> Void) {
        let url = (role == .owner || role == .admin) ? mainRepoURL : subRepoURL
        fetchRepo(urlString: url, completion: completion)
    }
}
