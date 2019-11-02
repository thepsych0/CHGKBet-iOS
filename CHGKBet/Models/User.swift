import Foundation

class User {
    
    static var currentUser: User?
    
    static func getCredentials() -> String? {
        return KeychainService.loadPassword(service: keychainAuthServiceName)
    }
    
    var credentials: String? {
        get {
            User.getCredentials()
        }
        set {
            guard let credentials = newValue else { return }
            KeychainService.savePassword(service: keychainAuthServiceName, data: credentials)
        }
    }
    var info: UserInfo
    
    init(credentials: String, info: UserInfo) {
        self.info = info
        self.credentials = credentials
    }
}

struct UserInfo: Codable {
    var ratingURL: String?
    var balance: Double
    var betHistory: [BetHistory]
}

private let keychainAuthServiceName = "CHGKBet.auth"
