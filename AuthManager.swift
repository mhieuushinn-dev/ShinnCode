import Foundation

enum UserRole: String {
    case owner = "Owner"
    case admin = "Admin"
    case support = "Support"
    case member = "Member"
}

class AuthManager {
    private static let credentials: [UserRole: String] = [
        .owner: "08012009",
        .admin: "00001",
        .support: "00002",
        .member: "00003"
    ]

    static func authenticate(role: UserRole, password: String) -> Bool {
        guard let expected = credentials[role] else { return false }
        return expected == password
    }
}
